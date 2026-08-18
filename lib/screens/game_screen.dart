import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/game_models.dart';
import '../theme/cyber_theme.dart';
import '../utils/game_storage.dart';
import '../widgets/hex_grid_painter.dart';
import '../widgets/particle_emitter.dart';

class GameScreen extends StatefulWidget {
  final LevelModel level;

  const GameScreen({super.key, required this.level});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Gameplay State
  late List<NodeModel> _nodes;
  late HexCoords _playerCoords;
  HexCoords? _droneCoords;
  late int _maxRam;
  late int _currentRam;
  double _firewallThreat = 0.0; // 0.0 to 100.0
  int _collectedCores = 0;
  int _collectedCredits = 0;
  int _dronePatrolIndex = 0;
  bool _isGameOver = false;
  bool _isGameWon = false;

  final List<String> _terminalLogs = [];
  final ParticleController _particleController = ParticleController();
  final ScrollController _scrollController = ScrollController();

  // Upgrade bonuses
  double _jammerMultiplier = 1.0;
  int _decoyMovesLeft = 0;

  @override
  void initState() {
    super.initState();
    _initializeLevel();
  }

  void _initializeLevel() {
    // Deep copy nodes template
    _nodes = widget.level.nodes.map((n) => n.copy()).toList();
    _playerCoords = widget.level.startCoords;
    
    // Load upgrades
    final ramLvl = GameStorage.getUpgradeLevel('ram');
    _maxRam = widget.level.maxRam + (ramLvl * 2);
    _currentRam = _maxRam;

    final jammerLvl = GameStorage.getUpgradeLevel('jammer');
    _jammerMultiplier = max(0.25, 1.0 - (jammerLvl * 0.15));

    final decoyLvl = GameStorage.getUpgradeLevel('decoy');
    _decoyMovesLeft = decoyLvl > 0 ? 3 : 0;

    _firewallThreat = 0.0;
    _collectedCores = 0;
    _collectedCredits = 0;
    _isGameOver = false;
    _isGameWon = false;

    // Reset drone
    if (widget.level.dronePatrolPath.isNotEmpty) {
      _dronePatrolIndex = 0;
      _droneCoords = widget.level.dronePatrolPath[0];
    } else {
      _droneCoords = null;
    }

    _terminalLogs.clear();
    _addLog("SYSTEM INITIALIZED. NEURAL TUNNEL OPENED.");
    _addLog("TARGET: ${widget.level.codeName}");
    _addLog("RAM CACHE CAP: $_currentRam MB.");
    
    if (_decoyMovesLeft > 0) {
      _addLog("DECOY ONLINE. DRONE STANDBY READY.");
    }
  }

  void _addLog(String msg) {
    setState(() {
      _terminalLogs.add("> $msg");
    });
    // Auto-scroll terminal log to bottom
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleNodeTap(HexCoords tappedCoords, Offset tapOffset) {
    if (_isGameOver || _isGameWon) return;

    // Verify adjacent node
    final distance = _playerCoords.distanceTo(tappedCoords);
    if (distance != 1) {
      HapticFeedback.vibrate();
      _addLog("ERROR: TARGET LINK OUT OF RANGE.");
      return;
    }

    // Retrieve target node model
    final targetNodeIdx = _nodes.indexWhere((n) => n.coords == tappedCoords);
    if (targetNodeIdx == -1) return;
    final targetNode = _nodes[targetNodeIdx];

    // Move player
    HapticFeedback.selectionClick();
    setState(() {
      _playerCoords = tappedCoords;
      _currentRam--;
      targetNode.isHacked = true;
    });

    _addLog("LINKED TO NODE $tappedCoords. RAM: $_currentRam MB.");

    // Trigger node effects
    _particleController.spawn(tapOffset, CyberTheme.primaryCyan, count: 12);

    if (targetNode.type == NodeType.core) {
      HapticFeedback.heavyImpact();
      _collectedCores++;
      _collectedCredits += targetNode.coreValue;
      _addLog("DATA CORE CAPTURED! +${targetNode.coreValue} SYSTEM DATA.");
      _particleController.spawn(tapOffset, CyberTheme.successGreen, count: 20);
      setState(() {
        targetNode.type = NodeType.empty;
      });
    } else if (targetNode.type == NodeType.firewall) {
      HapticFeedback.vibrate();
      final dmg = 25.0;
      setState(() {
        _firewallThreat = min(100.0, _firewallThreat + dmg);
      });
      _addLog("WARNING: FIREWALL PENETRATED! THREAT LEVEL +$dmg%.");
      _particleController.spawn(tapOffset, CyberTheme.errorRed, count: 25);
    } else if (targetNode.type == NodeType.port) {
      HapticFeedback.mediumImpact();
      _winLevel(tapOffset);
      return;
    }

    // Process drone patrols
    _processEnemyTurn();

    // Check base game over rules
    if (_currentRam <= 0 && !_isGameWon) {
      _loseLevel("RAM DECAY. CONNECTION DEGRADED.");
    }
  }

  void _processEnemyTurn() {
    if (_isGameOver || _isGameWon) return;

    // Threat progression growth
    final growth = widget.level.baseFirewallSpeed * _jammerMultiplier;
    setState(() {
      _firewallThreat = min(100.0, _firewallThreat + growth);
    });
    _addLog("FIREWALL SCANS GROWING: +${growth.toStringAsFixed(1)}%. Current: ${_firewallThreat.toStringAsFixed(1)}%");

    if (_firewallThreat >= 100.0) {
      _loseLevel("FIREWALL ISOLATION PROTOCOLS ENGAGED.");
      return;
    }

    // Drone AI Movement
    if (_droneCoords != null && widget.level.dronePatrolPath.isNotEmpty) {
      if (_decoyMovesLeft > 0) {
        _decoyMovesLeft--;
        _addLog("DECOY SHIELD ACTIVE. DRONE SIGNATURE BLOCKED. (${_decoyMovesLeft} moves left)");
      } else {
        _dronePatrolIndex = (_dronePatrolIndex + 1) % widget.level.dronePatrolPath.length;
        setState(() {
          _droneCoords = widget.level.dronePatrolPath[_dronePatrolIndex];
        });
        _addLog("WARNING: DRONE DETECTED PATROLLING NODE $_droneCoords.");
      }

      // Check collision
      if (_droneCoords == _playerCoords) {
        HapticFeedback.vibrate();
        _loseLevel("SECURITY DRONE IDENTIFIED SYSTEM SIGNATURE.");
      }
    }
  }

  void _winLevel(Offset offset) async {
    setState(() {
      _isGameWon = true;
    });
    HapticFeedback.mediumImpact();
    _particleController.spawn(offset, CyberTheme.secondaryMagenta, count: 40);
    _addLog("EXTRACTION GATE LINKED. TRANSFERRING DATA.");
    _addLog("SUCCESS! SECURED $_collectedCredits DATA PACKETS.");

    // Write progress
    await GameStorage.addCredits(_collectedCredits);
    await GameStorage.unlockLevel(widget.level.id + 1);
  }

  void _loseLevel(String reason) {
    setState(() {
      _isGameOver = true;
    });
    HapticFeedback.vibrate();
    _addLog("ALERT: SYSTEM DISCONNECTED. $reason");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: CyberTheme.bgGradient,
        ),
        child: Stack(
          children: [
            // Safe View Layout
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: CyberTheme.primaryCyan),
                          onPressed: () {
                            HapticFeedback.selectionClick();
                            Navigator.pop(context);
                          },
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                widget.level.name,
                                style: CyberTheme.terminalTitle,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.refresh, color: CyberTheme.accentAmber),
                          onPressed: () {
                            HapticFeedback.mediumImpact();
                            setState(() {
                              _initializeLevel();
                            });
                          },
                        ),
                      ],
                    ),

                    // Game HUD (RAM / Firewall Gauges)
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        // RAM indicator
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RAM ENERGY: $_currentRam / $_maxRam MB",
                                style: CyberTheme.terminalBody.copyWith(color: CyberTheme.primaryCyan),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                height: 8,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF0F0F12),
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: CyberTheme.primaryCyan.withOpacity(0.5)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: _currentRam / _maxRam,
                                    backgroundColor: Colors.transparent,
                                    valueColor: const AlwaysStoppedAnimation(CyberTheme.primaryCyan),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 24),
                        // Firewall Alert
                        Column(
                          children: [
                            Text(
                              "FIREWALL THREAT",
                              style: CyberTheme.terminalBody.copyWith(color: CyberTheme.errorRed),
                            ),
                            Text(
                              "${_firewallThreat.toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontFamily: 'Courier',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: _firewallThreat > 75.0 ? CyberTheme.errorRed : CyberTheme.accentAmber,
                                shadows: [
                                  Shadow(
                                    color: _firewallThreat > 75.0 ? CyberTheme.errorRed : CyberTheme.accentAmber,
                                    blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Interactive Hex Hacking Grid Board
                    Expanded(
                      flex: 6,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final width = constraints.maxWidth;
                          final height = constraints.maxHeight;

                          // Auto calculate bounding box of all nodes in axial space
                          double minXUnit = double.infinity;
                          double maxXUnit = -double.infinity;
                          double minYUnit = double.infinity;
                          double maxYUnit = -double.infinity;

                          for (var node in _nodes) {
                            final xu = sqrt(3) * node.coords.q + (sqrt(3) / 2) * node.coords.r;
                            final yu = 1.5 * node.coords.r;
                            if (xu < minXUnit) minXUnit = xu;
                            if (xu > maxXUnit) maxXUnit = xu;
                            if (yu < minYUnit) minYUnit = yu;
                            if (yu > maxYUnit) maxYUnit = yu;
                          }

                          final spanX = (maxXUnit - minXUnit);
                          final spanY = (maxYUnit - minYUnit);
                          final centerXUnit = (minXUnit + maxXUnit) / 2.0;
                          final centerYUnit = (minYUnit + maxYUnit) / 2.0;

                          // Compute maximum possible radius R so that all nodes + padding fit on screen
                          final maxRx = (width * 0.88) / (spanX + 2.2);
                          final maxRy = (height * 0.88) / (spanY + 2.2);
                          final radius = min(maxRx, maxRy).clamp(16.0, 46.0);

                          final centerOffset = Offset(
                            width / 2 - centerXUnit * radius,
                            height / 2 - centerYUnit * radius,
                          );

                          return GestureDetector(
                            onTapUp: (details) {
                              final localPos = details.localPosition;
                              
                              // Detect tapped hex coordinate node
                              HexCoords? tappedCoords;
                              for (var node in _nodes) {
                                final x = radius * (sqrt(3) * node.coords.q + sqrt(3) / 2 * node.coords.r) + centerOffset.dx;
                                final y = radius * (3.0 / 2.0 * node.coords.r) + centerOffset.dy;
                                final distance = (localPos - Offset(x, y)).distance;
                                
                                if (distance <= radius * 0.95) {
                                  tappedCoords = node.coords;
                                  break;
                                }
                              }

                              if (tappedCoords != null) {
                                _handleNodeTap(tappedCoords, localPos);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: CyberTheme.cardBackground.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.grey.shade900),
                              ),
                              child: Stack(
                                children: [
                                  // Grid Painter
                                  CustomPaint(
                                    size: Size(width, height),
                                    painter: HexGridPainter(
                                      nodes: _nodes,
                                      playerCoords: _playerCoords,
                                      droneCoords: _droneCoords,
                                      dronePatrolPath: widget.level.dronePatrolPath,
                                      hexSize: radius,
                                      gridOffset: centerOffset,
                                    ),
                                  ),

                                  // Particle overlays
                                  Positioned.fill(
                                    child: ParticleEmitter(controller: _particleController),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Cyber Terminal Output Log
                    const Text(
                      "TERMINAL LOG OUTPUT:",
                      style: CyberTheme.terminalAccent,
                    ),
                    const SizedBox(height: 6),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade900),
                        ),
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: _terminalLogs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                _terminalLogs[index],
                                style: const TextStyle(
                                  color: CyberTheme.terminalGreen,
                                  fontFamily: 'Courier',
                                  fontSize: 12,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Modal HUDs for Game Over / Game Won overlay states
            if (_isGameOver || _isGameWon)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.85),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: BoxDecoration(
                        color: CyberTheme.cardBackground,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: _isGameWon ? CyberTheme.successGreen : CyberTheme.errorRed,
                          width: 2.0,
                        ),
                        boxShadow: CyberTheme.neonGlow(
                          _isGameWon ? CyberTheme.successGreen : CyberTheme.errorRed,
                          blurRadius: 10,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            _isGameWon ? Icons.verified_user : Icons.gpp_bad,
                            color: _isGameWon ? CyberTheme.successGreen : CyberTheme.errorRed,
                            size: 64,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _isGameWon ? "EXTRACTION SUCCESS" : "CONNECTION TERMINATED",
                            style: TextStyle(
                              fontFamily: 'Courier',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: _isGameWon ? CyberTheme.successGreen : CyberTheme.errorRed,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _isGameWon
                                ? "Mainframe decrypted. Gained +$_collectedCredits system credits data."
                                : "Firewall detected network node footprint. System isolated.",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'Courier',
                            ),
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  side: const BorderSide(color: Colors.white),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  HapticFeedback.selectionClick();
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "MENU",
                                  style: TextStyle(fontFamily: 'Courier', color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _isGameWon ? CyberTheme.successGreen : CyberTheme.errorRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  HapticFeedback.mediumImpact();
                                  setState(() {
                                    _initializeLevel();
                                  });
                                },
                                child: Text(
                                  _isGameWon ? "REPLAY" : "RETRY",
                                  style: const TextStyle(fontFamily: 'Courier', color: Colors.black, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

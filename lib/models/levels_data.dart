import 'dart:math';
import 'game_models.dart';

class LevelsData {
  static List<LevelModel> getLevels() {
    return [
      // STAGE 01: Subnet Bypass
      LevelModel(
        id: 1,
        name: "Stage 01",
        codeName: "SUBNET_BYPASS",
        maxRam: 15,
        baseFirewallSpeed: 4.0,
        startCoords: const HexCoords(0, 0),
        portCoords: const HexCoords(2, 0),
        nodes: [
          NodeModel(coords: const HexCoords(0, 0), type: NodeType.start, isRevealed: true, isHacked: true),
          NodeModel(coords: const HexCoords(1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 0), type: NodeType.port, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, -1), type: NodeType.core, isRevealed: true, coreValue: 50),
          NodeModel(coords: const HexCoords(1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, -1), type: NodeType.empty, isRevealed: true),
        ],
      ),

      // STAGE 02: Proxy Infiltration
      LevelModel(
        id: 2,
        name: "Stage 02",
        codeName: "PROXY_INFILTRATION",
        maxRam: 18,
        baseFirewallSpeed: 5.0,
        startCoords: const HexCoords(-1, 0),
        portCoords: const HexCoords(2, 1),
        nodes: [
          NodeModel(coords: const HexCoords(-1, 0), type: NodeType.start, isRevealed: true, isHacked: true),
          NodeModel(coords: const HexCoords(0, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 0), type: NodeType.core, isRevealed: true, coreValue: 75),
          NodeModel(coords: const HexCoords(2, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 1), type: NodeType.port, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, -1), type: NodeType.core, isRevealed: true, coreValue: 75),
        ],
      ),

      // STAGE 03: Core Harvest
      LevelModel(
        id: 3,
        name: "Stage 03",
        codeName: "CORE_HARVEST",
        maxRam: 22,
        baseFirewallSpeed: 5.5,
        startCoords: const HexCoords(-2, 0),
        portCoords: const HexCoords(2, -1),
        dronePatrolPath: [
          const HexCoords(0, 0),
          const HexCoords(1, 0),
          const HexCoords(0, 1),
        ],
        nodes: [
          NodeModel(coords: const HexCoords(-2, 0), type: NodeType.start, isRevealed: true, isHacked: true),
          NodeModel(coords: const HexCoords(-1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, 1), type: NodeType.core, isRevealed: true, coreValue: 100),
          NodeModel(coords: const HexCoords(0, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(1, -1), type: NodeType.core, isRevealed: true, coreValue: 100),
          NodeModel(coords: const HexCoords(2, -1), type: NodeType.port, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, -1), type: NodeType.empty, isRevealed: true),
        ],
      ),

      // STAGE 04: Neural Cascade
      LevelModel(
        id: 4,
        name: "Stage 04",
        codeName: "NEURAL_CASCADE",
        maxRam: 25,
        baseFirewallSpeed: 6.0,
        startCoords: const HexCoords(-2, -1),
        portCoords: const HexCoords(2, 2),
        dronePatrolPath: [
          const HexCoords(-1, 1),
          const HexCoords(0, 1),
          const HexCoords(1, 1),
          const HexCoords(0, 2),
        ],
        nodes: [
          NodeModel(coords: const HexCoords(-2, -1), type: NodeType.start, isRevealed: true, isHacked: true),
          NodeModel(coords: const HexCoords(-1, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -1), type: NodeType.core, isRevealed: true, coreValue: 125),
          NodeModel(coords: const HexCoords(1, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-2, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, 0), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 0), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 0), type: NodeType.core, isRevealed: true, coreValue: 125),
          NodeModel(coords: const HexCoords(-2, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, 2), type: NodeType.core, isRevealed: true, coreValue: 125),
          NodeModel(coords: const HexCoords(0, 2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 2), type: NodeType.port, isRevealed: true),
        ],
      ),

      // STAGE 05: Mainframe Core
      LevelModel(
        id: 5,
        name: "Stage 05",
        codeName: "MAINFRAME_CORE",
        maxRam: 28,
        baseFirewallSpeed: 6.5,
        startCoords: const HexCoords(0, -3),
        portCoords: const HexCoords(0, 3),
        dronePatrolPath: [
          const HexCoords(-1, 0),
          const HexCoords(0, 0),
          const HexCoords(1, 0),
          const HexCoords(0, 1),
          const HexCoords(-1, 1),
        ],
        nodes: [
          NodeModel(coords: const HexCoords(0, -3), type: NodeType.start, isRevealed: true, isHacked: true),
          NodeModel(coords: const HexCoords(-1, -2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, -2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-2, -1), type: NodeType.core, isRevealed: true, coreValue: 150),
          NodeModel(coords: const HexCoords(-1, -1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, -1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(2, -1), type: NodeType.core, isRevealed: true, coreValue: 150),
          NodeModel(coords: const HexCoords(-2, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-2, 1), type: NodeType.core, isRevealed: true, coreValue: 150),
          NodeModel(coords: const HexCoords(-1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 1), type: NodeType.core, isRevealed: true, coreValue: 150),
          NodeModel(coords: const HexCoords(-1, 2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 2), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 3), type: NodeType.port, isRevealed: true),
        ],
      ),

      // STAGE 06: Cyber Gateway
      LevelModel(
        id: 6,
        name: "Stage 06",
        codeName: "CYBER_GATEWAY",
        maxRam: 30,
        baseFirewallSpeed: 7.0,
        startCoords: const HexCoords(-3, 0),
        portCoords: const HexCoords(3, 0),
        dronePatrolPath: [
          const HexCoords(-1, 0),
          const HexCoords(0, -1),
          const HexCoords(1, -1),
          const HexCoords(1, 0),
          const HexCoords(0, 1),
          const HexCoords(-1, 1),
        ],
        nodes: [
          NodeModel(coords: const HexCoords(-3, 0), type: NodeType.start, isRevealed: true, isHacked: true),
          NodeModel(coords: const HexCoords(-2, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(3, 0), type: NodeType.port, isRevealed: true),
          
          NodeModel(coords: const HexCoords(-2, -1), type: NodeType.core, isRevealed: true, coreValue: 175),
          NodeModel(coords: const HexCoords(-1, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(1, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, -1), type: NodeType.core, isRevealed: true, coreValue: 175),
          
          NodeModel(coords: const HexCoords(-2, 1), type: NodeType.core, isRevealed: true, coreValue: 175),
          NodeModel(coords: const HexCoords(-1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 1), type: NodeType.core, isRevealed: true, coreValue: 175),
          
          NodeModel(coords: const HexCoords(-1, -2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, -2), type: NodeType.empty, isRevealed: true),
          
          NodeModel(coords: const HexCoords(-1, 2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 2), type: NodeType.empty, isRevealed: true),
        ],
      ),

      // STAGE 07: Quantum Firewall
      LevelModel(
        id: 7,
        name: "Stage 07",
        codeName: "QUANTUM_FIREWALL",
        maxRam: 34,
        baseFirewallSpeed: 7.5,
        startCoords: const HexCoords(0, -3),
        portCoords: const HexCoords(0, 3),
        dronePatrolPath: [
          const HexCoords(-2, 0),
          const HexCoords(-1, -1),
          const HexCoords(0, -1),
          const HexCoords(1, 0),
          const HexCoords(0, 1),
          const HexCoords(-1, 1),
        ],
        nodes: [
          NodeModel(coords: const HexCoords(0, -3), type: NodeType.start, isRevealed: true, isHacked: true),
          NodeModel(coords: const HexCoords(-1, -2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -2), type: NodeType.core, isRevealed: true, coreValue: 200),
          NodeModel(coords: const HexCoords(1, -2), type: NodeType.empty, isRevealed: true),
          
          NodeModel(coords: const HexCoords(-2, -1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, -1), type: NodeType.firewall, isRevealed: true),
          
          NodeModel(coords: const HexCoords(-2, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, 0), type: NodeType.core, isRevealed: true, coreValue: 200),
          NodeModel(coords: const HexCoords(0, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 0), type: NodeType.core, isRevealed: true, coreValue: 200),
          NodeModel(coords: const HexCoords(2, 0), type: NodeType.empty, isRevealed: true),
          
          NodeModel(coords: const HexCoords(-2, 1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 1), type: NodeType.firewall, isRevealed: true),
          
          NodeModel(coords: const HexCoords(-1, 2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 2), type: NodeType.core, isRevealed: true, coreValue: 200),
          NodeModel(coords: const HexCoords(1, 2), type: NodeType.empty, isRevealed: true),
          
          NodeModel(coords: const HexCoords(0, 3), type: NodeType.port, isRevealed: true),
        ],
      ),

      // STAGE 08: Black Hat Matrix
      LevelModel(
        id: 8,
        name: "Stage 08",
        codeName: "BLACK_HAT_MATRIX",
        maxRam: 38,
        baseFirewallSpeed: 8.0,
        startCoords: const HexCoords(-3, -1),
        portCoords: const HexCoords(3, 1),
        dronePatrolPath: [
          const HexCoords(-1, 0),
          const HexCoords(0, 0),
          const HexCoords(1, 0),
          const HexCoords(2, 0),
          const HexCoords(1, 1),
          const HexCoords(0, 1),
        ],
        nodes: [
          NodeModel(coords: const HexCoords(-3, -1), type: NodeType.start, isRevealed: true, isHacked: true),
          NodeModel(coords: const HexCoords(-2, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, -1), type: NodeType.core, isRevealed: true, coreValue: 225),
          NodeModel(coords: const HexCoords(0, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, -1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(2, -1), type: NodeType.core, isRevealed: true, coreValue: 225),
          NodeModel(coords: const HexCoords(3, -1), type: NodeType.empty, isRevealed: true),
          
          NodeModel(coords: const HexCoords(-3, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-2, 0), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(3, 0), type: NodeType.firewall, isRevealed: true),

          NodeModel(coords: const HexCoords(-3, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-2, 1), type: NodeType.core, isRevealed: true, coreValue: 225),
          NodeModel(coords: const HexCoords(-1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 1), type: NodeType.core, isRevealed: true, coreValue: 225),
          NodeModel(coords: const HexCoords(3, 1), type: NodeType.port, isRevealed: true),
        ],
      ),

      // STAGE 09: Deep Net Infiltrator
      LevelModel(
        id: 9,
        name: "Stage 09",
        codeName: "DEEP_NET_INFILTRATOR",
        maxRam: 42,
        baseFirewallSpeed: 8.5,
        startCoords: const HexCoords(0, -3),
        portCoords: const HexCoords(0, 3),
        dronePatrolPath: [
          const HexCoords(-1, -1),
          const HexCoords(0, -1),
          const HexCoords(1, 0),
          const HexCoords(1, 1),
          const HexCoords(0, 1),
          const HexCoords(-1, 0),
        ],
        nodes: [
          NodeModel(coords: const HexCoords(0, -3), type: NodeType.start, isRevealed: true, isHacked: true),
          NodeModel(coords: const HexCoords(-1, -2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -2), type: NodeType.core, isRevealed: true, coreValue: 250),
          NodeModel(coords: const HexCoords(1, -2), type: NodeType.empty, isRevealed: true),
          
          NodeModel(coords: const HexCoords(-2, -1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, -1), type: NodeType.core, isRevealed: true, coreValue: 250),
          
          NodeModel(coords: const HexCoords(-2, 0), type: NodeType.core, isRevealed: true, coreValue: 250),
          NodeModel(coords: const HexCoords(-1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 0), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 0), type: NodeType.empty, isRevealed: true),
          
          NodeModel(coords: const HexCoords(-2, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 1), type: NodeType.firewall, isRevealed: true),
          
          NodeModel(coords: const HexCoords(-1, 2), type: NodeType.core, isRevealed: true, coreValue: 250),
          NodeModel(coords: const HexCoords(0, 2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 2), type: NodeType.core, isRevealed: true, coreValue: 250),
          
          NodeModel(coords: const HexCoords(0, 3), type: NodeType.port, isRevealed: true),
        ],
      ),

      // STAGE 10: The Root Overlord
      LevelModel(
        id: 10,
        name: "Stage 10",
        codeName: "THE_ROOT_OVERLORD",
        maxRam: 45,
        baseFirewallSpeed: 9.0,
        startCoords: const HexCoords(-3, 0),
        portCoords: const HexCoords(3, 0),
        dronePatrolPath: [
          const HexCoords(-2, 0),
          const HexCoords(-1, -1),
          const HexCoords(0, -1),
          const HexCoords(1, 0),
          const HexCoords(2, 0),
          const HexCoords(1, 1),
          const HexCoords(0, 1),
          const HexCoords(-1, 1),
        ],
        nodes: [
          NodeModel(coords: const HexCoords(-3, 0), type: NodeType.start, isRevealed: true, isHacked: true),
          NodeModel(coords: const HexCoords(-2, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(-1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 0), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 0), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(3, 0), type: NodeType.port, isRevealed: true),

          NodeModel(coords: const HexCoords(-2, -1), type: NodeType.core, isRevealed: true, coreValue: 300),
          NodeModel(coords: const HexCoords(-1, -1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -1), type: NodeType.core, isRevealed: true, coreValue: 300),
          NodeModel(coords: const HexCoords(1, -1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(2, -1), type: NodeType.core, isRevealed: true, coreValue: 300),

          NodeModel(coords: const HexCoords(-2, 1), type: NodeType.core, isRevealed: true, coreValue: 300),
          NodeModel(coords: const HexCoords(-1, 1), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 1), type: NodeType.core, isRevealed: true, coreValue: 300),
          NodeModel(coords: const HexCoords(1, 1), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(2, 1), type: NodeType.core, isRevealed: true, coreValue: 300),
          NodeModel(coords: const HexCoords(-1, -2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, -2), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(1, -2), type: NodeType.empty, isRevealed: true),

          NodeModel(coords: const HexCoords(-1, 2), type: NodeType.empty, isRevealed: true),
          NodeModel(coords: const HexCoords(0, 2), type: NodeType.firewall, isRevealed: true),
          NodeModel(coords: const HexCoords(1, 2), type: NodeType.empty, isRevealed: true),
        ],
      ),
      ..._generateProceduralLevels(11, 50),
    ];
  }

  static List<LevelModel> _generateProceduralLevels(int startId, int count) {
    final List<LevelModel> generated = [];
    
    final List<String> prefixes = [
      "NEURAL", "CYBER", "PROXY", "QUANTUM", "SHADOW", "GRID", "CORE", "NODE", 
      "DATABANK", "HYPER", "ROOT", "MAINFRAME", "VECTOR", "SYNAPSE", "CRYPTO", "GHOST"
    ];
    final List<String> suffixes = [
      "BREACH", "BYPASS", "HARVEST", "OVERLORD", "CASCADE", "INTRUSION", "DECRYPT", 
      "TUNNEL", "INFILTRATOR", "GATEWAY", "MATRIX", "MINING", "ISOLATION", "INJECTOR", "STRIKE"
    ];

    final Random rand = Random(42); // seed to keep levels consistent and identical

    for (int i = 0; i < count; i++) {
      final id = startId + i;
      final pref = prefixes[rand.nextInt(prefixes.length)];
      final suff = suffixes[rand.nextInt(suffixes.length)];
      final codeName = "${pref}_${suff}_$id";

      final bool isHardcore = id >= 51;

      // RAM scales: 39 for id=11, but for hardcore stages 51-60 it is extremely tight (12-16 RAM)
      final int maxRam = isHardcore
          ? (12 + (60 - id) ~/ 2)
          : (25 + (id * 1.3).round());

      // Firewall speed scales: 7.1 for id=11, but for hardcore stages 51-60 it is extremely fast (28% to 32% speed)
      final double baseFirewallSpeed = isHardcore
          ? (28.0 + (id - 50) * 0.4)
          : (6.0 + (id * 0.1));

      // Grid generation based on ring radius
      // Let's make grid radius scale slowly from 2 (at id=11) to 3 (at id=30) to 4 (at id=60)
      final int gridRadius = 2 + (id ~/ 20).clamp(0, 2);

      // Let's gather all coords inside gridRadius
      final List<HexCoords> allGridCoords = [];
      for (int q = -gridRadius; q <= gridRadius; q++) {
        final int r1 = max(-gridRadius, -q - gridRadius);
        final int r2 = min(gridRadius, -q + gridRadius);
        for (int r = r1; r <= r2; r++) {
          allGridCoords.add(HexCoords(q, r));
        }
      }

      // Choose start and port coords at opposite edges of the grid
      HexCoords startCoords = HexCoords(-gridRadius, 0);
      HexCoords portCoords = HexCoords(gridRadius, 0);
      
      // Make sure start/port are in grid
      if (!allGridCoords.contains(startCoords)) {
        startCoords = allGridCoords.first;
      }
      if (!allGridCoords.contains(portCoords)) {
        portCoords = allGridCoords.last;
      }

      // Generate nodes
      final List<NodeModel> nodes = [];
      for (var coords in allGridCoords) {
        NodeType type = NodeType.empty;
        int coreValue = 0;

        if (coords == startCoords) {
          type = NodeType.start;
        } else if (coords == portCoords) {
          type = NodeType.port;
        } else {
          // 18% firewall chance for normal, but 35% for hardcore (heavy minefield)
          // 20% core chance for normal, but 12% for hardcore
          final double firewallChance = isHardcore ? 0.35 : 0.18;
          final double coreChance = isHardcore ? 0.12 : 0.20;

          final double val = rand.nextDouble();
          if (val < firewallChance) {
            type = NodeType.firewall;
          } else if (val < (firewallChance + coreChance)) {
            type = NodeType.core;
            coreValue = 150 + (id * 15) + (rand.nextInt(5) * 10);
          }
        }

        nodes.add(NodeModel(
          coords: coords,
          type: type,
          isRevealed: true,
          isHacked: coords == startCoords,
          coreValue: coreValue,
        ));
      }

      // Generate a circular drone patrol path of 3-5 nodes, selecting from empty/core nodes
      final List<HexCoords> dronePatrolPath = [];
      final List<HexCoords> candidateCoords = allGridCoords
          .where((c) => c != startCoords && c != portCoords)
          .toList();

      if (candidateCoords.isNotEmpty) {
        // Shuffle candidate coords using the seeded Random object
        final List<HexCoords> shuffledCandidates = List.from(candidateCoords);
        shuffledCandidates.shuffle(rand);
        final int pathLength = (3 + rand.nextInt(3)).clamp(3, shuffledCandidates.length);
        for (int p = 0; p < pathLength; p++) {
          dronePatrolPath.add(shuffledCandidates[p]);
        }
      }

      generated.add(LevelModel(
        id: id,
        name: "Stage ${id < 10 ? '0$id' : id}",
        codeName: codeName,
        maxRam: maxRam,
        baseFirewallSpeed: baseFirewallSpeed,
        nodes: nodes,
        startCoords: startCoords,
        portCoords: portCoords,
        dronePatrolPath: dronePatrolPath,
      ));
    }

    return generated;
  }
}

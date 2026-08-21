import 'package:flutter/material.dart';
import '../models/game_models.dart';
import '../theme/cyber_theme.dart';
import '../utils/game_storage.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _credits = 0;
  List<UpgradeItem> _upgrades = [];

  @override
  void initState() {
    super.initState();
    _loadShopData();
  }

  void _loadShopData() {
    setState(() {
      _credits = GameStorage.getCredits();
      _upgrades = [
        UpgradeItem(
          id: 'ram',
          name: 'RAM Expansion',
          description: 'Increases starting action capacity by +2 RAM per level.',
          baseCost: 100,
          level: GameStorage.getUpgradeLevel('ram'),
        ),
        UpgradeItem(
          id: 'jammer',
          name: 'Firewall Jammer',
          description: 'Reduces threat level growth per move by 15%.',
          baseCost: 120,
          level: GameStorage.getUpgradeLevel('jammer'),
        ),
        UpgradeItem(
          id: 'scanner',
          name: 'Node Radar Scanner',
          description: 'Increases data detection ranges to locate far-off network packet nodes.',
          baseCost: 150,
          level: GameStorage.getUpgradeLevel('scanner'),
        ),
        UpgradeItem(
          id: 'decoy',
          name: 'Signal Decoy',
          description: 'Deploy decoys. Drones start level in standby mode for 3 moves.',
          baseCost: 200,
          level: GameStorage.getUpgradeLevel('decoy'),
        ),
      ];
    });
  }

  void _purchaseUpgrade(UpgradeItem item) async {
    final cost = item.currentCost;
    if (_credits >= cost && item.level < item.maxLevel) {
      await GameStorage.addCredits(-cost);
      await GameStorage.setUpgradeLevel(item.id, item.level + 1);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Upgrade Installed: ${item.name} Lvl ${item.level + 1}',
            style: const TextStyle(color: CyberTheme.successGreen),
          ),
          backgroundColor: CyberTheme.cardBackground,
        ),
      );
      _loadShopData();
    } else if (item.level >= item.maxLevel) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'System upgrade at maximum efficiency.',
            style: TextStyle(color: CyberTheme.accentAmber),
          ),
          backgroundColor: CyberTheme.cardBackground,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Insufficient system credits. Need more data.',
            style: TextStyle(color: CyberTheme.errorRed),
          ),
          backgroundColor: CyberTheme.cardBackground,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: CyberTheme.bgGradient,
          image: DecorationImage(
            image: const AssetImage('assets/cyber_wallpaper.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.72),
              BlendMode.darken,
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Shop Header
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: CyberTheme.primaryCyan),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "System Upgrades",
                            style: CyberTheme.terminalTitle,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: CyberTheme.cardBackground,
                        border: Border.all(color: CyberTheme.successGreen),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        "$_credits Data",
                        style: const TextStyle(
                          color: CyberTheme.successGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Upgrades List
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  itemCount: _upgrades.length,
                  itemBuilder: (context, index) {
                    final item = _upgrades[index];
                    final isMax = item.level >= item.maxLevel;
                    final cost = item.currentCost;
                    final canBuy = _credits >= cost && !isMax;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: CyberTheme.cardBackground,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: canBuy ? CyberTheme.primaryCyan : Colors.grey.shade800,
                          width: 1.5,
                        ),
                        boxShadow: canBuy ? CyberTheme.neonGlow(CyberTheme.primaryCyan, blurRadius: 4) : null,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "Lvl ${item.level} / ${item.maxLevel}",
                                style: TextStyle(
                                  color: isMax ? CyberTheme.accentAmber : CyberTheme.primaryCyan,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            item.description,
                            style: CyberTheme.terminalMuted,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Level progress ticks
                              Flexible(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: List.generate(item.maxLevel, (tickIdx) {
                                      final isActive = tickIdx < item.level;
                                      return Container(
                                        margin: const EdgeInsets.only(right: 6),
                                        width: 16,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: isActive
                                              ? CyberTheme.primaryCyan
                                              : Colors.grey.shade900,
                                          border: Border.all(
                                            color: isActive ? CyberTheme.primaryCyan : Colors.grey.shade800,
                                          ),
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              
                              // Purchase Button
                              ElevatedButton(
                                onPressed: isMax ? null : () => _purchaseUpgrade(item),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: canBuy ? CyberTheme.primaryCyan : const Color(0xFF0F0F12),
                                  disabledBackgroundColor: Colors.grey.shade900,
                                  side: BorderSide(
                                    color: canBuy ? CyberTheme.primaryCyan : Colors.grey.shade800,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  isMax ? "Maxed" : "$cost Data",
                                  style: TextStyle(
                                    color: canBuy ? Colors.black : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

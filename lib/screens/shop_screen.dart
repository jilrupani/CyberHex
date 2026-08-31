import 'package:flutter/material.dart';
import '../models/game_models.dart';
import '../models/wallpaper_model.dart';
import '../theme/cyber_theme.dart';
import '../utils/app_strings.dart';
import '../utils/game_storage.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  int _credits = 0;
  int _selectedTabIndex = 0; // 0: Upgrades, 1: Wallpapers
  List<UpgradeItem> _upgrades = [];
  List<String> _unlockedWallpapers = [];
  String _selectedWallpaperId = 'matrix_cyan';

  @override
  void initState() {
    super.initState();
    _loadShopData();
  }

  void _loadShopData() {
    setState(() {
      _credits = GameStorage.getCredits();
      _selectedWallpaperId = GameStorage.getSelectedWallpaper();
      _unlockedWallpapers = GameStorage.getUnlockedWallpapers();
      _upgrades = [
        UpgradeItem(
          id: 'ram',
          name: AppStrings.upgradeName('ram'),
          description: AppStrings.upgradeDesc('ram'),
          baseCost: 100,
          level: GameStorage.getUpgradeLevel('ram'),
        ),
        UpgradeItem(
          id: 'jammer',
          name: AppStrings.upgradeName('jammer'),
          description: AppStrings.upgradeDesc('jammer'),
          baseCost: 120,
          level: GameStorage.getUpgradeLevel('jammer'),
        ),
        UpgradeItem(
          id: 'scanner',
          name: AppStrings.upgradeName('scanner'),
          description: AppStrings.upgradeDesc('scanner'),
          baseCost: 150,
          level: GameStorage.getUpgradeLevel('scanner'),
        ),
        UpgradeItem(
          id: 'decoy',
          name: AppStrings.upgradeName('decoy'),
          description: AppStrings.upgradeDesc('decoy'),
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
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Upgrade Installed: ${item.name} Lvl ${item.level + 1}',
              style: const TextStyle(color: CyberTheme.successGreen),
            ),
            backgroundColor: CyberTheme.cardBackground,
          ),
        );
      }
      _loadShopData();
    } else if (item.level >= item.maxLevel) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'System upgrade at maximum efficiency.',
              style: TextStyle(color: CyberTheme.accentAmber),
            ),
            backgroundColor: CyberTheme.cardBackground,
          ),
        );
      }
    } else {
      if (mounted) {
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
  }

  void _handleWallpaperAction(CyberWallpaper wp) async {
    final isUnlocked = _unlockedWallpapers.contains(wp.id);
    final isEquipped = _selectedWallpaperId == wp.id;

    if (isEquipped) return;

    if (isUnlocked) {
      await GameStorage.setSelectedWallpaper(wp.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Equipped Wallpaper: ${wp.name}',
              style: TextStyle(color: wp.primaryColor, fontWeight: FontWeight.bold),
            ),
            backgroundColor: CyberTheme.cardBackground,
          ),
        );
      }
      _loadShopData();
    } else {
      if (_credits >= wp.cost) {
        await GameStorage.addCredits(-wp.cost);
        await GameStorage.unlockWallpaper(wp.id);
        await GameStorage.setSelectedWallpaper(wp.id);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Theme Unlocked & Equipped: ${wp.name}',
                style: TextStyle(color: wp.primaryColor, fontWeight: FontWeight.bold),
              ),
              backgroundColor: CyberTheme.cardBackground,
            ),
          );
        }
        _loadShopData();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Insufficient data credits to unlock theme.',
                style: TextStyle(color: CyberTheme.errorRed),
              ),
              backgroundColor: CyberTheme.cardBackground,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final activeThemeColor = CyberTheme.getWallpaperPrimaryColor(_selectedWallpaperId);

    return Scaffold(
      body: Container(
        decoration: CyberTheme.getWallpaperDecoration(_selectedWallpaperId),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Shop Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: activeThemeColor),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            AppStrings.cyberMarketplace,
                            style: CyberTheme.terminalTitle.copyWith(color: activeThemeColor),
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
                        "$_credits ${AppStrings.dataCredits}",
                        style: const TextStyle(
                          color: CyberTheme.successGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Segmented Tab Selector
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: CyberTheme.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: activeThemeColor.withOpacity(0.3)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTabIndex = 0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: _selectedTabIndex == 0 ? activeThemeColor.withOpacity(0.2) : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: _selectedTabIndex == 0 ? Border.all(color: activeThemeColor) : null,
                            ),
                            child: Center(
                              child: Text(
                                AppStrings.systemUpgrades,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: _selectedTabIndex == 0 ? activeThemeColor : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTabIndex = 1),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: _selectedTabIndex == 1 ? activeThemeColor.withOpacity(0.2) : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border: _selectedTabIndex == 1 ? Border.all(color: activeThemeColor) : null,
                            ),
                            child: Center(
                              child: Text(
                                AppStrings.wallpapersThemes,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: _selectedTabIndex == 1 ? activeThemeColor : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Content Section
              Expanded(
                child: _selectedTabIndex == 0
                    ? _buildUpgradesList(activeThemeColor)
                    : _buildWallpapersList(activeThemeColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpgradesList(Color themeColor) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      itemCount: _upgrades.length,
      itemBuilder: (context, index) {
        final item = _upgrades[index];
        final isMax = item.level >= item.maxLevel;
        final cost = item.currentCost;
        final canBuy = _credits >= cost && !isMax;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CyberTheme.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: canBuy ? themeColor : Colors.grey.shade800,
              width: 1.5,
            ),
            boxShadow: canBuy ? CyberTheme.neonGlow(themeColor, blurRadius: 4) : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "Lvl ${item.level} / ${item.maxLevel}",
                    style: TextStyle(
                      color: isMax ? CyberTheme.accentAmber : themeColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                item.description,
                style: CyberTheme.terminalMuted,
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: List.generate(item.maxLevel, (tickIdx) {
                        final isActive = tickIdx < item.level;
                        return Container(
                          margin: const EdgeInsets.only(right: 6),
                          width: 14,
                          height: 7,
                          decoration: BoxDecoration(
                            color: isActive ? themeColor : Colors.grey.shade900,
                            border: Border.all(
                              color: isActive ? themeColor : Colors.grey.shade800,
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        );
                      }),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: isMax ? null : () => _purchaseUpgrade(item),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: canBuy ? themeColor : const Color(0xFF0F0F12),
                      disabledBackgroundColor: Colors.grey.shade900,
                      side: BorderSide(
                        color: canBuy ? themeColor : Colors.grey.shade800,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      isMax ? AppStrings.maxed : "$cost ${AppStrings.dataCredits}",
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
    );
  }

  Widget _buildWallpapersList(Color themeColor) {
    final wallpapers = CyberWallpaper.availableWallpapers;

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      itemCount: wallpapers.length,
      itemBuilder: (context, index) {
        final wp = wallpapers[index];
        final isUnlocked = _unlockedWallpapers.contains(wp.id);
        final isEquipped = _selectedWallpaperId == wp.id;
        final canBuy = _credits >= wp.cost && !isUnlocked;

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CyberTheme.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isEquipped
                  ? wp.primaryColor
                  : (isUnlocked ? themeColor.withOpacity(0.5) : Colors.grey.shade800),
              width: isEquipped ? 2.0 : 1.5,
            ),
            boxShadow: isEquipped ? CyberTheme.neonGlow(wp.primaryColor, blurRadius: 6) : null,
          ),
          child: Row(
            children: [
              // Theme color preview circle
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [wp.primaryColor, wp.accentColor],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                child: Center(
                  child: Icon(
                    isEquipped ? Icons.check_circle : (isUnlocked ? Icons.lock_open : Icons.lock),
                    color: Colors.black87,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Wallpaper Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wp.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isEquipped ? wp.primaryColor : Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      wp.description,
                      style: CyberTheme.terminalMuted.copyWith(fontSize: 11),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 8),

              // Action button
              ElevatedButton(
                onPressed: () => _handleWallpaperAction(wp),
                style: ElevatedButton.styleFrom(
                  backgroundColor: isEquipped
                      ? Colors.transparent
                      : (isUnlocked
                          ? themeColor
                          : (canBuy ? CyberTheme.successGreen : const Color(0xFF0F0F12))),
                  disabledBackgroundColor: Colors.grey.shade900,
                  side: BorderSide(
                    color: isEquipped
                        ? wp.primaryColor
                        : (isUnlocked ? themeColor : (canBuy ? CyberTheme.successGreen : Colors.grey.shade800)),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  isEquipped
                      ? AppStrings.equipped
                      : (isUnlocked ? AppStrings.equip : "${wp.cost} ${AppStrings.dataCredits}"),
                  style: TextStyle(
                    color: isEquipped
                        ? wp.primaryColor
                        : (isUnlocked || canBuy ? Colors.black : Colors.grey),
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

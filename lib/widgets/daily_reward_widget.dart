import 'dart:async';
import 'package:flutter/material.dart';
import '../theme/cyber_theme.dart';
import '../utils/game_storage.dart';

class DailyRewardWidget extends StatefulWidget {
  final VoidCallback onRewardClaimed;
  final Color themeColor;

  const DailyRewardWidget({
    super.key,
    required this.onRewardClaimed,
    this.themeColor = CyberTheme.primaryCyan,
  });

  @override
  State<DailyRewardWidget> createState() => _DailyRewardWidgetState();
}

class _DailyRewardWidgetState extends State<DailyRewardWidget> {
  bool _isAvailable = false;
  Timer? _timer;
  String _timeRemaining = "";

  @override
  void initState() {
    super.initState();
    _checkAvailability();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _checkAvailability());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _checkAvailability() {
    final available = GameStorage.isDailyRewardAvailable();
    final lastTime = GameStorage.getLastDailyRewardTime();
    
    if (mounted) {
      setState(() {
        _isAvailable = available;
        if (!available && lastTime > 0) {
          final nextTime = DateTime.fromMillisecondsSinceEpoch(lastTime).add(const Duration(hours: 24));
          final diff = nextTime.difference(DateTime.now());
          if (diff.isNegative) {
            _isAvailable = true;
            _timeRemaining = "";
          } else {
            final hours = diff.inHours.toString().padLeft(2, '0');
            final mins = (diff.inMinutes % 60).toString().padLeft(2, '0');
            final secs = (diff.inSeconds % 60).toString().padLeft(2, '0');
            _timeRemaining = "$hours:$mins:$secs";
          }
        }
      });
    }
  }

  void _claimReward() async {
    if (!_isAvailable) return;
    await GameStorage.addCredits(50);
    await GameStorage.setLastDailyRewardTime(DateTime.now().millisecondsSinceEpoch);
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(Icons.card_giftcard, color: CyberTheme.successGreen),
              SizedBox(width: 12),
              Text(
                "Daily Reward Claimed: +50 Data Credits!",
                style: TextStyle(color: CyberTheme.successGreen, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: CyberTheme.cardBackground,
        ),
      );
    }
    
    _checkAvailability();
    widget.onRewardClaimed();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: CyberTheme.cardBackground.withOpacity(0.9),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _isAvailable ? widget.themeColor : Colors.grey.shade800,
          width: 1.5,
        ),
        boxShadow: _isAvailable ? CyberTheme.neonGlow(widget.themeColor, blurRadius: 6) : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _isAvailable ? widget.themeColor.withOpacity(0.15) : Colors.black26,
              shape: BoxShape.circle,
              border: Border.all(
                color: _isAvailable ? widget.themeColor : Colors.grey.shade700,
              ),
            ),
            child: Icon(
              Icons.card_giftcard,
              color: _isAvailable ? widget.themeColor : Colors.grey,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Daily Data Bonus",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: _isAvailable ? Colors.white : Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _isAvailable
                      ? "Claim +50 Data Credits reward now!"
                      : "Next Bonus in: $_timeRemaining",
                  style: TextStyle(
                    fontSize: 11,
                    color: _isAvailable ? CyberTheme.successGreen : Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _isAvailable ? _claimReward : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: _isAvailable ? widget.themeColor : const Color(0xFF0F0F12),
              disabledBackgroundColor: Colors.grey.shade900,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              minimumSize: const Size(60, 32),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              _isAvailable ? "CLAIM" : "LOCKED",
              style: TextStyle(
                color: _isAvailable ? Colors.black : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

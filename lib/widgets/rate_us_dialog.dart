import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../screens/feedback_screen.dart';
import '../theme/cyber_theme.dart';
import '../utils/app_strings.dart';

class RateUsDialog extends StatefulWidget {
  final Color themeColor;

  const RateUsDialog({super.key, required this.themeColor});

  static void show(BuildContext context, Color themeColor) {
    showDialog(
      context: context,
      builder: (context) => RateUsDialog(themeColor: themeColor),
    );
  }

  @override
  State<RateUsDialog> createState() => _RateUsDialogState();
}

class _RateUsDialogState extends State<RateUsDialog> {
  int _selectedStars = 0; // Default 0 stars selected

  Future<void> _handleSubmit() async {
    if (_selectedStars == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please select a star rating first."),
          backgroundColor: CyberTheme.errorRed,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    Navigator.pop(context); // Close dialog first

    if (_selectedStars <= 3) {
      // 1, 2, or 3 stars -> Redirect to Feedback screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FeedbackScreen(initialRating: _selectedStars),
        ),
      );
    } else {
      // 4 or 5 stars -> Redirect to Play Store
      final playStoreUri = Uri.parse("https://play.google.com/store/apps/details?id=com.cyberhex.nodehacker");
      try {
        if (await canLaunchUrl(playStoreUri)) {
          await launchUrl(playStoreUri, mode: LaunchMode.externalApplication);
        } else {
          await launchUrl(playStoreUri);
        }
      } catch (e) {
        debugPrint("Could not launch Play Store URL: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: CyberTheme.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: widget.themeColor, width: 2.0),
          boxShadow: CyberTheme.neonGlow(widget.themeColor, blurRadius: 10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.star_rounded,
              color: widget.themeColor,
              size: 54,
            ),
            const SizedBox(height: 12),
            Text(
              AppStrings.rateTitle,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: widget.themeColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.rateDesc,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),

            // 5 Interactive Stars
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                final starIndex = index + 1;
                final isSelected = starIndex <= _selectedStars;
                return IconButton(
                  iconSize: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    isSelected ? Icons.star_rounded : Icons.star_outline_rounded,
                    color: isSelected ? widget.themeColor : Colors.grey.shade600,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedStars = starIndex;
                    });
                  },
                );
              }),
            ),
            const SizedBox(height: 24),

            // Action Buttons: Cancel and Submit
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey.shade700),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      AppStrings.cancel,
                      style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.themeColor,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: _handleSubmit,
                    child: Text(
                      _selectedStars <= 3 ? AppStrings.feedback.toUpperCase() : "SUBMIT",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

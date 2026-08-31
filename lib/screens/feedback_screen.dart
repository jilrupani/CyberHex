import 'package:flutter/material.dart';
import '../services/feedback_service.dart';
import '../theme/cyber_theme.dart';
import '../utils/app_strings.dart';
import '../utils/game_storage.dart';

class FeedbackScreen extends StatefulWidget {
  final int? initialRating;

  const FeedbackScreen({super.key, this.initialRating});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _messageController = TextEditingController();
  
  String _selectedCategoryId = 'not_working';
  bool _isSubmitting = false;
  Color _themeColor = CyberTheme.primaryCyan;

  @override
  void initState() {
    super.initState();
    _loadTheme();
    AppStrings.languageNotifier.addListener(_onLanguageChanged);
  }

  @override
  void dispose() {
    AppStrings.languageNotifier.removeListener(_onLanguageChanged);
    _messageController.dispose();
    super.dispose();
  }

  void _onLanguageChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _loadTheme() async {
    final wallpaperId = await GameStorage.getSelectedWallpaper();
    if (mounted) {
      setState(() {
        _themeColor = CyberTheme.getWallpaperPrimaryColor(wallpaperId);
      });
    }
  }

  Map<String, String> get _categoryOptions => {
        'not_working': AppStrings.fbOptNotWorking,
        'lag': AppStrings.fbOptLag,
        'controls': AppStrings.fbOptControls,
        'audio': AppStrings.fbOptAudio,
        'level': AppStrings.fbOptLevel,
        'other': AppStrings.fbOptOther,
      };

  Future<void> _handleSubmit() async {
    FocusScope.of(context).unfocus();

    final message = _messageController.text.trim();
    if (message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter feedback details."),
          backgroundColor: CyberTheme.errorRed,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final categoryLabel = _categoryOptions[_selectedCategoryId] ?? AppStrings.fbOptOther;

    final success = await FeedbackService.submitFeedback(
      category: categoryLabel,
      message: message,
      rating: widget.initialRating,
    );

    if (!mounted) return;

    setState(() {
      _isSubmitting = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: CyberTheme.successGreen),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  AppStrings.feedbackSuccessToast,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          backgroundColor: CyberTheme.cardBackground,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = _categoryOptions;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/cyber_wallpaper.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF0A0A10)),
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.85)),
          ),
          SafeArea(
            child: Column(
              children: [
                // Top Bar Header
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: _themeColor),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        AppStrings.feedback,
                        style: CyberTheme.terminalTitle.copyWith(fontSize: 20, color: _themeColor),
                      ),
                    ],
                  ),
                ),

                // Form content
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Optional Star Rating Banner if redirected from Rate Us
                        if (widget.initialRating != null) ...[
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: CyberTheme.cardBackground,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: CyberTheme.accentAmber.withOpacity(0.6), width: 1.5),
                              boxShadow: CyberTheme.neonGlow(CyberTheme.accentAmber, blurRadius: 4),
                            ),
                            child: Row(
                              children: [
                                Row(
                                  children: List.generate(
                                    5,
                                    (i) => Icon(
                                      (i + 1) <= (widget.initialRating ?? 0) ? Icons.star_rounded : Icons.star_outline_rounded,
                                      color: (i + 1) <= (widget.initialRating ?? 0) ? CyberTheme.accentAmber : Colors.grey.shade700,
                                      size: 20,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    "${widget.initialRating} Stars Rating - Share feedback",
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],

                        // Category Label (Title: "Feedback Type")
                        Text(
                          AppStrings.feedbackCategoryLabel,
                          style: CyberTheme.terminalAccent.copyWith(color: _themeColor, fontSize: 13),
                        ),
                        const SizedBox(height: 8),

                        // Dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: CyberTheme.cardBackground,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: _themeColor.withOpacity(0.5)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: options.containsKey(_selectedCategoryId) ? _selectedCategoryId : options.keys.first,
                              isExpanded: true,
                              dropdownColor: CyberTheme.cardBackground,
                              icon: Icon(Icons.arrow_drop_down, color: _themeColor),
                              items: options.entries.map((entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.key,
                                  child: Text(
                                    entry.value,
                                    style: const TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() {
                                    _selectedCategoryId = val;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Feedback detail input
                        TextField(
                          controller: _messageController,
                          maxLines: 5,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: AppStrings.feedbackMessageHint,
                            hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                            filled: true,
                            fillColor: CyberTheme.cardBackground,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.grey.shade800),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: _themeColor, width: 1.5),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Submit Button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _themeColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 4,
                            ),
                            onPressed: _isSubmitting ? null : _handleSubmit,
                            child: _isSubmitting
                                ? const CircularProgressIndicator(color: Colors.black)
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.send_rounded, color: Colors.black, size: 20),
                                      const SizedBox(width: 10),
                                      Text(
                                        AppStrings.submitFeedback,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

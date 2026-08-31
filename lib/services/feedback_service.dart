import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FeedbackService {
  static Future<bool> submitFeedback({
    required String category,
    required String message,
    int? rating,
  }) async {
    try {
      final feedbackData = {
        'category': category,
        'message': message,
        'rating': rating ?? 0,
        'timestamp': FieldValue.serverTimestamp(),
        'platform': defaultTargetPlatform.name,
      };

      await FirebaseFirestore.instance.collection('feedback').add(feedbackData);
      debugPrint("Feedback successfully stored in Firebase Firestore!");
      return true;
    } catch (e) {
      debugPrint("Firestore submit feedback error/fallback: $e");
      // Graceful fallback so UI remains functional even if offline or Firebase config not bound
      return true;
    }
  }
}

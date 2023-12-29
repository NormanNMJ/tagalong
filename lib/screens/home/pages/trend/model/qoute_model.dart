// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import 'package:timeago/timeago.dart' as timeago;

class QuoteModel {
  String profileImage;
  String firstName;
  String otherName;
  DateTime timeAgo;
  String quote;
  int likesCount;
  int commentCount;
  int repostCount;
  int shareCount;
  int starCount;
  String username;
  String quoteId;
  Timestamp createdAt;

  QuoteModel({
    required this.profileImage,
    required this.firstName,
    required this.otherName,
    required this.timeAgo,
    required this.quote,
    required this.likesCount,
    required this.commentCount,
    required this.repostCount,
    required this.shareCount,
    required this.starCount,
    required this.username,
    required this.quoteId,
    required this.createdAt,
  });

  // Factory method to create a QuoteModel instance from a map
  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      profileImage: map['profileImage'] ?? '',
      firstName: map['firstName'] ?? '',
      otherName: map['otherName'] ?? '',
      timeAgo: DateTime.parse(map['timeAgo'] ?? ''),
      quote: map['quote'] ?? '',
      likesCount: map['likesCount'] ?? 0,
      commentCount: map['commentCount'] ?? 0,
      repostCount: map['repostCount'] ?? 0,
      shareCount: map['shareCount'] ?? 0,
      starCount: map['starCount'] ?? 0,
      username: map['username'] ?? '',
      quoteId: map['quoteId'] ?? '',
      createdAt: map['createdAt'] ?? '',
    );
  }

  // Convert the QuoteModel instance to a map
  Map<String, dynamic> toMap() {
    return {
      'profileImage': profileImage,
      'firstName': firstName,
      'otherName': otherName,
      'timeAgo': timeAgo,
      'quote': quote,
      'likesCount': likesCount,
      'commentCount': commentCount,
      'repostCount': repostCount,
      'shareCount': shareCount,
      'starCount': starCount,
      'username': username,
      'quoteId': quoteId,
    };
  }

  // Method to upload a quote to Firebase
  static Future<void> uploadQuote({
    required String currentUserId,
    required String postContent,
    required String visibility,
    required String profileImage,
    required String firstName,
    required String otherName,
    required String username,
  }) async {
    try {
      // Generate a random Quote ID
      String quoteId = generateQuoteId();

      // Create a new document in the 'quotes' collection
      await FirebaseFirestore.instance.collection('quotes').doc(quoteId).set({
        'profileImage': profileImage,
        'firstName': firstName,
        'otherName': otherName,
        'timeAgo': DateTime.now().toUtc().toString(),
        'quote': postContent,
        'likesCount': 0,
        'commentCount': 7,
        'repostCount': 0,
        'shareCount': 0,
        'starCount': 0,
        'username': username,
        'quoteId': quoteId,
      });

      print('Quote uploaded successfully!');
    } catch (e) {
      print('Error uploading quote: $e');
    }
  }

  // Helper method to generate a random Quote ID
  static String generateQuoteId() {
    // Use uuid package to generate a unique ID
    const uuid = Uuid();
    return uuid.v4();
  }

  String formattedTimeAgo() {
    return timeago.format(timeAgo, locale: 'en_short'); // Format time ago
  }
}

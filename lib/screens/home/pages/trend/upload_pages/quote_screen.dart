// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../../../manager/user_manager.dart';
import '../../../../profile/model/profile_model.dart';
import '../../../root_screen.dart';


class QuoteUploadScreen extends StatefulWidget {
  const QuoteUploadScreen({super.key});

  @override
  State<QuoteUploadScreen> createState() => _QuoteUploadScreenState();
}

class _QuoteUploadScreenState extends State<QuoteUploadScreen> {
  String visibility = 'Public';

  String? currentUserId = UserManager().currentUserId;
  UserProfileModel? userProfile = UserManager().userProfile;

  TextEditingController postController = TextEditingController();

  void createPost() async {
    String postContent = postController.text.trim();

    if (postContent.isEmpty || postContent.length > 250) {
      // Show an error message if the content is empty or exceeds 250 characters
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Post content must not be empty and should not exceed 250 characters.'),
        ),
      );
      return;
    }

    // Generate a random Quote ID
    String quoteId = generateQuoteId();

    //Create a new document in the 'quotes' collection
    await FirebaseFirestore.instance.collection('quotes').doc(quoteId).set({
      'profileImage': userProfile!.profileImage,
      'firstName': userProfile!.firstName,
      'otherName': userProfile!.otherName,
      'timeAgo': DateTime.now().toUtc().toString(),
      'quote': postContent,
      'likesCount': 0,
      'commentCount': 7,
      'repostCount': 0,
      'shareCount': 0,
      'starCount': 0,
      'username': userProfile!.username,
      'quoteId': quoteId,
      'createdAt': Timestamp.now(),
      'userId': currentUserId,
    });

    // Clear the text field after posting
    postController.clear();

    // Close the bottom sheet
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const RootScreen(),
      ),
      (route) => false, // This condition removes all previous routes
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Quote',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          FilledButton(
            style: const ButtonStyle(),
            onPressed: createPost,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Post',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16.0),
              TextField(
                controller: postController,
                maxLines: 7,
                decoration: const InputDecoration(
                  hintText: 'Type your post here...',
                  border: OutlineInputBorder(),
                ),
                maxLength: 250,
              ),
              const SizedBox(height: 16.0),
              const Text('Tag Friends'),
              // Add a section for tagging friends here
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text('Visibility:'),
                  const SizedBox(width: 8.0),
                  DropdownButton<String>(
                    value: visibility,
                    onChanged: (String? value) {
                      setState(() {
                        visibility = value ?? 'Public';
                      });
                    },
                    items: <String>['Public', 'Private']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to generate a random Quote ID
  String generateQuoteId() {
    // Use uuid package to generate a unique ID
    const uuid = Uuid();
    return uuid.v4();
  }
}

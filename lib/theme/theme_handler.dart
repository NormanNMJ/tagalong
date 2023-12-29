// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'themenotifier.dart';

class ThemeUpdater {
  static void toggleTheme(BuildContext context) async {
    // 1. Fetch the current theme preference value from Firebase
    bool isFirebaseDarkModeEnabled = await getThemePreferenceFromFirebase(context);

    // 2. Update the theme locally using Provider
    Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();

    // 3. Update the theme preference value on Firebase if it has changed
    updateThemePreferenceOnFirebase(context, isFirebaseDarkModeEnabled);
  }

  static Future<bool> getThemePreferenceFromFirebase(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Fetch the current theme preference value from Firebase
      DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      return userData['isDarkModeEnabled'] ?? false;
    }

    return false;
  }

  static void updateThemePreferenceOnFirebase(
    BuildContext context,
    bool isFirebaseDarkModeEnabled,
  ) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      bool isLocalDarkModeEnabled =
          Provider.of<ThemeNotifier>(context, listen: false).isDarkMode;

      // Check if the local and Firebase theme values are different
      if (isLocalDarkModeEnabled != isFirebaseDarkModeEnabled) {
        // Update the theme preference value on Firebase
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'isDarkModeEnabled': isLocalDarkModeEnabled})
            .then((_) {
          print('Theme preference updated on Firebase');
        })
        .catchError((error) {
          print('Error updating theme preference on Firebase: $error');
        });
      }
    }
  }
}

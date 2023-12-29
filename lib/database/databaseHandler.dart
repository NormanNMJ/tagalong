// ignore_for_file: use_build_context_synchronously, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../reusable_widgets/loadingindicator.dart';
import '../reusable_widgets/snackbar.dart';
import '../utils/user_location.dart';
import '../screens/home/root_screen.dart';
import '../screens/intro/welcome_screen.dart';

class LoginUser {
  static proceedToLogin(
    BuildContext context,
    String email,
    String password,
  ) async {
    try {
      // Show loading indicator
      LoadingOverlay.showLoading(context);

      // Use FirebaseAuth to sign in with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const RootScreen(),
        ),
        (route) => false, // This condition removes all previous routes
      );

      // If login is successful, show success snackbar and navigate to the root screen
      ReusableSnackBar.showSuccessSnackBar(context, "Logged In Successfully");
    } on FirebaseAuthException catch (e) {
      // Handle different Firebase Authentication exceptions
      if (e.code == 'user-not-found') {
        ReusableSnackBar.showErrorSnackBar(context, 'User not found.');
      } else if (e.code == 'wrong-password') {
        ReusableSnackBar.showErrorSnackBar(context, 'Wrong password provided.');
      } else {
        ReusableSnackBar.showErrorSnackBar(
            context, 'Authentication failed. ${e.message}');
      }
    } catch (e) {
      // Handle other errors
      ReusableSnackBar.showErrorSnackBar(context, 'Error: $e');
    } finally {
      // Hide loading indicator
      LoadingOverlay.hideLoading(context);
    }
  }
}

class RegisterUser {
  static Future<void> proceedToRegisterUser(
    BuildContext context,
    String firstName,
    String otherName,
    String email,
    String password,
    String bio,
    String dob,
    
  ) async {
    try {
      // Show loading indicator
      LoadingOverlay.showLoading(context);
      // Create user with email and password
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

     

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        LocationService locationService = LocationService();
        Position? currentPosition = await locationService.getCurrentPosition();

        if (currentPosition != null) {
          // print('Latitude: ${currentPosition.latitude}');
          // print('Longitude: ${currentPosition.longitude}');

          String? address = await locationService.getAddressFromCoordinates(
            currentPosition.latitude,
            currentPosition.longitude,
          );

          // Save additional user details to Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({
            'firstName': firstName,
            'otherName': otherName,
            'email': email,
            'password': password,
            'dob': dob,
            'location': address,
            'readtermsandcondition': true,
            'occupation': '',
            'bio': bio,
            'profileImage': '',
            'accountcreation': Timestamp.now(),
            // Add more user details as needed
          });

          // Navigate to the next screen or perform other actions after successful registration
          // For example, you can use Navigator.push() to go to the home screen.
          await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const RootScreen(),
            ),
            (route) => false, // This condition removes all previous routes
          );

          ReusableSnackBar.showSuccessSnackBar(context, 'Sign In Successfully');
        }
      }
    } catch (error) {
      // Handle registration errors, show error messages or take appropriate action
      ReusableSnackBar.showErrorSnackBar(context, 'Error: $error');
    } finally {
      // Hide loading indicator
      LoadingOverlay.hideLoading(context);
    }
  }
}

class SignOutUser {
  static Future<void> proceedToSignOutUser(
    BuildContext context,
  ) async {
    try {
      // Show loading indicator if needed
      LoadingOverlay.showLoading(context);

      await FirebaseAuth.instance.signOut();

      // Navigate to the WelcomeScreen and remove all previous routes
      await Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
        (route) => false, // This condition removes all previous routes
      );
    } catch (e) {
      ReusableSnackBar.showErrorSnackBar(context, 'Error: $e');
    } finally {
      // Hide loading indicator if needed
      // LoadingOverlay.hideLoading(context);
    }
  }
}

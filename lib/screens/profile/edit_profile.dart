// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../animation/slide_in_animation.dart';
import '../../constants/size_config.dart';
import '../../reusable_widgets/button.dart';
import '../../reusable_widgets/containerborder.dart';
import '../../reusable_widgets/loadingindicator.dart';
import '../../reusable_widgets/page_navigator.dart';
import '../../reusable_widgets/snackbar.dart';
import '../../reusable_widgets/textfields.dart';
import '../../utils/user_location.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final User? user;

  late final TextEditingController firstNameController;
  late final TextEditingController otherNameController;
  late final TextEditingController emailController;
  late final TextEditingController bioController;
  late final TextEditingController dobController;
  late final TextEditingController occupationController;
  XFile? _imageFile; // Variable to store the selected image file

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) {
      return; // No image selected
    }

    LoadingOverlay.showLoading(context);

    try {
      final firebase_storage.Reference storageReference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('user_images/${user!.uid}.jpg');

      await storageReference.putFile(File(_imageFile!.path));

      // Get the download URL of the uploaded image
      String downloadURL = await storageReference.getDownloadURL();

      // Update user data in Firebase with the download URL
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'profileImage': downloadURL,
        // Add more fields as needed
      });

      LoadingOverlay.hideLoading(context);
      ReusableSnackBar.showSuccessSnackBar(
          context, 'Profile image updated successfully');
    } catch (error) {
      print('Error uploading image: $error');
      LoadingOverlay.hideLoading(context);
      ReusableSnackBar.showErrorSnackBar(
          context, 'Error updating profile image');
    }
  }

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    firstNameController = TextEditingController();
    otherNameController = TextEditingController();
    emailController = TextEditingController();
    bioController = TextEditingController();
    occupationController = TextEditingController();
    // Fetch user data and populate the controllers
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Fetch user data from Firebase and populate the controllers
    try {
      DocumentSnapshot<Map<String, dynamic>> userData = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user!.uid)
          .get();

      setState(() {
        firstNameController.text = userData['firstName'];
        otherNameController.text = userData['otherName'];
        emailController.text = userData['email'];
        bioController.text = userData['bio'];
        occupationController.text = userData['occupation'];
        dobController.text = userData['dob'];
      });
    } catch (error) {
      ('Error fetching user data: $error');
    }
  }

  Future<void> saveChanges() async {
    LoadingOverlay.showLoading(context);
    try {
      // Fetch updated location
      LocationService locationService = LocationService();
      Position? currentPosition = await locationService.getCurrentPosition();
      String? address = await locationService.getAddressFromCoordinates(
        currentPosition!.latitude,
        currentPosition.longitude,
      );

      // Update user data in Firebase
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'firstName': firstNameController.text,
        'otherName': otherNameController.text,
        'email': emailController.text,
        'bio': bioController.text,
        'location': address,
        'occupation': occupationController.text,
        // Add more fields as needed
      });

      // Show success message
      ReusableSnackBar.showSuccessSnackBar(
          context, 'Profile updated successfully');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Profile updated successfully')),
      // );
      LoadingOverlay.hideLoading(context);
      PageNavigator.popScreen(context);
    } catch (error) {
      print('Error updating profile: $error');
      // Show error message
      LoadingOverlay.hideLoading(context);
      ReusableSnackBar.showErrorSnackBar(context, 'Error updating profile');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Error updating profile')),
      // );
    }
  }

  ImageProvider<Object> _getDefaultImage() {
    return const NetworkImage(
        'https://e3.365dm.com/18/12/2048x1152/skynews-beyonce-beyonce-jay-z_4507925.jpg'); // Replace with your default image URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text('Edit Profile'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            PageNavigator.popScreen(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: _imageFile != null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(File(_imageFile!.path)),
                      )
                    : const CircleAvatar(
                        radius: 50,
                        // Placeholder or default image when _imageFile is null
                        // You can replace AssetImage with any other ImageProvider as needed
                        backgroundImage: NetworkImage('https://static.vecteezy.com/system/resources/previews/014/194/232/original/avatar-icon-human-a-person-s-badge-social-media-profile-symbol-the-symbol-of-a-person-vector.jpg'),
                      ),
              ),
              const SizedBox(height: 16),
              ReusableTextField(
                hintText: 'First Name',
                controller: firstNameController,
                keyboardType: TextInputType.text,
                isVisible: false,
                showSuffix: false, labelText: 'First Name',
              ),
              const SizedBox(height: 16),
              ReusableTextField(
                hintText: 'Other Name',
                controller: otherNameController,
                keyboardType: TextInputType.text,
                isVisible: false,
                showSuffix: false, labelText: 'Other Name',
              ),
              const SizedBox(height: 16),
              ReusableTextField(
                hintText: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                isVisible: false,
                showSuffix: false, labelText: 'Email',
              ),
              const SizedBox(height: 16),
              ReusableTextField(
                hintText: 'Bio',
                controller: bioController,
                keyboardType: TextInputType.text,
                isVisible: false,
                showSuffix: false, labelText: 'Bio',
              ),
              const SizedBox(height: 16.0),
              ReusableTextField(
                hintText: 'Occupation',
                controller: occupationController,
                keyboardType: TextInputType.text,
                isVisible: false,
                showSuffix: false, labelText: 'Occupation',
              ),
              const SizedBox(height: AppConstants.defaultSpacing),
              SlideInAnimation(
                duration: const Duration(milliseconds: 1400),
                child: CustomButtonBorder(
                  child: CustomButton(
                    onPressed: () {
                      saveChanges();
                      _uploadImage();
                    },
                    buttonText: 'Update Profile',
                    color: Theme.of(context).colorScheme.primary,
                    buttonTextColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';

import '../screens/profile/model/profile_model.dart';



class UserManager {
  static final UserManager _instance = UserManager._internal();
  String? _currentUserId;
  UserProfileModel? _userProfile;

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  String? get currentUserId => _currentUserId;
  UserProfileModel? get userProfile => _userProfile;

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _currentUserId = user.uid;

      // Fetch additional user data
      await fetchUserProfile();
    }
  }

  Future<void> fetchUserProfile() async {
    if (_currentUserId != null) {
      _userProfile = await UserProfileModel.fromUserId(_currentUserId!);
    }
  }

  // Add other methods to fetch additional user data if needed
  // For example, fetchUserPosts() method

  // Future<List<Post>> fetchUserPosts() async {
  //   // Implement this method to fetch user posts based on the user ID
  //   // ...
  // }
}

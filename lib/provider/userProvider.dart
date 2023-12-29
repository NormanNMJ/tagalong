import 'package:flutter/material.dart';

import '../screens/profile/model/profile_model.dart';

class UserProfileProvider extends ChangeNotifier {
  UserProfileModel? _userProfile;

  UserProfileModel? get userProfile => _userProfile;

  void updateUserProfile(UserProfileModel user) {
    _userProfile = user;
    notifyListeners();
  }
}

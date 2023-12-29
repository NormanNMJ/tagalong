import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  String profileImage;
  String firstName;
  String otherName;
  String username;
  int postNumber;
  int followerNumber;
  int followingNumber;
  String location;
  String bio;

  UserProfileModel({
    required this.profileImage,
    required this.firstName,
    required this.otherName,
    required this.username,
    required this.postNumber,
    required this.followerNumber,
    required this.followingNumber,
    required this.location,
    required this.bio,
  });

  // Factory method to create a UserProfile instance from Firebase based on user ID
  static Future<UserProfileModel?> fromUserId(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userSnapshot.exists) {
        return UserProfileModel.fromMap(userSnapshot.data()!);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching user profile: $e');
      return null;
    }
  }

  // Factory method to create a UserProfile instance from a map
  factory UserProfileModel.fromMap(Map<String, dynamic> map) {
    return UserProfileModel(
      profileImage: map['profileImage'] ?? '',
      firstName: map['firstName'] ?? '',
      otherName: map['otherName'] ?? '',
      username: map['username'] ?? '',
      postNumber: map['postNumber'] ?? 0,
      followerNumber: map['followerNumber'] ?? 0,
      followingNumber: map['followingNumber'] ?? 0,
      location: map['location'] ?? '',
      bio: map['bio'] ?? '',
    );
  }

  // Convert the UserProfile instance to a map
  Map<String, dynamic> toMap() {
    return {
      'profileImage': profileImage,
      'firstName': firstName,
      'otherName': otherName,
      'username': username,
      'postNumber': postNumber,
      'followerNumber': followerNumber,
      'followingNumber': followingNumber,
      'location': location,
      'bio': bio,
    };
  }

}

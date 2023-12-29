import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FriendManager {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to add a friend by username
  Future<void> addFriendByUsername(String friendUsername) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      // User not authenticated
      return;
    }

    final friendDetails = await _getUserDetailsByUsername(friendUsername);
    if (friendDetails != null) {
      await _updateFriendList(currentUser.uid, friendDetails.uid);
      await _updateFriendList(friendDetails.uid, currentUser.uid);
    }
  }

  // Method to add a friend by phone number
  Future<void> addFriendByPhoneNumber(String friendPhoneNumber) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      // User not authenticated
      return;
    }

    final friendDetails = await _getUserDetailsByPhoneNumber(friendPhoneNumber);
    if (friendDetails != null) {
      await _updateFriendList(currentUser.uid, friendDetails.uid);
      await _updateFriendList(friendDetails.uid, currentUser.uid);
    }
  }

  // Method to get the friend list for a user
  Future<List<String>> getFriendList() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      // User not authenticated
      return [];
    }

    final friendListSnapshot = await _firestore.collection('users').doc(currentUser.uid).collection('friends').get();
    return friendListSnapshot.docs.map((doc) => doc.id).toList();
  }

  Future<UserDetails?> _getUserDetailsByUsername(String username) async {
    final userQuery = await _firestore.collection('users').where('username', isEqualTo: username).get();
    if (userQuery.docs.isNotEmpty) {
      final userDoc = userQuery.docs.first;
      return UserDetails.fromSnapshot(userDoc);
    }
    return null;
  }

  Future<UserDetails?> _getUserDetailsByPhoneNumber(String phoneNumber) async {
    final userQuery = await _firestore.collection('users').where('phoneNumber', isEqualTo: phoneNumber).get();
    if (userQuery.docs.isNotEmpty) {
      final userDoc = userQuery.docs.first;
      return UserDetails.fromSnapshot(userDoc);
    }
    return null;
  }

  Future<void> _updateFriendList(String userId, String friendId) async {
    await _firestore.collection('users').doc(userId).collection('friends').doc(friendId).set({});
  }
}

class UserDetails {
  final String uid;
  final String username;
  final String email;
  final String phoneNumber;

  UserDetails({required this.uid, required this.username, required this.email, required this.phoneNumber});

  factory UserDetails.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return UserDetails(
      uid: snapshot.id,
      username: data['username'],
      email: data['email'],
      phoneNumber: data['phoneNumber'],
    );
  }
}

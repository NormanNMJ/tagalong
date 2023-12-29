// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/userProvider.dart';
import '../../../../reusable_widgets/cache_Image.dart';
import '../../../../reusable_widgets/page_navigator.dart';
import '../../../../reusable_widgets/textfields.dart';
import '../../../../utils/greetings.dart';
import '../../../profile/model/profile_model.dart';
import '../../../profile/profile_screen.dart';
import 'chat_screen.dart';

class Friend {
  final String userName;
  final String profilePicUrl;
  final bool isOnline;

  Friend({
    required this.userName,
    required this.profilePicUrl,
    this.isOnline = false,
  });
}

class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  TextEditingController searchController = TextEditingController();
  List<Friend> filteredFriends = [];
  late String currentUserId;

  final List<Friend> friends = [
    Friend(
        userName: 'John Doe',
        profilePicUrl:
            'https://images.pexels.com/photos/2379005/pexels-photo-2379005.jpeg?auto=compress&cs=tinysrgb&w=600',
        isOnline: true),
    Friend(
        userName: 'Alice Smith',
        profilePicUrl:
            'https://images.pexels.com/photos/2169434/pexels-photo-2169434.jpeg?auto=compress&cs=tinysrgb&w=600'),
    Friend(
        userName: 'John Doe',
        profilePicUrl:
            'https://images.pexels.com/photos/6973757/pexels-photo-6973757.jpeg?auto=compress&cs=tinysrgb&w=600',
        isOnline: true),
    Friend(
        userName: 'Alice Smith',
        profilePicUrl:
            'https://images.pexels.com/photos/2128807/pexels-photo-2128807.jpeg?auto=compress&cs=tinysrgb&w=600'),
    Friend(
        userName: 'John Doe',
        profilePicUrl:
            'https://images.pexels.com/photos/1239288/pexels-photo-1239288.jpeg?auto=compress&cs=tinysrgb&w=600',
        isOnline: true),
    Friend(
        userName: 'Alice Smith',
        profilePicUrl:
            'https://images.pexels.com/photos/2147218/pexels-photo-2147218.jpeg?auto=compress&cs=tinysrgb&w=600'),
    Friend(
        userName: 'John Doe',
        profilePicUrl:
            'https://images.pexels.com/photos/1181686/pexels-photo-1181686.jpeg?auto=compress&cs=tinysrgb&w=600',
        isOnline: true),
    Friend(
        userName: 'Alice Smith',
        profilePicUrl:
            'https://images.pexels.com/photos/3586798/pexels-photo-3586798.jpeg?auto=compress&cs=tinysrgb&w=600'),
    Friend(
        userName: 'John Doe',
        profilePicUrl:
            'https://images.pexels.com/photos/842980/pexels-photo-842980.jpeg?auto=compress&cs=tinysrgb&w=600',
        isOnline: true),
    Friend(
        userName: 'Alice Smith',
        profilePicUrl:
            'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=600'),
    Friend(
        userName: 'John Doe',
        profilePicUrl:
            'https://images.pexels.com/photos/1212984/pexels-photo-1212984.jpeg?auto=compress&cs=tinysrgb&w=600',
        isOnline: true),
    Friend(
        userName: 'Alice Smith',
        profilePicUrl:
            'https://images.pexels.com/photos/6973757/pexels-photo-6973757.jpeg?auto=compress&cs=tinysrgb&w=600'),
    // Add more friends as needed
  ];

  @override
  void initState() {
    super.initState();
    filteredFriends = friends;
    getCurrentUserId();
  }

  Future<void> getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserId = user.uid;
      });

      // Fetch user profile data based on the user ID
      await fetchUserProfile();
    }
  }

  Future<void> fetchUserProfile() async {
    // Fetch user profile data based on the current user ID
    UserProfileModel? user = await UserProfileModel.fromUserId(currentUserId);

    if (user != null) {
      // Use Provider to update the user profile data
      context.read<UserProfileProvider>().updateUserProfile(user);
    } else {
      // Handle the case where the user profile is not found
    }
  }

  void filterFriends(String query) {
    setState(() {
      filteredFriends = friends
          .where((friend) =>
              friend.userName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
          ),
          onPressed: () {}),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            // Open drawer
            Scaffold.of(context).openDrawer();
          },
          child: Consumer<UserProfileProvider>(
            builder: (context, userProfileProvider, child) {
              UserProfileModel? userProfile = userProfileProvider.userProfile;
        
              return userProfile?.profileImage != null
                  ? CustomCachedImage(
                      imageUrl: userProfile!.profileImage,
                      width: 20,
                      height: 20,
                      backgroundColor: Colors.grey,
                    )
                  : const SizedBox(
                      width: 20,
                      height: 20,
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    );
            },
          ),
        ),
        title: Icon(
          Icons.tag,
          color: Theme.of(context)
              .colorScheme
              .primary, // Change the color as needed
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  Consumer<UserProfileProvider>(
                    builder: (context, userProfileProvider, child) {
                      UserProfileModel? userProfile =
                          userProfileProvider.userProfile;

                      return Text(
                        '${getGreeting()} ${userProfile?.firstName ?? ''} ',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              overflow: TextOverflow.ellipsis,
                            ),
                      );
                    },
                  ),
                  Container(
                    child: getPeriodIcon(),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              // Search Bar
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ReusableSearchField(
                  hintText: 'Search',
                  controller: searchController,
                  keyboardType: TextInputType.name,
                  searchQuery: filterFriends,
                ),
              ),
              const SizedBox(height: 16.0),
              Visibility(
                visible: searchController.text.isEmpty,
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Unread Messages',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: friends.map((friend) {
                        return Column(
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    PageNavigator.navigateToNextPage(
                                        context, const ChatScreen());
                                  },
                                  child: CachedImage(
                                    imageUrl: friend.profilePicUrl,
                                    backgroundColor: Colors.grey,
                                    radius: 30,
                                  ),
                                ),
                                if (friend.isOnline)
                                  Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.green,
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.0,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              friend.userName,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Friends',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredFriends.length,
                itemBuilder: (context, index) {
                  final friend = filteredFriends[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: ListTile(
                      leading: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          GestureDetector(
                            onTap: () {
                              PageNavigator.navigateToNextPage(
                                  context, const ProfileScreen());
                            },
                            child: CachedImage(
                              imageUrl: friend.profilePicUrl,
                              backgroundColor: Colors.transparent,
                              radius: 30,
                            ),
                          ),
                          if (friend.isOnline)
                            Container(
                              width: 15,
                              height: 15,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                            ),
                        ],
                      ),
                      title: GestureDetector(
                        onTap: () {
                          PageNavigator.navigateToNextPage(
                              context, const ChatScreen());
                        },
                        child: Text(
                          friend.userName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: GestureDetector(
                          onTap: () {
                            PageNavigator.navigateToNextPage(
                                context, const ChatScreen());
                          },
                          child: const Text('last messages')),
                      trailing: const SizedBox(
                        width: 15,
                        height: 15,
                        child: Center(
                            child: Text(
                          '1',
                          style: TextStyle(fontSize: 14),
                        )),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

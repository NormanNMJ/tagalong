// ignore_for_file: unnecessary_null_comparison

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../imageHandler/image_handler.dart';
import '../../reusable_widgets/loadingindicator.dart';
import '../../reusable_widgets/page_navigator.dart';
import 'edit_profile.dart';
import 'model/profile_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String currentUserId;
  late UserProfileModel userProfile;
  bool isLoading = true;
  String? imageUrl;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    // Fetch current user ID
    getCurrentUserId();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
      setState(() {
        userProfile = user;
        isLoading = false;
      });
    } else {
      // Handle the case where the user profile is not found
      isLoading = false;
    }
  }

  Future<void> refreshProfile() async {
    await fetchUserProfile();
  }

  Future<void> handleImageSelection() async {
    String? url = await pickAndUploadImage();
    if (url != null) {
      setState(() {
        imageUrl = url;
        FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserId)
            .set({'profileImage': imageUrl});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: const Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            PageNavigator.popScreen(context);
          },
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                // Handle search
                PageNavigator.navigateToNextPage(
                    context, const EditProfileScreen());
              },
            ),
          ),
        ],
      ),
      body: isLoading == true
          ? const Center(
              child: CircleLoadingIndicator(),
            )
          : RefreshIndicator(
              onRefresh: refreshProfile,
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUserId)
                    .snapshots(),
                builder: (context, snapshot) {
                  // Data is available, you can access it using snapshot.data
                  UserProfileModel userData =
                      UserProfileModel.fromMap(snapshot.data?.data() ?? {});

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // Display a loading indicator while waiting for data
                    return const CircleLoadingIndicator();
                  } else if (snapshot.hasError) {
                    // Handle any errors that occurred during data fetching
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (snapshot.hasData) {
                    if (userData != null) {
                      // Render your UI based on the user data
                      return SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Following',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        Text(
                                          "${userData.followingNumber.toInt()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Posts',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            Text(
                                              "${userData.postNumber.toInt()}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          await handleImageSelection();
                                        },
                                        child: CachedNetworkImage(
                                                imageUrl: userData.profileImage,
                                                placeholder: (context, url) =>
                                                    const CircleAvatar(
                                                  radius: 50.0,
                                                  backgroundColor: Colors.grey,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const CircleAvatar(
                                                  radius: 50.0,
                                                  backgroundColor: Colors.grey,
                                                ),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        CircleAvatar(
                                                  radius: 50.0,
                                                  backgroundImage:
                                                      imageProvider,
                                                ),
                                              ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Followers',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge,
                                        ),
                                        Text(
                                          "${userData.followerNumber.toInt()}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '${userData.firstName} ${userData.otherName}',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                softWrap: true,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '@${userData.username}'.toLowerCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  userData.bio,
                                  style:
                                      Theme.of(context).textTheme.bodyLarge,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const DefaultTabController(
                                length: 3,
                                child: Column(
                                  children: [
                                    TabBar(
                                      tabs: [
                                        Tab(text: 'Moments'),
                                        Tab(text: 'Status'),
                                        Tab(text: 'Videos'),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          200, // Adjust the height based on your content
                                      child: TabBarView(
                                        children: [
                                          // Replace with your MomentsPage widget
                                          Center(
                                              child: Text('Moments Content')),
                                          // Replace with your StatusPage widget
                                          Center(child: Text('Status Content')),

                                          Center(child: Text('Videos Content')),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      // Handle the case where user data is not found
                      return const Center(
                        child: Text('User data not found'),
                      );
                    }
                  } else {
                    // Handle the case where there is no data
                    return const Center(
                      child: Text('No data available'),
                    );
                  }
                },
              )),
    );
  }
}

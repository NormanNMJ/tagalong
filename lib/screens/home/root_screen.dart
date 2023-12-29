// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/size_config.dart';
import '../../provider/userProvider.dart';
import '../../reusable_widgets/page_navigator.dart';
import '../../theme/theme_handler.dart';
import '../bookmark/bookmark.dart';
import '../monetization/monetization.dart';
import '../profile/model/profile_model.dart';
import '../tags/tagListScreen.dart';
import 'pages/chats/friends_list.dart';
import 'pages/map/tag_screen.dart';
import 'pages/notification/notificaton.dart';
import '../profile/profile_screen.dart';
import 'pages/settings/settings.dart';
import 'pages/status_page.dart';
import 'pages/trend/trend_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndexBottom = 1;
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _screens = [
    const FriendListScreen(),
    const TrendScreen(),
    const MapScreen(),
    NotificationScreen(),
    const StatusScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndexBottom],
      drawerEnableOpenDragGesture: true,
      drawerEdgeDragWidth: 70,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const CustomDrawerHeader(),
            drawerListTile(
              context: context,
              title: 'Home',
              onTap: () {
                Navigator.pop(context);
                _onItemTapped(0);
              },
              icon: Icons.home_outlined,
              selected: _currentIndex == 0,
            ),
            drawerListTile(
              context: context,
              title: 'Profile',
              onTap: () {
                _onItemTapped(1);
                PageNavigator.navigateToNextPage(
                    context, const ProfileScreen());
              },
              icon: Icons.person,
              selected: _currentIndex == 1,
            ),
            drawerListTile(
              context: context,
              title: 'Bookmarks',
              onTap: () {
                _onItemTapped(2);
                PageNavigator.navigateToNextPage(
                    context, const BookmarkScreen());
              },
              icon: Icons.bookmark,
              selected: _currentIndex == 2,
            ),
            drawerListTile(
              context: context,
              title: 'Tags Around You',
              onTap: () {
                // Handle tags around you tap
                _onItemTapped(3);
                PageNavigator.navigateToNextPage(
                    context, const TagListScreen());
              },
              icon: Icons.tag,
              selected: _currentIndex == 3,
            ),
            drawerListTile(
              context: context,
              title: 'Monetization',
              onTap: () {
                // Handle marketplace tap
                _onItemTapped(4);
                PageNavigator.navigateToNextPage(
                    context, const MonetizationScreen());
              },
              icon: Icons.money,
              selected: _currentIndex == 4,
            ),
            const Divider(),
            ListTile(
              title: const Text('Dark Mode'),
              trailing: Switch(
                value: Theme.of(context).brightness == Brightness.dark,
                onChanged: (value) {
                  // Handle dark mode toggle
                  setState(() {
                    if (value) {
                      // Switch to dark mode
                      // You can implement your dark mode logic here
                      // For example, using a ThemeData with dark colors
                      ThemeUpdater.toggleTheme(context);
                    } else {
                      // Switch to light mode
                      // You can implement your light mode logic here
                      // For example, using a ThemeData with light colors
                      ThemeUpdater.toggleTheme(context);
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Theme.of(context).colorScheme.primary,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        currentIndex: _currentIndexBottom,
        onTap: (index) {
          setState(() {
            _currentIndexBottom = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up_outlined),
            label: 'Trend',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tag),
            label: 'Tag',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_outline_rounded),
            label: 'Status',
          ),
        ],
      ),
    );
  }
}

ListTile drawerListTile({
  required BuildContext context,
  required String title,
  required VoidCallback onTap,
  required IconData icon,
  required bool selected,
}) {
  return ListTile(
    leading: Icon(
      icon,
      color: selected
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.onSurface,
    ),
    title: Text(
      title,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: selected
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.onSurface,
          ),
    ),
    selected: selected,
    onTap: onTap,
  );
}

class CustomDrawerHeader extends StatefulWidget {
  const CustomDrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawerHeader> createState() => _CustomDrawerHeaderState();
}

class _CustomDrawerHeaderState extends State<CustomDrawerHeader> {
  late String currentUserId;

  @override
  void initState() {
    super.initState();
    // Fetch current user ID
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

  @override
  Widget build(BuildContext context) {
    // Use the user profile data from the Provider

    return Consumer<UserProfileProvider>(
      builder: (context, userProfileProvider, child) {
        UserProfileModel? userProfile = userProfileProvider.userProfile;

        return DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).appBarTheme.backgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // profile image
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).closeDrawer();
                      PageNavigator.navigateToNextPage(
                        context,
                        const ProfileScreen(),
                      );
                    },
                    child: CircleAvatar(
                      radius: AppConstants.largeSpacing,
                      backgroundImage: userProfile?.profileImage != null
                          ? CachedNetworkImageProvider(
                              userProfile!.profileImage)
                          : null,
                      backgroundColor: Colors.grey,
                    ),
                  ),

                  // name
                  SizedBox(
                    width: 200,
                    child: Text(
                      '${userProfile?.firstName ?? ''} ${userProfile?.otherName ?? ''}',
                      style:
                          Theme.of(context).textTheme.headlineSmall!.copyWith(
                                overflow: TextOverflow.ellipsis,
                              ),
                      maxLines: 1,
                    ),
                  ),

                  // username
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '@${userProfile?.username ?? ''}'.toLowerCase(),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {
                    PageNavigator.popScreen(context);
                    PageNavigator.navigateToNextPage(
                      context,
                      const SettingsScreen(),
                    );
                  },
                  icon: const Icon(Icons.settings),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

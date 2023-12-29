
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../reusable_widgets/cache_Image.dart';

class UserStatus {
  final String profilePicUrl;
  final String userName;

  UserStatus({required this.profilePicUrl, required this.userName});
}

class UserStatusGrid extends StatelessWidget {
  final List<UserStatus> userStatusList = [
    UserStatus(
      profilePicUrl:
          'https://images.pexels.com/photos/773371/pexels-photo-773371.jpeg?auto=compress&cs=tinysrgb&w=600',
      userName: 'User 1',
    ),
    UserStatus(
      profilePicUrl:
          'https://images.pexels.com/photos/2104252/pexels-photo-2104252.jpeg?auto=compress&cs=tinysrgb&w=600',
      userName: 'User 2',
    ),
    UserStatus(
      profilePicUrl:
          'https://images.pexels.com/photos/2083751/pexels-photo-2083751.jpeg?auto=compress&cs=tinysrgb&w=600',
      userName: 'User 3',
    ),
    UserStatus(
      profilePicUrl:
          'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=600',
      userName: 'User 1',
    ),
    UserStatus(
      profilePicUrl:
          'https://images.pexels.com/photos/733872/pexels-photo-733872.jpeg?auto=compress&cs=tinysrgb&w=600',
      userName: 'User 1',
    ),
    // Add more UserStatus objects as needed
  ];

  UserStatusGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return GridView.builder(
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            childAspectRatio: 2 / 3,
          ),
          itemCount: userStatusList.length,
          itemBuilder: (context, index) {
            final userStatus = userStatusList[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        userStatusList[index].profilePicUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Container(
                          color: Colors.black.withOpacity(0.3),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              children: [
                                CachedImage(
                                  imageUrl: userStatus.profilePicUrl,
                                   backgroundColor: Theme.of(context).colorScheme.background,
                                  radius: 15,
                                ),
                                const SizedBox(width: 8.0),
                                Text(
                                  userStatus.userName,
                                  style: Theme.of(context).textTheme.bodySmall!.apply(
                        color: Theme.of(context).colorScheme.onBackground),
                                  
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class StatusScreen extends StatelessWidget {
  const StatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              // Open drawer
              Scaffold.of(context).openDrawer();
            },
            child: const CachedImage(
              imageUrl:
                  'https://images.pexels.com/photos/773371/pexels-photo-773371.jpeg?auto=compress&cs=tinysrgb&w=600',
              backgroundColor: Colors.transparent,
              radius: 15,
            ),
          ),
        ),
        elevation: 0,
        title:  Text(
          'Status',
         style: Theme.of(context).textTheme.titleLarge!.apply(
                        color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: UserStatusGrid(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your logic here
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

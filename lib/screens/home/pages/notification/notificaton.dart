import 'package:flutter/material.dart';

import '../../../../reusable_widgets/cache_Image.dart';

class NotificationScreen extends StatelessWidget {
  final List<String> notifications = [
    'New message from John',
    'You have 3 new friend requests',
    'Reminder: Meeting at 2:00 PM',
    'Update: Your order has been shipped',
    'Event: Team lunch tomorrow',
  ];

  NotificationScreen({super.key});

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
        title: Text(
          'Notifications',
         style: Theme.of(context).textTheme.titleLarge!.apply(
                        color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(notifications[index]),
            subtitle: const Text(
                '12:30 PM'), // Include timestamp or additional info if needed
            leading: const Icon(Icons.notifications, color: Colors.green),
            onTap: () {
              // Handle notification tap
              // You can navigate to a detailed notification page or perform other actions
            },
          );
        },
      ),
    );
  }
}

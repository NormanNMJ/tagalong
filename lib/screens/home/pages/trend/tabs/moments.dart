import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';



class Moment extends StatelessWidget {
  const Moment({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
       backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView(
        children: [
          _buildInstagramPost('Norman Joshua',
              'https://images.pexels.com/photos/2811089/pexels-photo-2811089.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
          _buildInstagramPost('Ekemini Etuk',
              'https://images.pexels.com/photos/762020/pexels-photo-762020.jpeg?auto=compress&cs=tinysrgb&w=600'),
          _buildInstagramPost('Paris Joshua',
              'https://images.pexels.com/photos/1036622/pexels-photo-1036622.jpeg?auto=compress&cs=tinysrgb&w=600'),
          // Add more Instagram-style posts as needed
        ],
      ),
    );
  }

  Widget _buildInstagramPost(String username, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                     const CircleAvatar(
                       radius: 20,
                      backgroundImage: CachedNetworkImageProvider(
                          'https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=600'), // Replace with your profile image
                    ),
                    const SizedBox(width: 8),
                    Text(
                      username,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Icon(Icons.more_vert),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border),
                  SizedBox(width: 8),
                  Icon(Icons.chat_bubble_outline),
                  SizedBox(width: 8),
                  Icon(Icons.send),
                ],
              ),
              Icon(Icons.bookmark_border),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Liked by user1, user2, and 100 others',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                '$username ',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Text('Caption text goes here'),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'View all 50 comments',
           
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: CachedNetworkImageProvider(
                    'https://images.pexels.com/photos/2083751/pexels-photo-2083751.jpeg?auto=compress&cs=tinysrgb&w=600'), // Replace with your profile image
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Add a comment...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Icon(Icons.favorite_border),
              Icon(Icons.add_circle_outline),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            '2 hours ago',
           
          ),
        ],
      ),
    );
  }
}
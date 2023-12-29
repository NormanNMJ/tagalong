// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TrendSearchScreen extends StatefulWidget {
  const TrendSearchScreen({super.key});

  @override
  State<TrendSearchScreen> createState() => _TrendSearchScreenState();
}

class _TrendSearchScreenState extends State<TrendSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
               backgroundColor: Colors.transparent,
        title: const Text('Search'),
        elevation: 0,
       
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.green,),
            onPressed: () {
              // Implement filter action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search...',
                  border: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Recent Searches
            const Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                FilterChip(
                  label: const Text('Flutter'),
                  onSelected: (selected) {
                    // Handle chip selection
                  },
                ),
                FilterChip(
                  label: const Text('Mobile Apps'),
                  onSelected: (selected) {
                    // Handle chip selection
                  },
                ),
                // Add more chips based on recent searches
              ],
            ),

            // Popular Searches
            const SizedBox(height: 16.0),
            const Text(
              'Popular Searches',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle popular search button press
                  },
                  child: const Text('Flutter Development'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle popular search button press
                  },
                  child: const Text('UI/UX Design'),
                ),
                // Add more buttons based on popular searches
              ],
            ),
          ],
        ),
      ),
    );
  }
}

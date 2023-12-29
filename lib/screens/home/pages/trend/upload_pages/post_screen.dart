import 'package:flutter/material.dart';

class PostUploadScreen extends StatefulWidget {
  const PostUploadScreen({super.key});

  @override
  State<PostUploadScreen> createState() => _PostUploadScreenState();
}

class _PostUploadScreenState extends State<PostUploadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text(
          'Create Post',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          FilledButton(
            style: const ButtonStyle(),
            onPressed: (){},
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Post',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
             
              const SizedBox(height: 16.0),
              const Text('Add Pictures'),
              const SizedBox(height: 8.0),
              GridView.builder(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.grey[300],
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          // Add image selection logic here
                        },
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              const TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Add a caption...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Tag Friends'),
              // Add a section for tagging friends here
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const Text('Visibility:'),
                  const SizedBox(width: 8.0),
                  DropdownButton<String>(
                    value: 'Public',
                    onChanged: (String? value) {
                      // Handle visibility selection
                    },
                    items: <String>['Public', 'Private']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms of Service'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Terms of Service',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Please read these terms of service carefully before using the app.',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Text(
                '1. Acceptance of Terms',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'By accessing or using the app, you agree to be bound by these terms of service.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                '2. User Content',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'You are responsible for any content you post or share on the app.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              // Add more sections as needed
            ],
          ),
        ),
      ),
    );
  }
}

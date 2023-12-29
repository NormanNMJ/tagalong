import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Privacy Policy',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Last updated: [Date]',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Text(
                '1. Information We Collect',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'We collect information you provide directly to us, such as your name, email address, and other details when you create an account.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                '2. How We Use Your Information',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'We use the information we collect to provide, maintain, and improve our services, as well as to send you updates and promotional messages.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              // Add more sections as needed
              // Include sections on data security, third-party services, user rights, and contact information for questions
            ],
          ),
        ),
      ),
    );
  }
}

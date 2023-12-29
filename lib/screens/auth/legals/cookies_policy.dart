import 'package:flutter/material.dart';

class CookiesPolicyPage extends StatelessWidget {
  const CookiesPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cookies Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cookies Policy',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(
                'Last updated: [Date]',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Text(
                '1. What are Cookies',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Cookies are small pieces of data stored on your device (computer or mobile device). They are used to improve your experience on our website and to provide certain features.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              Text(
                '2. How We Use Cookies',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'We use cookies to analyze user behavior, improve our services, and deliver personalized content. By using our website, you agree to the use of cookies.',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              // Add more sections as needed
              // Include sections on types of cookies used, third-party cookies, and how users can manage or disable cookies
            ],
          ),
        ),
      ),
    );
  }
}

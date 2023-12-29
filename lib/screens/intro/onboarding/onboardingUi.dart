// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';

class onboardingScreen extends StatelessWidget {
  final String headText;
  final String imageStringLightMode;
  final String imageStringDarkMode;
  final String bottomText;
  const onboardingScreen(
      {super.key,
      required this.headText,
      required this.bottomText,
      required this.imageStringLightMode,
      required this.imageStringDarkMode});

  @override
  Widget build(BuildContext context) {
    bool screenBrightnessMode =
        Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //heading

            Text(
              headText,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            //image

            screenBrightnessMode
                ? Image.asset(imageStringLightMode)
                : Image.asset(imageStringDarkMode),

            //texts

            Text(
              bottomText,
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ],
        ),
      ),
    );
  }
}

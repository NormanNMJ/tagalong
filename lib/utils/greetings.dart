 import 'package:flutter/material.dart';

String getGreeting() {
    DateTime now = DateTime.now();
    int hour = now.hour;

    if (hour >= 6 && hour < 12) {
      return 'Good Morning';
    } else if (hour >= 12 && hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
Widget getPeriodIcon() {
  DateTime now = DateTime.now();
  int hour = now.hour;

  if (hour >= 6 && hour < 12) {
    return SizedBox(
      height: 24,
      width: 24,
      child: Image.asset('assets/icons/morningicon.png'),
    ); // Morning
  } else if (hour >= 12 && hour < 18) {
    return SizedBox(
      height: 24,
      width: 24,
      child: Image.asset('assets/icons/afternoonicon.png'),
    ); // Afternoon
  } else {
    return SizedBox(
      height: 24,
      width: 24,
      child: Image.asset('assets/icons/nighticon.png'),
    ); // Night
  }
}


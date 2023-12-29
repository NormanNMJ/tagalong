// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tagalong/reusable_widgets/page_navigator.dart';
import '../screens/home/pages/trend/upload_pages/post_screen.dart';
import '../screens/home/pages/trend/upload_pages/quote_screen.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      icon: Icons.add,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.image),
          label: 'Photo',
          onTap: () {
            _showPostScreen(context);
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.edit_note),
          label: 'Post',
          onTap: () {
            _showQuoteScreen(context);
          },
        ),
      ],
    );
  }
}

void _showQuoteScreen(BuildContext context) {
  PageNavigator.navigateToNextPage(context, QuoteUploadScreen());
}



void _showPostScreen(BuildContext context) {
  PageNavigator.navigateToNextPage(context, PostUploadScreen());
}

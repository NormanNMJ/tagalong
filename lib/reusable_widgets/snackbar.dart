import 'package:flutter/material.dart';

class ReusableSnackBar {
  static showSuccessSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
      content: _SnackBarContent(
        title: 'Success',
        message: message,
        color: Theme.of(context).colorScheme.primary,
      ),
    );

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showErrorSnackBar(
    BuildContext context,
    String message,
  ) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
      content: _SnackBarContent(
        title: 'Error',
        message: message,
        color: Theme.of(context).colorScheme.error,
      ),
    );

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static showNetworkErrorSnackBar(
    BuildContext context,
    String message,
  ) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 5),
      content: _SnackBarContent(
        title: 'Connection Failed',
        message: message,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );

    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

class _SnackBarContent extends StatefulWidget {
  final String title;
  final String message;
  final Color color;

  const _SnackBarContent({
    required this.title,
    required this.message,
    required this.color,
  });

  @override
  _SnackBarContentState createState() => _SnackBarContentState();
}

class _SnackBarContentState extends State<_SnackBarContent> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
      child: Container(
        padding: const EdgeInsets.all(20.0),
        color: widget.color,
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              widget.message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class PageNavigator {
  static navigateToNextPage(BuildContext context, Widget destinationPage) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (context, animation, secondaryAnimation) =>
            destinationPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;

          var curve = Curves.easeInBack;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          var fadeTween = Tween(begin: 0.0, end: 1.0);

          return Stack(
            children: [
              FadeTransition(
                opacity: animation.drive(fadeTween),
                child: child,
              ),
              SlideTransition(position: animation.drive(tween))
            ],
          );
        },
      ),
    );
  }

  static popScreen(BuildContext context) {
    Navigator.of(context).pop();
  }

  static replaceScreen(BuildContext context, Widget destinationPage) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => destinationPage));
  }
}

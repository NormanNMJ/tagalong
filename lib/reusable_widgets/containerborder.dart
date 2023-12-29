import 'package:flutter/material.dart';

class CustomButtonBorder extends StatelessWidget {
  final Widget child;
  const CustomButtonBorder({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
     height: Theme.of(context).buttonTheme.height,
      padding: const EdgeInsets.only(top: 3, left: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        border: const Border(
          bottom: BorderSide(color: Colors.black),
          top: BorderSide(color: Colors.black),
          left: BorderSide(color: Colors.black),
          right: BorderSide(color: Colors.black),
        ),
      ),
      child: child,
    );
  }
}

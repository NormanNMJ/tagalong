// ignore_for_file: file_names

import 'package:flutter/material.dart';



class CheckIconVisibility extends StatelessWidget {
  const CheckIconVisibility({
    super.key,
    required this.visibility,
  });

  final bool visibility;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: visibility,
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(Icons.check_circle, size: 16, color: Colors.green),
        ));
  }
}

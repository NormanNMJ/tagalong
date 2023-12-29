import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final void Function()? onPressed;
  final Color? color;
  final Color? buttonTextColor;
  final IconData? icon;

  // Constructor with a named parameter for color
  const CustomButton({
    Key? key,
    required this.buttonText,
    this.onPressed,
    required this.color,
    this.icon, this.buttonTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: color, // Use the provided color
      minWidth: double.infinity,
      height: Theme.of(context).buttonTheme.height,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        buttonText,
        style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 18, color: buttonTextColor),
      ),
    );
  }
}

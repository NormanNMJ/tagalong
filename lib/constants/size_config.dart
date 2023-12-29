import 'package:flutter/widgets.dart';

class AppConstants {
  // Device dimensions
  static double deviceWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Spacing
  static const double defaultSpacing = 16.0;
  static const double smallSpacing = 8.0;
  static const double largeSpacing = 24.0;

  // Icon sizes
  static const double verySmallIconSize = 24.0;
  static const double smallIconSize = 24.0;
  static const double mediumIconSize = 32.0;
  static const double largeIconSize = 48.0;


}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverlay {
  static  showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: SpinKitChasingDots(
            color: Theme.of(context).primaryColor, // Adjust the color as needed
            size: 50.0, // Adjust the size as needed
          ),
        );
      },
    );
  }

  static  hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}



class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitChasingDots(
        color: Theme.of(context).primaryColor, // Adjust the color as needed
        size: 50.0, // Adjust the size as needed
      ),
    );
  }
}


class CircleLoadingIndicator extends StatelessWidget {
  const CircleLoadingIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(
      color: Theme.of(context)
          .primaryColor, // Adjust the color as needed
      size: 50.0, // Adjust the size as needed
    );
  }
}
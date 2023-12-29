import 'package:flutter/material.dart';
import '../../constants/size_config.dart';
import '../../reusable_widgets/button.dart';
import '../../reusable_widgets/containerborder.dart';
import '../../reusable_widgets/page_navigator.dart';
import 'onboarding/onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    bool screenBrightnessMode =
        Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.defaultSpacing),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              screenBrightnessMode
                  ? Image.asset('assets/images/tag_welcome.png')
                  : Image.asset('assets/images/tag_welcome.png'),

              //app name
              Text(
                'T A G - A L O N G',
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),

              Padding(
                padding: const EdgeInsets.only(
                    top: AppConstants.defaultSpacing,
                    bottom: AppConstants.defaultSpacing),
                child: Text(
                  'The mission is simple, make this your home',
                  style: Theme.of(context).textTheme.headlineSmall,
                  textAlign: TextAlign.center,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    top: AppConstants.defaultSpacing,
                    bottom: AppConstants.defaultSpacing),
                child: CustomButtonBorder(
                  child: CustomButton(
                    onPressed: () {
                      PageNavigator.navigateToNextPage(
                          context, const OnboardingScreen());
                    },
                    buttonText: 'WELCOME',
                    color: Theme.of(context).colorScheme.primary,
                    buttonTextColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

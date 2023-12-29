import 'package:flutter/material.dart';

import '../../animation/slide_in_animation.dart';
import '../../constants/size_config.dart';
import '../../reusable_widgets/button.dart';
import '../../reusable_widgets/containerborder.dart';
import '../../reusable_widgets/page_navigator.dart';
import '../../reusable_widgets/snackbar.dart';
import '../../reusable_widgets/textfields.dart';
import 'forgot_password.dart';
import '../../database/databaseHandler.dart';
import 'registrationStepper.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            PageNavigator.popScreen(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: AppConstants.deviceHeight(context),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                SlideInAnimation(
                  duration: const Duration(milliseconds: 1200),
                  child: Column(
                    children: [
                      Text(
                        'L O G I N',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        height: AppConstants.defaultSpacing,
                      ),
                      Text(
                        'Login to your account',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppConstants.defaultSpacing),
                Column(
                  children: [
                    SlideInAnimation(
                      duration: const Duration(milliseconds: 1400),
                      child: ReusableTextField(
                        isVisible: isVisible,
                        hintText: 'Email',
                        controller: emailController,
                        showSuffix: false,
                        keyboardType: TextInputType.emailAddress, labelText: 'Email',
                        
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SlideInAnimation(
                      duration: const Duration(milliseconds: 1600),
                      child: ReusableTextField(
                        isVisible: !isVisible,
                        hintText: 'Password',
                        controller: passwordController,
                        showSuffix: true,
                        keyboardType: TextInputType.visiblePassword, labelText: 'Password',
                         
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.defaultSpacing),
                SlideInAnimation(
                  duration: const Duration(milliseconds: 1400),
                  child: CustomButtonBorder(
                    child: CustomButton(
                      onPressed: () {
                        if (emailController.text.trim().isEmpty ||
                            passwordController.text.trim().isEmpty) {
                          //handle error

                          ReusableSnackBar.showErrorSnackBar(context,
                              'Please fill in your correct login details');
                        } else {
                          LoginUser.proceedToLogin(
                              context,
                              emailController.text.trim(),
                              passwordController.text.trim());
                        }
                      },
                      buttonText: 'Login',
                      color: Theme.of(context).colorScheme.primary,
                      buttonTextColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.defaultSpacing),
                // Link to Forgot Password Page
                GestureDetector(
                  onTap: () {
                    // Navigate to the reset password page
                    PageNavigator.navigateToNextPage(
                      context,
                      ResetPasswordScreen(),
                    );
                  },
                  child: SlideInAnimation(
                    duration: const Duration(milliseconds: 2000),
                    child: Text(
                      'Forgot Password?',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.largeSpacing),
                // Link to Registration Page
                SlideInAnimation(
                  duration: const Duration(milliseconds: 2400),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate back to the sign-up page
                      PageNavigator.navigateToNextPage(
                          context, const RegistrationFlow());
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account? ',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Sign Up',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.largeSpacing),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

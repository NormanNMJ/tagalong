import 'package:flutter/material.dart';
import '../../animation/slide_in_animation.dart';
import '../../constants/size_config.dart';
import '../../reusable_widgets/button.dart';
import '../../reusable_widgets/containerborder.dart';
import '../../reusable_widgets/page_navigator.dart';
import 'legals/cookies_policy.dart';
import 'legals/privacy_policy.dart';
import 'legals/terms_of_service.dart';
import 'login_screen.dart';
import 'registrationStepper.dart';

class LoginOrRegister extends StatelessWidget {
  const LoginOrRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: SlideInAnimation(
            duration: const Duration(milliseconds: 1200),
            child: Container(
              height: AppConstants.deviceHeight(context),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'W E L C O M E',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(
                        height: AppConstants.largeSpacing,
                      ),
                      Text(
                        'Welcome to the gateway, would you want to login or signup?',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                  Image.asset('assets/images/tag_loginorsignup.png'),
                  SlideInAnimation(
                    duration: const Duration(milliseconds: 1400),
                    child: Column(
                      children: [
                        CustomButtonBorder(
                          child: CustomButton(
                            onPressed: () {
                              PageNavigator.navigateToNextPage(
                                  context, const LoginScreen());
                            },
                            buttonText: 'Login',
                            color: Theme.of(context).colorScheme.background,
                            buttonTextColor:
                                Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButtonBorder(
                          child: CustomButton(
                            onPressed: () {
                              PageNavigator.navigateToNextPage(
                                  context, const RegistrationFlow());
                            },
                            buttonText: 'Sign Up',
                            color: Theme.of(context).colorScheme.primary,
                            buttonTextColor:
                                Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),

                        const SizedBox(
                          height: 10,
                        ),

                        // Terms and Policies
                        Wrap(
                          alignment: WrapAlignment.center,
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              "By signing up you agree to ",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            buildClickableText(context, 'Terms of Service ',
                                () {
                              // Handle click on Terms of Service
                              PageNavigator.navigateToNextPage(
                                  context, const TermsOfServicePage());
                            }),
                            Text(
                              ",",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            buildClickableText(context, 'Privacy Policy ', () {
                              // Handle click on Privacy Policy
                              PageNavigator.navigateToNextPage(
                                  context, const PrivacyPolicyPage());
                            }),
                            Text(
                              "and",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(width: 2.0),
                            buildClickableText(context, 'Cookies Policy', () {
                              // Handle click on Cookies Policy
                              PageNavigator.navigateToNextPage(
                                  context, const CookiesPolicyPage());
                            }),
                          ],
                        ),
                        const SizedBox(height: 32.0),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildClickableText(
      BuildContext context, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
    );
  }
}

  











// import 'package:flutter/material.dart';

// import '../../constants/size_config.dart';
// import '../../reusable_widgets/button.dart';
// import '../../reusable_widgets/page_navigator.dart';
// import 'legals/cookies_policy.dart';
// import 'legals/privacy_policy.dart';
// import 'legals/terms_of_service.dart';
// import 'login_screen.dart';
// import 'registration_screen.dart';



// class LoginOrRegister extends StatefulWidget {
//   const LoginOrRegister({Key? key});

//   @override
//   State<LoginOrRegister> createState() => _LoginOrRegisterState();
// }

// class _LoginOrRegisterState extends State<LoginOrRegister> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
     
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             const SizedBox(height: 50,),
//             // Top Icon
//             Text(
//               'LINKIN',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.displayLarge,
//             ),
//             const SizedBox(height: 25),
//             // Welcoming Text
//             Text(
//               'Welcome to our\nSocial Media, News Platform,\nand Marketplace!',
//               textAlign: TextAlign.center,
//               style: Theme.of(context).textTheme.headlineLarge,
//             ),
//             // Rounded Buttons
//             Column(
//               children: [
//                 ReusableButton(
//                   icon: Icons.g_mobiledata,
//                   buttonText: 'Continue with Google',
//                   onPressed: () {},
//                 ),
//                 const SizedBox(height: AppConstants.defaultSpacing),
//                 // Divider
//                 Divider(
//                   height: 16.0,
//                   thickness: 2.0,
//                   color: Theme.of(context).dividerColor,
//                 ),
//                 const SizedBox(height: AppConstants.defaultSpacing),
//                 // Create an Account
//                 ReusableButton(
//                   buttonText: 'Create Account',
//                   onPressed: () {
//                     PageNavigator.navigateToNextPage(
//                         context, const RegistrationScreen());
//                   },
//                 ),
//                 const SizedBox(height: AppConstants.defaultSpacing),
//                 // Terms and Policies
//                 Wrap(
//                   alignment: WrapAlignment.center,
//                   direction: Axis.horizontal,
//                   children: [
//                     Text(
//                       "By signing up you agree to ",
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     ),
//                     buildClickableText('Terms of Service', () {
//                       // Handle click on Terms of Service
//                       PageNavigator.navigateToNextPage(context, TermsOfServicePage());
//                     }),
//                     Text(
//                       ",",
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     ),
//                     const SizedBox(width: 8.0),
//                     buildClickableText('Privacy Policy ', () {
//                       // Handle click on Privacy Policy
//                        PageNavigator.navigateToNextPage(context, PrivacyPolicyPage());
//                     }),
//                     Text(
//                       "and",
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     ),
//                     const SizedBox(width: 2.0),
//                     buildClickableText('Cookies Policy', () {
//                       // Handle click on Cookies Policy
//                          PageNavigator.navigateToNextPage(context, CookiesPolicyPage());
//                     }),
//                   ],
//                 ),
//                 const SizedBox(height: 32.0),
//                 // Login Link
//                 GestureDetector(
//                   onTap: () {
//                     // Add your logic for login
//                     PageNavigator.navigateToNextPage(
//                         context, const LoginScreen());
//                   },
//                   child: Text(
//                     'Have an account already? Log in',
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

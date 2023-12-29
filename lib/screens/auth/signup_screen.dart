// // ignore_for_file: prefer_const_constructors

// import 'package:flutter/material.dart';
// import '../../animation/slide_in_animation.dart';
// import '../../reusable_widgets/button.dart';
// import '../../reusable_widgets/checkIconWidget.dart';
// import '../../reusable_widgets/containerborder.dart';
// import '../../reusable_widgets/page_navigator.dart';
// import '../../reusable_widgets/snackbar.dart';
// import '../../reusable_widgets/textfields.dart';
// import 'logic/authHandler.dart';
// import 'logic/validator.dart';
// import 'login_screen.dart';

// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({Key? key}) : super(key: key);

//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }

// class _RegistrationScreenState extends State<RegistrationScreen> {
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController otherNameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();

//   bool isVisible = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios_new,
//             color: Theme.of(context).colorScheme.onBackground,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(40, 20, 40, 40),
//           child: Column(
//             children: [
//               SlideInAnimation(
//                 duration: Duration(milliseconds: 1200),
//                 child: Column(
//                   children: [
//                     Text(
//                       'S I G N U P',
//                       style: Theme.of(context).textTheme.displayMedium,
//                     ),
//                     SizedBox(
//                       height: 16,
//                     ),
//                     Text(
//                       'Create a new account',
//                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                             color: Theme.of(context).colorScheme.primary,
//                           ),
//                     ),
//                     SizedBox(height: 16),
//                   ],
//                 ),
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               SlideInAnimation(
//                 duration: Duration(milliseconds: 1400),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ReusableTextField(
//                             onChanged: (text) {
//                               setState(() {});
//                             },
//                             isVisible: isVisible,
//                             hintText: 'First Name',
//                             controller: firstNameController,
//                             errorText: Validator.validateFirstName(
//                                 value: firstNameController.text),
//                             showSuffix: false,
//                             keyboardType: TextInputType.name,
//                           ),
//                           CheckIconVisibility(
//                             visibility: Validator.isFirstNameValid(
//                                 firstNameController.text),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Expanded(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ReusableTextField(
//                             onChanged: (text) {
//                               setState(() {});
//                             },
//                             isVisible: isVisible,
//                             hintText: 'Other Name',
//                             controller: otherNameController,
//                             errorText: Validator.validateOtherName(
//                                 value: otherNameController.text),
//                             showSuffix: false,
//                             keyboardType: TextInputType.name,
//                           ),
//                           CheckIconVisibility(
//                             visibility: Validator.isOtherNameValid(
//                                 otherNameController.text),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SlideInAnimation(
//                 duration: Duration(milliseconds: 1600),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ReusableTextField(
//                       onChanged: (text) {
//                         setState(() {});
//                       },
//                       isVisible: isVisible,
//                       hintText: 'Email',
//                       controller: emailController,
//                       errorText:
//                           Validator.validateEmail(value: emailController.text),
//                       showSuffix: false,
//                       keyboardType: TextInputType.emailAddress,
//                     ),
//                     CheckIconVisibility(
//                       visibility: Validator.isEmailValid(emailController.text),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               SlideInAnimation(
//                 duration: Duration(milliseconds: 1800),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ReusableTextField(
//                       onChanged: (text) {
//                         setState(() {});
//                       },
//                       isVisible: !isVisible,
//                       hintText: 'Password',
//                       controller: passwordController,
//                       errorText: Validator.validatePassword(
//                           value: passwordController.text),
//                       showSuffix: true,
//                       keyboardType: TextInputType.visiblePassword,
//                     ),
//                     CheckIconVisibility(
//                       visibility:
//                           Validator.isPasswordValid(passwordController.text),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               SlideInAnimation(
//                 duration: Duration(milliseconds: 2000),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     ReusableTextField(
//                       onChanged: (text) {
//                         setState(() {});
//                       },
//                       isVisible: !isVisible,
//                       hintText: 'Confirm Password',
//                       controller: confirmPasswordController,
//                       errorText: Validator.validateConfirmPassword(
//                           password: passwordController.text,
//                           confirmPassword: confirmPasswordController.text),
//                       showSuffix: true,
//                       keyboardType: TextInputType.visiblePassword,
//                     ),
//                     CheckIconVisibility(
//                       visibility: Validator.isConfirmPasswordValid(
//                           passwordController.text,
//                           confirmPasswordController.text),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SlideInAnimation(
//                 duration: Duration(milliseconds: 2200),
//                 child: CustomButtonBorder(
//                   child: CustomButton(
//                     onPressed: () {
//                       setState(() {
//                         if (Validator.isFirstNameValid(
//                                 firstNameController.text) &&
//                             Validator.isOtherNameValid(
//                                 otherNameController.text) &&
//                             Validator.isEmailValid(emailController.text) &&
//                             Validator.isPasswordValid(
//                                 passwordController.text) &&
//                             Validator.isConfirmPasswordValid(
//                                 passwordController.text,
//                                 confirmPasswordController.text)) {
//                           // All validations passed, proceed with your logic here.
//                           RegisterUser.proceedToRegisterUser(
//                               context,
//                               firstNameController.text.trim(),
//                               otherNameController.text.trim(),
//                               emailController.text.trim(),
//                               passwordController.text.trim());
//                         } else {
//                           // Handle validation failures, show error messages or take appropriate action.
//                           ReusableSnackBar.showErrorSnackBar(
//                               context, 'Please fill all fields correctly');
//                         }
//                       });
//                     },
//                     buttonText: 'Sign Up',
//                     color: Theme.of(context).colorScheme.primary,
//                     buttonTextColor: Theme.of(context).colorScheme.onPrimary,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               SlideInAnimation(
//                 duration: Duration(milliseconds: 2500),
//                 child: GestureDetector(
//                   onTap: () {
//                     // Navigate back to the login page
//                     PageNavigator.navigateToNextPage(context, const LoginScreen());
//                   },
//                   child: RichText(
//                     text: TextSpan(
//                       text: 'Already have an account? ',
//                       style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                             color: Theme.of(context).colorScheme.onBackground,
//                           ),
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: 'Login',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyLarge!
//                               .copyWith(
//                                 color: Theme.of(context).colorScheme.primary,
//                               ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

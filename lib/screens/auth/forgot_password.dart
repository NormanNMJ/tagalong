
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../animation/slide_in_animation.dart';
import '../../constants/size_config.dart';
import '../../reusable_widgets/button.dart';
import '../../reusable_widgets/containerborder.dart';
import '../../reusable_widgets/page_navigator.dart';

import '../../reusable_widgets/snackbar.dart';
import '../../reusable_widgets/textfields.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool screenBrightnessMode =
        Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            PageNavigator.popScreen(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: AppConstants.deviceHeight(context),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 80),
            child: SlideInAnimation(
              duration: const Duration(milliseconds: 1000),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        'F O R G O T  P A S S W O R D',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      const SizedBox(
                        height: AppConstants.defaultSpacing,
                      ),
                      Text(
                        'Reset password by providing your email',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w400, fontSize: 15),
                      ),
                      screenBrightnessMode
                          ? Image.asset('assets/images/tag_forgot_password.png')
                          : Image.asset('assets/images/tag_forgot_password.png'),
                    ],
                  ),
                  const SizedBox(height: AppConstants.defaultSpacing),
                  Column(
                    children: [
                      ReusableTextField(
                        hintText: 'Email',
                        controller: emailController,
                        showSuffix: false,
                        isVisible: true, keyboardType: TextInputType.emailAddress, labelText: 'Email',
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomButtonBorder(
                    child: CustomButton(
                      onPressed: () {
                        if (emailController.text.isEmpty) {
                            ReusableSnackBar.showErrorSnackBar(context, 'Email address required');
                        } else {
                          
                        }
                      },
                      buttonText: 'Reset',
                      color: Colors.green,
                      buttonTextColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: AppConstants.defaultSpacing),
                  const SizedBox(height: AppConstants.largeSpacing),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../../reusable_widgets/snackbar.dart';
import '../../database/databaseHandler.dart';
import 'logic/validator.dart';
import 'reg_steppers/steps.dart';

class RegistrationFlow extends StatefulWidget {
  const RegistrationFlow({Key? key}) : super(key: key);

  @override
  _RegistrationFlowState createState() => _RegistrationFlowState();
}

class _RegistrationFlowState extends State<RegistrationFlow> {
  int currentStep = 0;

  // Data fields for each step

  String profilePic = ''; // You can store the image path or URL here

  TextEditingController firstNameController = TextEditingController();
  TextEditingController otherNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  TextEditingController dobController = TextEditingController();

  bool isVisible = false;


 
  // Step forms
  List<Step> get steps => [
        //step 1
        step1(
            currentStep: currentStep,
            isVisible: isVisible,
            firstNameController: firstNameController,
            otherNameController: otherNameController,
            onChanged: (text) {
              setState(() {});
            },
            phoneNumberController: phoneNumberController),

        //step 2

        step2(
          currentStep: currentStep,
          onChanged: (text) {
            setState(() {});
          },
          isVisible: isVisible,
          emailController: emailController,
          passwordController: passwordController,
          confirmPasswordController: confirmPasswordController,
          context: context,
          dobController: dobController,
        ),

        //step 3
        step3(
            currentStep: currentStep,
            onChanged: (text) {
              setState(() {});
            },
            isVisible: isVisible,
            bioController: bioController,
            profilePic: profilePic,
            context: context)
      ];

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Widget controlsBuilder(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (currentStep == steps.length - 1)
            FilledButton(
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(0),
              ),
              onPressed: () {
                submitUserDetails();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Submit',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.normal),
                ),
              ),
            )
          else
            FilledButton(
              style: const ButtonStyle(
                elevation: MaterialStatePropertyAll(0),
              ),
              onPressed: details.onStepContinue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Continue',
                  style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          const SizedBox(
            width: 5,
          ),
          OutlinedButton(
            style: const ButtonStyle(
              elevation: MaterialStatePropertyAll(0),
            ),
            onPressed: details.onStepCancel,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Cancel',
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration'),
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: currentStep,
        onStepTapped: onStepTapped,
        controlsBuilder: controlsBuilder,
        onStepContinue: () {
          if (currentStep < steps.length - 1) {
            setState(() {
              currentStep += 1;
            });
          }
        },
        onStepCancel: () {
          if (currentStep > 0) {
            setState(() {
              currentStep -= 1;
            });
          }
        },
        steps: steps,
      ),
    );
  }

  void submitUserDetails() {
    setState(() {
      if (Validator.isFirstNameValid(firstNameController.text) &&
          Validator.isOtherNameValid(otherNameController.text) &&
          Validator.isPhoneNumberValid(phoneNumberController.text) &&
          Validator.isEmailValid(emailController.text) &&
          Validator.isPasswordValid(passwordController.text) &&
          Validator.isConfirmPasswordValid(
              passwordController.text, confirmPasswordController.text)) {
        // All validations passed, proceed with your logic here.
        RegisterUser.proceedToRegisterUser(
          context,
          firstNameController.text.trim(),
          otherNameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
          bioController.text.trim(),
          dobController.text.trim(),
        );
      } else {
        // Handle validation failures, show error messages or take appropriate action.
        ReusableSnackBar.showErrorSnackBar(
            context, 'Please fill all fields correctly');
      }
    });
  }
}

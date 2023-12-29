import 'package:flutter/material.dart';

import '../../../animation/slide_in_animation.dart';
import '../../../reusable_widgets/checkIconWidget.dart';
import '../../../reusable_widgets/textfields.dart';
import '../logic/validator.dart';

Step step1({
  required int currentStep,
  required bool isVisible,
  required TextEditingController firstNameController,
  required TextEditingController phoneNumberController,
  required TextEditingController otherNameController,
  required Function(String)? onChanged,
}) {
  return Step(
    title: const Text('Step 1'),
    isActive: currentStep >= 0,
    state: currentStep >= 0 ? StepState.complete : StepState.disabled,
    content: Column(
      children: [
        const SizedBox(
          width: 10,
        ),
        SlideInAnimation(
          duration: const Duration(milliseconds: 1400),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableTextField(
                      onChanged: onChanged,
                      isVisible: isVisible,
                      hintText: 'First Name',
                      controller: firstNameController,
                      errorText: Validator.validateFirstName(
                          value: firstNameController.text),
                      showSuffix: false,
                      keyboardType: TextInputType.name, labelText: 'First Name',
                    ),
                    CheckIconVisibility(
                      visibility:
                          Validator.isFirstNameValid(firstNameController.text),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableTextField(
                      onChanged: onChanged,
                      isVisible: isVisible,
                      hintText: 'Other Name',
                      controller: otherNameController,
                      errorText: Validator.validateOtherName(
                          value: otherNameController.text),
                      showSuffix: false,
                      keyboardType: TextInputType.name, labelText: 'Other Name',
                    ),
                    CheckIconVisibility(
                      visibility:
                          Validator.isOtherNameValid(otherNameController.text),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SlideInAnimation(
          duration: const Duration(milliseconds: 1600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableTextField(
                onChanged: onChanged,
                isVisible: isVisible,
                hintText: 'Phone Number',
                controller: phoneNumberController,
                errorText: Validator.validatePhoneNumber(
                    value: phoneNumberController.text),
                showSuffix: false,
                keyboardType: TextInputType.phone, labelText: 'Phone Number',
              ),
              CheckIconVisibility(
                visibility:
                    Validator.isPhoneNumberValid(phoneNumberController.text),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
Step step2({
  required BuildContext context,
  required int currentStep,
  required Function(String)? onChanged,
  required bool isVisible,
  required TextEditingController emailController,
  required TextEditingController passwordController,
  required TextEditingController confirmPasswordController,
  required TextEditingController dobController,
}) {
  return Step(
    title: const Text('Step 2'),
    isActive: currentStep >= 1,
    state: currentStep >= 1 ? StepState.complete : StepState.disabled,
    content: Column(
      children: [
        SlideInAnimation(
          duration: const Duration(milliseconds: 1600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableTextField(
                onChanged: onChanged,
                isVisible: isVisible,
                hintText: 'Email',
                controller: emailController,
                errorText: Validator.validateEmail(value: emailController.text),
                showSuffix: false,
                keyboardType: TextInputType.emailAddress, labelText: 'Email',
              ),
              CheckIconVisibility(
                visibility: Validator.isEmailValid(emailController.text),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        GestureDetector(
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );

            if (selectedDate != null) {
              dobController.text = selectedDate.toLocal().toString().split(' ')[0];
            }
          },
          child: AbsorbPointer(
            child: TextField(
              controller: dobController,
              decoration: InputDecoration(
                hintText: 'Date of Birth',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () {},
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SlideInAnimation(
          duration: const Duration(milliseconds: 1800),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableTextField(
                onChanged: onChanged,
                isVisible: !isVisible,
                hintText: 'Password',
                controller: passwordController,
                errorText: Validator.validatePassword(value: passwordController.text),
                showSuffix: true,
                keyboardType: TextInputType.visiblePassword, labelText: 'Password',
              ),
              CheckIconVisibility(
                visibility: Validator.isPasswordValid(passwordController.text),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        SlideInAnimation(
          duration: const Duration(milliseconds: 2000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReusableTextField(
                onChanged: onChanged,
                isVisible: !isVisible,
                hintText: 'Confirm Password',
                controller: confirmPasswordController,
                errorText: Validator.validateConfirmPassword(
                  password: passwordController.text,
                  confirmPassword: confirmPasswordController.text,
                ),
                showSuffix: true,
                keyboardType: TextInputType.visiblePassword, labelText: 'Confirm Password',
              ),
              CheckIconVisibility(
                visibility: Validator.isConfirmPasswordValid(
                  passwordController.text,
                  confirmPasswordController.text,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}

Step step3(
    {required int currentStep,
    required Function(String)? onChanged,
    required bool isVisible,
    required TextEditingController bioController,
    required BuildContext context,
    required String profilePic}) {
  return Step(
    title: const Text('Step 3'),
    isActive: currentStep >= 2,
    state: currentStep >= 2 ? StepState.complete : StepState.disabled,
    content: Column(
      children: [
        GestureDetector(
          onTap: () {
            // Implement image selection logic
            // You can use plugins like image_picker to get an image
            // Update the profilePic variable with the image path or URL
          },
          child: CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            radius: 50.0,
            backgroundImage: profilePic.isNotEmpty
                ? NetworkImage(
                    profilePic) // Use the profilePic URL if available
                : null,
            child: profilePic.isEmpty
                ? Icon(
                    Icons.camera_alt,
                    size: 40.0,
                    color: Theme.of(context).colorScheme.onSecondary,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 30.0),
        ReusableTextField(
          onChanged: onChanged,
          isVisible: isVisible,
          hintText: 'Bio',
          controller: bioController,
          errorText: Validator.validateBio(value: bioController.text),
          showSuffix: false,
          keyboardType: TextInputType.text, labelText: 'Bio',
        ),
      ],
    ),
  );
}

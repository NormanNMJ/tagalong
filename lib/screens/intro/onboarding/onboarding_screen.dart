
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../constants/size_config.dart';
import '../../../reusable_widgets/page_navigator.dart';
import '../../auth/login_or_register.dart';
import 'model.dart';
import 'onboardingUi.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();

  //keep track if pages especially if we are on the last page
  bool onLastPage = false;
  bool onNextPage = false;
  bool onKeepPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: OnboardingModel.onboardingContent.length,
            onPageChanged: (index) {
              setState(() {
                onLastPage =
                    (index == OnboardingModel.onboardingContent.length - 1);
                onNextPage = (index >= 1 &&
                    index <= OnboardingModel.onboardingContent.length - 1);
                onKeepPage = (index == 0);
              });
            },
            itemBuilder: (context, index) {
              return onboardingScreen(
                headText: OnboardingModel.onboardingContent[index].headText,
                bottomText: OnboardingModel.onboardingContent[index].bottomText,
                imageStringLightMode: OnboardingModel
                    .onboardingContent[index].imageStringLightMode,
                imageStringDarkMode: OnboardingModel
                    .onboardingContent[index].imageStringDarkMode,
              );
            },
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //skip all slides

                if (onNextPage)
                  FilledButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0)),
                    onPressed: () {
                      _controller.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Back',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                             .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  )
                else
                  FilledButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0)),
                    onPressed: () {
                      _controller.keepPage;
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Back',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                             .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  ),

                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: JumpingDotEffect(
                    offset: 16,
                    verticalOffset: 16,
                    dotHeight: 8,
                    dotWidth: 8,
                    dotColor: Colors.black54,
                    activeDotColor: Theme.of(context).colorScheme.primary,
                  ),
                ),

                //show done at the last slide

                if (onLastPage)
                  FilledButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0)),
                    onPressed: () {
                      PageNavigator.popScreen(context);
                      PageNavigator.navigateToNextPage(
                          context, const LoginOrRegister());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Get Started',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                           .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  )
                else
                  FilledButton(
                    style: const ButtonStyle(
                        elevation: MaterialStatePropertyAll(0)),
                    onPressed: () {
                      _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Next',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Visibility(
            visible: !onLastPage,
            child: Positioned(
              top: AppConstants.defaultSpacing,
              right: AppConstants.defaultSpacing,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.defaultSpacing),
                child:  OutlinedButton(
                      style: const ButtonStyle(
                          elevation: MaterialStatePropertyAll(0)),
                      onPressed: () {
                       _controller.jumpToPage(2);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Skip',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

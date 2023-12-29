class OnboardingModel {
  final String headText;
  final String bottomText;
  final String imageStringLightMode;
  final String imageStringDarkMode;

  OnboardingModel({
    required this.headText,
    required this.bottomText,
    required this.imageStringLightMode,
    required this.imageStringDarkMode,
  });

  static List<OnboardingModel> onboardingContent = [
    OnboardingModel(
      headText: 'ENJOY THE EXPERIENCE',
      bottomText: 'HAVE FUN',
      imageStringLightMode: 'assets/images/tag_party.png',
      imageStringDarkMode: 'assets/images/tag_party.png',
    ),
    OnboardingModel(
      headText: 'ASSOCIATE WITH FRIENDS AND FAMILY',
      bottomText: 'INTERACT',
      imageStringLightMode: 'assets/images/tag_group.png',
      imageStringDarkMode: 'assets/images/tag_group.png',
    ),
    OnboardingModel(
      headText: 'GET THE MOST OUT OF YOUR DAY',
      bottomText: 'EXPLORE',
      imageStringLightMode: 'assets/images/tag_travel.png',
      imageStringDarkMode: 'assets/images/tag_travel.png',
    ),
  ];
}


import 'package:base_code/res/images.dart';
import '../../package/config_packages.dart';

class OnboardingController extends GetxController {
  var isLoading = false.obs;
  final RxList<Map<String, dynamic>> onboardingData = [
    {
      'image': AppImage.onboarding,
      'text': 'Find the best car\nwithout headaches',
      'text1': 'You choose your car online. We inspect\n it and deliver it.'
    },
    {
      'image': AppImage.onboarding1,
      'text': 'Choose car right\n for you',
      'text1': 'Answer a few quick questions to find\n the right car for you.'
    },
    {
      'image': AppImage.onboarding2,
      'text': 'Let’s get started',
      'text1': 'Sign up or login to see what\n happening near you'
    },
  ].obs;

  final RxList imageList = [
    AppImage.google,
    AppImage.apple,
  ].obs;


  RxInt currentPageIndex = 0.obs;
}

import 'package:base_code/module/onboarding/onboarding_controller.dart';
import 'package:base_code/package/screen_packages.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../package/config_packages.dart';
import '../../res/images.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final onboardingController =
  Get.put<OnboardingController>(OnboardingController());
  final Rx<PageController> controller = PageController().obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: controller.value,
        itemCount: onboardingController.onboardingData.length,
        itemBuilder: (BuildContext context, int index) {
          return onBoarding(
            index: index,
            image: onboardingController.onboardingData[index]['image'] ?? "",
            text: onboardingController.onboardingData[index]['text'] ?? "",
            text1: onboardingController.onboardingData[index]['text1'] ?? "",
          );
        },
        onPageChanged: (int index) {
          onboardingController.currentPageIndex.value = index;
        },
      ),
    );
  }
// 
  Container onBoarding({
    final String? image,
    final String? text,
    final String? text1,
    final int? index,
  }) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image!),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (index != 2) ...[
              const Gap(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: controller.value,
                    count: onboardingController.onboardingData.length,
                    effect: ExpandingDotsEffect(
                      activeDotColor: Colors.white,
                      dotColor: index == 0
                          ? AppColor.greyscale
                          : AppColor.primary,
                      dotHeight: 6,
                      dotWidth: 6,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.value.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                    child: Text(
                      "Skip",
                      style: const TextStyle().normal16w700.textColor(
                        index == 0 ? AppColor.blueColor1 : AppColor.white,
                      ),
                    ),
                  ),
                ],
              ),
            ] else ...[
              const Gap(30),
              Image.asset(AppImage.logo, height: 24, width: 114),
            ],
            const Gap(60),
            Text(
              text ?? "",
              style: const TextStyle().normal32w700.textColor(Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              text1!,
              style: const TextStyle().normal16w500.textColor(AppColor.gray300),
            ),
            const Spacer(),
            if (index == 2) ...[
              Column(
                children: [
                  CommonAppButton(
                    text: 'Continue with Email',
                    style: const TextStyle().normal16w700.textColor(AppColor.blueColor1),
                    color: AppColor.white,
                    buttonType: ButtonType.enable,
                    onTap: (){
                    ButtonType.progress;
                      Get.toNamed(Routes.signInScreen);
                    },
                  ),

                  const SizedBox(height: 16),

                  CommonAppButton(
                    imagePath: onboardingController.imageList[0],
                    text: 'Continue with Google',
                    style: const TextStyle().normal16w500.textColor(AppColor.white),
                    color: Colors.transparent,
                    border: Border.all(color: AppColor.primary),
                    buttonType: ButtonType.enable,

                  ),
                  const SizedBox(height: 16),

                  CommonAppButton(
                    imagePath: onboardingController.imageList[1],
                    text: 'Continue with Apple',
                    style: const TextStyle().normal16w500.textColor(AppColor.white),
                    color: Colors.transparent,
                    border: Border.all(color: AppColor.primary),
                    buttonType: ButtonType.enable,
                  ),
                  const Gap(37)
                ],
              )
            ] else ...[
              CommonAppButton(
                text: 'Get Started',
                style: const TextStyle().normal16w700.textColor(index == 0?AppColor.white:AppColor.blueColor1),
                color: index == 0?AppColor.blueColor1:AppColor.white,
                border: Border.all(color:index == 0?AppColor.blueColor1:AppColor.white),
                buttonType: ButtonType.enable,
                onTap: (){
                  ButtonType.progress;
                  Get.toNamed(Routes.signInScreen);

                },
              ),

              const Gap(37)
            ]
          ],
        ),
      ),
    );
  }
}

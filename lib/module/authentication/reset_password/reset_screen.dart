import 'package:base_code/module/authentication/reset_password/reset_controller.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:base_code/package/screen_packages.dart';
import 'package:base_code/res/images.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final resetController = Get.put<ResetController>(ResetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 60),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.clear, size: 24, weight: 12),
                const Gap(64),
                Center(
                  child: Image.asset(
                    AppImage.forgotPassword,
                    height: 96,
                    width: 96,
                  ),
                ),
                const Gap(32),
                Column(
                  children: [
                    Center(
                        child: Text(
                      "Can’t sign in?",
                      style: const TextStyle()
                          .normal24w700
                          .textColor(AppColor.greyscale100),
                    )),
                    const Gap(8),
                    Text(
                      "Enter the email associated with your",
                      style: const TextStyle()
                          .normal16w500
                          .textColor(AppColor.greyScaleColor),
                    ),
                    Text(
                      "account, and Carline will send you a link",
                      style: const TextStyle()
                          .normal16w500
                          .textColor(AppColor.greyScaleColor),
                    ),
                    Center(
                        child: Text(
                      "to reset yor password",
                      style: const TextStyle()
                          .normal16w500
                          .textColor(AppColor.greyScaleColor),
                    )),
                  ],
                ),
                const Gap(16),
                CommonText(
                  prefixIcon: const Icon(
                    Icons.mail,
                    size: 20,
                    color: AppColor.greyScale,
                  ),
                  hintText: "Email",
                  controller: resetController.emailController,
                ),
                const Gap(161),
                CommonAppButton(
                  text: 'Reset Password',
                  buttonType: resetController.isLoading.value==true?ButtonType.progress:ButtonType.enable,
                  border: Border.all(color:AppColor.blueColor1 ),
                  textColor: AppColor.white,
                   color: AppColor.blueColor1,
                   onTap: (){
                    resetController.isLoading.value=true;
                     resetController.resetPassword(
                         resetController.emailController.text, context);
                   },
                ),

                const Gap(16),
                CommonAppButton(
                  border: Border.all(color: AppColor.blueColor1),
                  text: 'Return to Sign In',
                  style: const TextStyle().normal16w700,
                  textColor: AppColor.blueColor1,
                  color: AppColor.white,
                  buttonType:  resetController.isLoading.value==true?ButtonType.progress:ButtonType.enable,
                  onTap: () {
                    resetController.isLoading.value=true;

                    Get.toNamed(Routes.signInScreen);
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
//

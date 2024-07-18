import 'package:base_code/module/authentication/sign_up/sign_up_controller.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:base_code/package/screen_packages.dart';
import 'package:flutter/gestures.dart';
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
class _SignUpScreenState extends State<SignUpScreen> {
  final signUpController = Get.put<SignUpController>(SignUpController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();

        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60.0,right: 24,left: 24.0,bottom: 46),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                    child: const Icon(Icons.clear,size: 24,weight: 12,)),
                const Gap(20),
                Text("Sign Up",style: const TextStyle().normal32w700.textColor(AppColor.greyscale100),),
                const Gap(24),
                CommonText(
                  prefixIcon: const Icon(Icons.person_rounded,size: 20,color: AppColor.greyScale,),
                  hintText: "Full name",
                  controller: signUpController.nameController,
                ),
                const Gap(12),
                CommonText(
                  keyboardType: TextInputType.emailAddress,

                  prefixIcon: const Icon(Icons.mail,size: 20,color: AppColor.greyScale,),
                  hintText: "Email",
                  controller: signUpController.emailController,
                ),
                const Gap(12),
                CommonText(
                    prefixIcon: const Icon(Icons.lock,size: 20,color: AppColor.greyScale,),
                    obscureText: !signUpController.passwordVisible.value,
                    controller: signUpController.passwordController,
                    hintText: "Password",
                    suffixIcon:GestureDetector(
                      onTap: (){
                        signUpController.passwordVisible.value =!signUpController.passwordVisible.value;
                      },
                      child: Icon(signUpController.passwordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,color: AppColor.greyScale,),
                    ),
                ),
                const Gap(12),
                RichText(
                  text: TextSpan(
                      text: 'By signing up, you agree to our ',
                      style: const TextStyle().normal16w500.textColor(AppColor.greyScaleColor),
                      children: <TextSpan>[
                        TextSpan(text: 'Terms of Service',
                            style: const TextStyle().normal16w700.textColor(AppColor.blueColor1),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                              }
                        ),
                        TextSpan(text: ' and',
                            style: const TextStyle().normal16w500.textColor(AppColor.greyScaleColor),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                              }
                        ) ,
                        TextSpan(text: ' Privacy Policy',
                            style: const TextStyle().normal16w700.textColor(AppColor.blueColor1),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                              }
                        )
                      ]
                  ),
                ),
                const Gap(20),
                CommonAppButton(
                  text: 'Sign Up',
                  style: const TextStyle().normal16w700.textColor(AppColor.white),
                  color: AppColor.blueColor1,
                  buttonType:signUpController.isLoading.value==true?ButtonType.progress:ButtonType.enable,
                  onTap: (
                  )async{
                    signUpController.isLoading.value=true;
                    await signUpController.signUp(
                        signUpController.emailController.text,
                        signUpController.passwordController.text,
                        signUpController.nameController.text,
                        context
                    );                     },
                ),

                const SizedBox(height: 16),

                CommonAppButton(
                  imagePath: signUpController.imageList[1],
                  text: 'Continue with Google',
                  style: const TextStyle().normal16w500.textColor(AppColor.greyscale100),
                  color: Colors.transparent,
                  border: Border.all(color: AppColor.greyscale200),
                  buttonType: ButtonType.enable,

                ),
                const SizedBox(height: 16),

                CommonAppButton(
                  imagePath: signUpController.imageList[2],

                  text: 'Continue with Apple',
                  imageColor: AppColor.black,
                  style: const TextStyle().normal16w500.textColor(AppColor.greyscale100),
                  color: Colors.transparent,
                  border: Border.all(color: AppColor.greyscale200),
                  buttonType: ButtonType.enable,
                ),
                const SizedBox(height: 82,),
                Center(
                  child: RichText(
                    text: TextSpan(
                        text: 'Already have and account? ',
                        style: const TextStyle().normal16w500.textColor(AppColor.black),
                        children: <TextSpan>[
                          TextSpan(text: 'Sign In',
                              style: const TextStyle().normal16w700.textColor(AppColor.blueColor1),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.toNamed(Routes.signInScreen);
                                }
                          )
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


import 'package:base_code/module/authentication/sign_in/sign_in_controller.dart';
import 'package:base_code/package/screen_packages.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final signInController = Get.put<SignInController>(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "Sign in to Carline",
                      style: const TextStyle()
                          .normal32w700
                          .textColor(AppColor.greyscale100),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Welcome back! Please enter your details.",
                      style: const TextStyle()
                          .normal16w500
                          .textColor(AppColor.greyScaleColor),
                    ),
                    const SizedBox(height: 24),
                    CommonText(
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(
                        Icons.mail,
                        size: 20,
                        color: AppColor.greyScale,
                      ),
                      hintText: "Email",
                      controller: signInController.emailController.value,
                    ),
                    const SizedBox(height: 16),
                    Obx(
                          ()=> CommonText(
                        prefixIcon: const Icon(
                          Icons.lock,
                          size: 20,
                          color: AppColor.greyScale,
                        ),
                        obscureText: !signInController.passwordVisible.value,
                        controller: signInController.passwordController.value,
                        hintText: "Password",
                        suffixIcon: GestureDetector(
                          onTap: (){
                            signInController.passwordVisible.value =!signInController.passwordVisible.value;
                          },
                          child: Icon(signInController.passwordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,color: AppColor.greyScale,),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: 'Forgot password?',
                        style: const TextStyle()
                            .normal16w500
                            .textColor(AppColor.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: ' Reset it',
                            style: const TextStyle()
                                .normal16w700
                                .textColor(AppColor.blueColor1),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamed(Routes.resetScreen);
                              },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    CommonAppButton(
                      text: 'Sign In',
                      style: const TextStyle().normal16w700.textColor(AppColor.white),
                      color: AppColor.blueColor1,
                      buttonType: signInController.isLoading.value==true?ButtonType.progress:ButtonType.enable,
                      onTap: (){
                        signInController.isLoading.value=true;
                        signInController.signInWithEmailAndPassword(
                            signInController.emailController.value.text,
                            signInController.passwordController.value.text,
                            context);
                        signInController.isLoading.value=false;

                      },
                    ),

                    const SizedBox(height: 16),

                    CommonAppButton(
                      imagePath: signInController.imageList[1],
                      text: 'Continue with Google',
                      style: const TextStyle().normal16w500.textColor(AppColor.greyscale100),
                      color: Colors.transparent,
                      border: Border.all(color: AppColor.greyscale200),
                      buttonType: ButtonType.enable,

                    ),
                    const SizedBox(height: 16),

                    CommonAppButton(
                      imagePath: signInController.imageList[2],

                      text: 'Continue with Apple',
                      imageColor: AppColor.black,
                      style: const TextStyle().normal16w500.textColor(AppColor.greyscale100),
                      color: Colors.transparent,
                      border: Border.all(color: AppColor.greyscale200),
                      buttonType: ButtonType.enable,
                    ),
                  ],
                ),
               
                const SizedBox(height: 90),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Don’t have an account?',
                      style: const TextStyle()
                          .normal16w500
                          .textColor(AppColor.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' Sign Up',
                          style: const TextStyle()
                              .normal16w700
                              .textColor(AppColor.blueColor1),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushNamed(Routes.signUpScreen);
                            },
                        ),
                      ],
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

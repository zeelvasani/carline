import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:local_auth/local_auth.dart';
import '../../app_route.dart';
import '../../data/pref/app_preferences.dart';
import '../../res/images.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>{
  final LocalAuthentication localAuth = LocalAuthentication();
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      nextToPage();
    });
  }
  Future<void> checkAuth() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        List<BiometricType> availableBiometrics = await localAuth
            .getAvailableBiometrics();
        if (availableBiometrics.contains(BiometricType.strong)) {
          if (AppPref().didAuthenticate == true) {
            localAuth.authenticate(
              localizedReason: 'Please authenticate to show account balance',
              options: const AuthenticationOptions(biometricOnly: true),
            );
            if(AppPref().pickCarSkip == true){
              Get.offNamed(Routes.bottomNavigationBar);
            }else if(AppPref().pickCar == true){
              Get.offNamed(Routes.bottomNavigationBar);
            }else if(AppPref().pickCar == false){
              Get.offNamed(Routes.pickCarScreen);
            }
          } else if(AppPref().didAuthenticate == false) {
            Get.offNamed(Routes.authenticationScreen);
          }else if (AppPref().skipAuthenticate == true){
            Get.offNamed(Routes.bottomNavigationBar);
          }
        }
        else{
          if (AppPref().authenticate == true) {
            Get.offNamed(Routes.accessCodeScreen);
          }
          else if(AppPref().authenticate == false) {
            Get.offNamed(Routes.authenticationScreen);
          }
          else if(AppPref().skipAuthenticate == true){
            Get.offNamed(Routes.bottomNavigationBar);

          }
        }
      } else {
        Get.offNamed(Routes.signInScreen);
      }
    } else {
      Get.offNamed(Routes.onboarding);
    }
  }
  void nextToPage() {
    checkAuth();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImage.splashscreen,
          height: 40,
          width: 185,
        ),
      ),
    );
  }
}
//
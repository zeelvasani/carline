


import 'package:base_code/app_route.dart';
import 'package:base_code/res/images.dart';
import 'package:local_auth/local_auth.dart';

import '../../../package/config_packages.dart';

class SignInController extends GetxController {
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  RxBool isSigningIn = false.obs;
  RxBool isLoading = false.obs;
  RxBool passwordVisible = false.obs;

  final RxList imageList = [
    AppImage.mail,
    AppImage.google,
    AppImage.apple,
  ].obs;

  Future<void> signInWithEmailAndPassword(String email, String password,context) async {
    try {
      final LocalAuthentication localAuth = LocalAuthentication();

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final FirebaseAuth auth = FirebaseAuth.instance;
        auth.authStateChanges().listen((user)async {
          if (user != null) {
            user.reload();
            if (user.emailVerified)  {
              List<BiometricType> availableBiometrics = await localAuth
                  .getAvailableBiometrics();
              if (availableBiometrics.contains(BiometricType.strong)) {
                Get.offNamed(Routes.authenticationScreen);
              }else{
                Get.offNamed(Routes.accessCodeScreen);
              }


            }else{
               userCredential.user!.sendEmailVerification();
              Get.offNamed(Routes.verificationScreen);
            }
          }
        });

    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign In Failed'),
            content:
            const Text('Invalid email or password. Please try again.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> resetPassword(String email,context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password Reset Email Sent'),
            content: Text(
                'A password reset link has been sent to $email.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Password Reset Failed'),
            content: const Text(
                'Failed to send password reset email. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

}
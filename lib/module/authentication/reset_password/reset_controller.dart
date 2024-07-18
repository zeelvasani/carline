import 'package:base_code/app_route.dart';
import 'package:base_code/package/config_packages.dart';

class ResetController extends GetxController{
  RxBool isLoading = true.obs;

  TextEditingController emailController=TextEditingController();
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
                  Get.toNamed(Routes.signInScreen);
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
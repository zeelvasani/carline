
// ignore_for_file: unnecessary_import

import 'package:base_code/app_route.dart';
import 'package:get/get.dart';

import '../../../package/config_packages.dart';
import '../../../res/images.dart';

class SignUpController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool passwordVisible = false.obs;
  RxBool isLoading = false.obs;
  RxList imageList = [
    AppImage.mail,
    AppImage.google,
    AppImage.apple,
  ].obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  Future<void> signUp(String email, String password, String name,context) async {
    try {
      UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.sendEmailVerification();
      await fireStore.collection('users').doc(userCredential.user!.uid).set({
        'userid': userCredential.user!.uid,
        'name': name,
        'email': email,
      });
      Get.offNamed(Routes.verificationScreen);
    }  catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sign Up Failed'),
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
}
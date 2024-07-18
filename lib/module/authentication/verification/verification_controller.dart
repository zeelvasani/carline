
import 'package:local_auth/local_auth.dart';

import '../../../app_route.dart';
import '../../../package/config_packages.dart';
import '../../../res/images.dart';

class VerificationController extends GetxController {
  RxBool isModalShown = false.obs;
  RxBool isLoading = true.obs;
  RxBool isEmailVerified = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;

  showPasscodeModal(BuildContext context) {
    if (!isModalShown.value) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    AppImage.verified,
                    height: 30,
                    width: 30,
                  ),
                  const Text('Your mail id is verified'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final LocalAuthentication localAuth =
                      LocalAuthentication();

                      try {
                        List<BiometricType> availableBiometrics =
                        await localAuth.getAvailableBiometrics();
                        if (availableBiometrics
                            .contains(BiometricType.strong)) {
                          Get.offNamed(Routes.authenticationScreen);
                        } else {
                          Get.offNamed(Routes.accessCodeScreen);
                        }
                      } catch (e) {
                        return;
                      }
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
          );
        },
      );

      isModalShown.value = true;
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> checkEmailVerification(context) async {
    try {
      Timer.periodic(const Duration(seconds: 20), (timer) {
        _auth.authStateChanges().listen((user) {
          if (user != null) {
            user.reload();
            if (user.emailVerified) {
                isEmailVerified.value = user.emailVerified;

                isLoading.value = false;
                showPasscodeModal(context);
            }
          }
        });
      }
      ); //
    } catch (e) {
      return;
    }
  }

}
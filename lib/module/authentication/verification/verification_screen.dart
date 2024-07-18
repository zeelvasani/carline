import 'package:base_code/module/authentication/verification/verification_controller.dart';
import 'package:base_code/package/config_packages.dart';


class VerificationScreen extends StatefulWidget {
  const VerificationScreen({
    super.key,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final verificationController =
  Get.put<VerificationController>(VerificationController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      verificationController.checkEmailVerification(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Verification Screen'),
      ),
      body: verificationController.isLoading.value
          ? const Center(child: Text("Verify your Mail "))
          : verificationController.isEmailVerified.value
              ? const SizedBox()
              : const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Your email is not verified'),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
    );
  }
}

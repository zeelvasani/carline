import 'package:base_code/app_route.dart';
import 'package:base_code/components/otp_field_widget.dart';
import 'package:base_code/data/pref/app_preferences.dart';
import 'package:base_code/package/config_packages.dart';
import '../../../components/image_button.dart';
class AccessCodeScreen extends StatefulWidget {
  const AccessCodeScreen({super.key});
  @override
  State<AccessCodeScreen> createState() => _AccessCodeScreenState();
}
class _AccessCodeScreenState extends State<AccessCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: OtpFieldWidget(
              buttonType: ButtonType.enable,
              onButtonTap: (val) {
                if (AppPref().authenticate == true) {
                  if (val == AppPref().otp) {
                    if(AppPref().pickCarSkip == true){
                      Get.offNamed(Routes.bottomNavigationBar);
                    }else if(AppPref().pickCar == true){
                      Get.offNamed(Routes.bottomNavigationBar);
                    }else if(AppPref().pickCar == false){
                      Get.offNamed(Routes.pickCarScreen);
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Invalid OTP'),
                      ),
                    );
                  }
                } else {
                  AppPref().otp = val;
                  AppPref().authenticate = true;
                  if(AppPref().pickCarSkip == true){
                    Get.offNamed(Routes.bottomNavigationBar);
                  }else if(AppPref().pickCar == true){
                    Get.offNamed(Routes.bottomNavigationBar);
                  }else if(AppPref().pickCar == false){
                    Get.offNamed(Routes.pickCarScreen);
                  }
                }
              },
              text: "Secure the application",
              subText: "Choose an access code",
            ),
          ),
        ],
      ),
    );
  }
}

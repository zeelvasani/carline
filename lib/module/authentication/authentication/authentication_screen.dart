import 'package:base_code/package/screen_packages.dart';
import 'package:base_code/res/images.dart';
import 'package:local_auth/local_auth.dart';
import 'package:base_code/package/config_packages.dart';

import 'authentication_controller.dart';


class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});
  @override
  State<AuthenticationScreen> createState() => AuthenticationScreenState();
}
class AuthenticationScreenState extends State<AuthenticationScreen> {

  final authenticationController = Get.put<AuthenticationController>(AuthenticationController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

        body:  Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 24.0,left: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(AppImage.fingerprint,height: 136,width: 136,),
                Column(
                  children: [
                    Center(child: Text("Enable Fingerprint",style: const TextStyle().normal24w700.textColor(AppColor.greyscale100),)),
                    const Gap(8),
                    Text("You can use Fingerprint to access your",style: const TextStyle().normal16w500.textColor(AppColor.greyScaleColor),),
                    Text("account, so you won't need to type your",style: const TextStyle().normal16w500.textColor(AppColor.greyScaleColor),),
                    Center(child: Text("password Each time",style: const TextStyle().normal16w500.textColor(AppColor.greyScaleColor),)),
                  ],
                ),
                const Gap(165),
                CommonAppButton(
                  color: AppColor.blueColor1,
                  text: 'Use Fingerprint',
                  buttonType: authenticationController.isLoading.value==true?ButtonType.progress:ButtonType.enable,
                  onTap: ()async{
                    authenticationController.isLoading.value=true;
                    final LocalAuthentication localAuth = LocalAuthentication();
                    final bool didAuthenticate = await localAuth.authenticate(
                      localizedReason: 'Please authenticate to show account balance',
                      options: const AuthenticationOptions(biometricOnly: true),
                    );
                    if (didAuthenticate) {
                      AppPref().didAuthenticate = true;
                      Get.offNamed(Routes.pickCarScreen);

                    }
                    authenticationController.isLoading.value=false;

                  },
                ),
                const Gap(12),
                CommonAppButton(
                  text:'No, Thanks',
                  border: Border.all(color:AppColor.greyscale100),
                  textColor:AppColor.greyscale100 ,
                  buttonType: ButtonType.enable,
                  onTap: (){
                    AppPref().skipAuthenticate = true;
                    Get.offNamed(Routes.bottomNavigationBar);
                    AppPref().skipAuthenticate = false;

                  },
                ),

              ],
            ),
          ),
        ));
  }
}

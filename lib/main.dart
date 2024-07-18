import 'package:base_code/data/network/dio_client.dart';
import 'package:base_code/package/screen_packages.dart';
import 'firebase_options.dart';
import 'package/config_packages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await AppPref().isPreferenceReady;
  await dioSetUp();
  Get.put<GlobalController>(GlobalController());
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final String defaultLocale = Platform.localeName.split('_')[0];
  AppPref().languageCode = (defaultLocale.toLowerCase() == 'ar') ? defaultLocale : 'en';
  if (AppPref().languageCode.isEmpty) {
    AppPref().languageCode = 'en';
  }

  runApp(const SampleApp());
}


/// change language code
// changeLanguage() async {
//   if (AppPref().languageCode == "bn") {
//     Get.updateLocale(
//         Locale(Get.locale?.languageCode == 'bn' ? 'en' : 'bn', ''));
//     AppPref().languageCode = Get.locale?.languageCode ?? '';
//   }
//   else if (AppPref().languageCode == "en") {
//     Get.updateLocale(
//         Locale(Get.locale?.languageCode == 'bn' ? 'en' : 'bn', ''));
//     AppPref().languageCode = Get.locale?.languageCode ?? '';
//   }
// }
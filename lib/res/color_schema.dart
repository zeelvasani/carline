
import 'package:base_code/data/pref/app_preferences.dart';
import 'package:base_code/package/config_packages.dart';


abstract class AppColor {


  const AppColor._();
  static bool isDarkTheme() {
    return Get.isDarkMode;
  }

  static changeThemeMode() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(ThemeMode.light);
      AppPref().isDark = false;
    } else {
      Get.changeThemeMode(ThemeMode.dark);
      AppPref().isDark = true;
    }
  }




  static Color backGroundColor(){
    return isDarkTheme()
        ? DarkTheme.backGroundColor
        : LightTheme.backGroundColor;
  }

  static Color darkGray(){
    return isDarkTheme()
        ? DarkTheme.darkGray
        : LightTheme.darkGray;
  }

  static Color lightNatural(){
    return isDarkTheme()
        ? DarkTheme.lightNatural
        : LightTheme.lightNatural;
  }
  static Color gray(){
    return isDarkTheme()
        ? DarkTheme.gray
        : LightTheme.gray;
  }

  static Color cardColor(){
    return isDarkTheme()
        ? DarkTheme.cardColor
        : LightTheme.cardColor;
  }
  static Color cardTextColor(){
    return isDarkTheme()
        ? DarkTheme.cardTextColor
        : LightTheme.cardTextColor;
  }
  static Color orange(){
    return isDarkTheme()
        ? DarkTheme.orange
        : LightTheme.orange;
  }
  static Color purple(){
    return isDarkTheme()
        ? DarkTheme.purple
        : LightTheme.purple;
  }

  static const disableButtonColor = Color(0xFFADA9A6);

  ///app color
  ///
  /// dfr
  ///
  ///







  static const primaryColor = Color(0xFF2962A1);
  static const greyScale500 = Color(0xFF64748B);
  static const greyscale100 = Color(0xFF0F172A);
  static const grey = Color(0x2B000000);
  static const greyColor = Color(0x40000000);
  static const greenColor100 = Color(0xFF22C55E);
  static const greenColor200 = Color(0xFFEEFCF3);
  static const redColor200 = Color(0xFFFFF0F0);
  static const shadowColor = Color(0xFF475569);
  static const grey500 = Color(0xFF6B7280);
  static const greyscale1Color = Color(0xFF111827);
  static const primaryColorLight = Color(0xFF196CFA);
  static const defaultIconColor = Color(0xFFA1A1AA);
  static const white = Color(0xFFFFFFFF);
  static const borderColor = Color(0xFFE4E4E7);
  static const bgBlueColor = Color(0xFFF6FBFF);
  static const greyscale = Color(0xFF2A3646);
  static const  blueColor1= Color(0xFF4038FF);
  static const  geryScale= Color(0xFFF1F5F9);
  static const  lightBlack= Color(0xFF454545);
  static const  primary= Color(0xFF7974FF);
  static const  white100= Color(0xFFC6C3FF);

  static const greenColor = Color(0xFF67B64D);
  static const redColor = Color(0xFFEB5E4D);
  static const blueColor = Color(0xFF89B6E0);
  static const blueColor200 = Color(0xFF534CFF);
  static const yellowColor = Color(0xFFFBDA1B);

  static const purpleColor = Color(0xFF7A87FB);
  static const black = Color(0xFF020408);
  static const gray500 = Color(0xFF71717A);
  static const gray700 = Color(0xFFFEF2F6);
  static const textFieldFillColor = Color(0xFFF8FAFC);
  static const primaryBlueColor = Color(0xFFE4F1F9);
  static const greyscale200 = Color(0xFFEEF2F6);
  static const greyscale400 = Color(0xFFCBD5E1);
  static const greyscale300 = Color(0xFFF5F5FF);
  static const greyScaleColor = Color(0xFF64748B);
  static const unTabColor = Color(0xFF52525B);
  static const tableDataRow = Color(0xFFF9FAFB);
  static const gray300 = Color(0xFFD4D4D8);





  static const purpleGradient1 = Color(0xff776DF2);
  static const subBlack = Color(0xff615B5C);

  static const gray100 = Color(0xFFF4F4F5);
  static const logbook = Color(0xFFEAE8E8);
  static const greyScale = Color(0xFF94A3B8);
  static const gray600 = Color(0xFF475569);
  static const gray800 = Color(0xFF1E293B);
  static const bodyBackGroundColor = Color(0xFFF6FBFF);
  static const blueColor100 = Color(0x4038FF40);







}

class LightTheme {
  static const backGroundColor = Color(0xFF323234);
  static const darkGray = Color(0xFF979392);
  static const lightNatural = Color(0xFFF6F1ED);
  static const orange = Color(0xFFF37240);
  static const purple = Color(0xFF7B4B89);
  static const gray = Color(0xFF979392);
  static const cardColor = Color(0xFFF37240);
  static const cardTextColor = Color(0xFF323234);

}

class DarkTheme {
  static const backGroundColor = Color(0xFF323234);
  static const darkGray = Color(0xFF979392);
  static const lightNatural = Color(0xFFF6F1ED);
  static const orange = Color(0xFFF37240);
  static const purple = Color(0xFF7B4B89);
  static const gray = Color(0xFF979392);
  static const cardColor = Color(0xFFF37240);
  static const cardTextColor = Color(0xFF323234);

}
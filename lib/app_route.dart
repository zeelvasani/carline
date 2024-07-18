

import 'package:base_code/module/authentication/access_code/access_code_screen.dart';

import 'package:get/get.dart';



import 'module/authentication/authentication/authentication_screen.dart';
import 'module/authentication/reset_password/reset_screen.dart';
import 'module/authentication/sign_in/sign_in_screen.dart';
import 'module/authentication/sign_up/sign_up_screen.dart';

import 'module/authentication/verification/verification_screen.dart';
import 'module/bottom_navigation/bottom_navigation_bar.dart';

import 'module/homepage/buy_car/address/address_screen.dart';
import 'module/homepage/buy_car/inspection/inspection_screen.dart';
import 'module/homepage/buy_car/payment/payment_screen.dart';
import 'module/homepage/buy_car/purchase_method_screen/purchase_method_screen.dart';
import 'module/homepage/car_detail/car_detail_screen.dart';
import 'module/homepage/credit_simulation/credit_screen.dart';
import 'module/homepage/home_screen/home_screen.dart';
import 'module/homepage/live_location/live_location_screen.dart';
import 'module/homepage/pick_car/pick_car_screen.dart';
import 'module/homepage/view_car/view_car_screen.dart';
import 'module/onboarding/onboarding_screen.dart';
import 'module/splash/splash_screen.dart';

abstract class Routes {
  static const splashScreen = '/splashscreen';
  static const onboarding = '/onboarding';
  static const signInScreen = '/signInScreen';
  static const signUpScreen = '/signUpScreen';
  static const homeScreen = '/homeScreen';
  static const verificationScreen = '/verificationScreen';
  static const bottomNavigationBar = '/bottomNavigationBar';
  static const resetScreen = '/resetScreen';
  static const authenticationScreen = '/authenticationScreen';
  static const accessCodeScreen = '/accessCodeScreen';
  static const pickCarScreen = '/pickCarScreen';
  static const liveLocationScreen = '/liveLocationScreen';
  static const viewCarScreen = '/viewCarScreen';
  static const carDetailScreen = '/carDetailScreen';
  static const creditScreen = '/creditScreen';
  static const purchaseMethodScreen = '/purchaseMethodScreen';
  static const inspectionScreen = '/inspectionScreen';
  static const addressScreen = '/addressScreen';
  static const paymentScreen = '/paymentScreen';


  static final pages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: onboarding, page: () =>  const OnboardingScreen()),
    GetPage(name: signInScreen, page: () =>  const SignInScreen()),
    GetPage(name: signUpScreen, page: () =>  const SignUpScreen()),
    GetPage(name: homeScreen, page: () =>  const HomeScreen()),
    GetPage(name: verificationScreen, page: () =>   const VerificationScreen()),
    GetPage(name: bottomNavigationBar, page: () =>    const BottomBarScreen()),
    GetPage(name: resetScreen, page: () =>    const ResetScreen()),
    GetPage(name: authenticationScreen, page: () =>    const AuthenticationScreen()),
    GetPage(name: accessCodeScreen, page: () =>    const AccessCodeScreen()),
    GetPage(name: pickCarScreen, page: () =>    const PickCarScreen()),
    GetPage(name: liveLocationScreen, page: () =>   const LiveLocationScreen()),
    GetPage(name: viewCarScreen, page: () =>   const ViewCarScreen()),
    GetPage(name: carDetailScreen, page: () =>    const CarDetailScreen()),
    GetPage(name: creditScreen, page: () =>    const CreditScreen()),
    GetPage(name: purchaseMethodScreen, page: () =>    const PurchaseMethodScreen()),
    GetPage(name: inspectionScreen, page: () =>    const InspectionScreen()),
    GetPage(name: addressScreen, page: () =>    const AddressScreen()),
    GetPage(name: paymentScreen, page: () =>    const PaymentScreen()),



  ];
}

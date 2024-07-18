import 'package:base_code/package/config_packages.dart';

class AppPref {
  Future? _isPreferenceInstanceReady;
  late SharedPreferences _preferences;

  static final AppPref _instance = AppPref._internal();

  factory AppPref() => _instance;

  AppPref._internal() {
    _isPreferenceInstanceReady = SharedPreferences.getInstance().then((preferences) => _preferences = preferences);
  }

  Future? get isPreferenceReady => _isPreferenceInstanceReady;

  String get languageCode => _preferences.getString('languageCode') ?? '';
  set languageCode(String value) => _preferences.setString('languageCode', value);

  List<String>? get selectedCarNames => _preferences.getStringList('selectedCarNames');
  set selectedCarNames(List<String>? value) => _preferences.setStringList('selectedCarNames', value ?? []);

  bool? get isDark => _preferences.getBool('isDark');
  set isDark(bool? value) => _preferences.setBool('isDark', value ?? false);

  String? get token => _preferences.getString('token');
  set token(String? value) => _preferences.setString('token', value ?? "");

  bool? get isLogin => _preferences.getBool('isLogin');
  set isLogin(bool? value) => _preferences.setBool('isLogin', value ?? false);

  bool? get didAuthenticate => _preferences.getBool('didAuthenticate')??false;
  set didAuthenticate(bool? value) => _preferences.setBool('didAuthenticate', value ?? false);
  bool? get authenticate => _preferences.getBool('authenticate')??false;
  set authenticate(bool? value) => _preferences.setBool('authenticate', value ?? false);
  bool? get skipAuthenticate => _preferences.getBool('skipAuthenticate')??false;
  set skipAuthenticate(bool? value) => _preferences.setBool('skipAuthenticate', value ?? false);


  bool? get pickCarSkip => _preferences.getBool('pickCarSkip')??false;
  set pickCarSkip(bool? value) => _preferences.setBool('pickCarSkip', value ?? false);

  bool? get pickCar => _preferences.getBool('pickCar')??false;
  set pickCar(bool? value) => _preferences.setBool('pickCar', value ?? false);

  String? get otp => _preferences.getString('otp');
  set otp(String? value) => _preferences.setString('otp', value ?? "");

  void clear() async {
    _preferences.clear();
  }
}

import 'package:base_code/package/screen_packages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter/foundation.dart';


import 'logger/PrettyDioLogger.dart';

late Dio dio;

BaseOptions baseOptions =
    BaseOptions(connectTimeout: const Duration(seconds: 6), receiveTimeout:  const Duration(seconds: 6));

const String baseUrl = kDebugMode
    ? 'https://api.i-donor.com/api/'
    : 'https://api.i-donor.com/api/';

// const String baseUrl = 'https://services.pickedsa.com/api/';

Future<void> dioSetUp({int? language}) async {
  dio = Dio(baseOptions);

  dio.interceptors.add(InterceptorsWrapper(onRequest:
      (RequestOptions option, RequestInterceptorHandler handler) async {
    var customHeaders = {
      'Accept': 'application/json',
      'X-Requested-With': "XMLHttpRequest",
      'Authorization': AppPref().isLogin! ? 'Bearer ${AppPref().token}' : '',
      'language': language ?? (AppPref().languageCode == "en" ? 1 : 2),
    };
    option.headers.addAll(customHeaders);
    handler.next(option);
  }));

  /// PreDioLogger to print api log in DEBUG mode
  if (!Foundation.kReleaseMode) {
    var logger = PrettyDioLogger(
      maxWidth: 232,
      requestHeader: true,
      requestBody: true,
    );
    dio.interceptors.add(logger);
  }
}

import 'package:app_shipper/screens/sign_in/sign_in_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    if (err.response?.statusCode == 403) {
      navigatorKey.currentState!.pushNamedAndRemoveUntil(
          SignInScreen.routeName, (Route<dynamic> route) => false);
    }
    if (err.response?.statusCode == 500) {
      print('Lỗi hệ thống');
    }
    return super.onError(err, handler);
  }
}

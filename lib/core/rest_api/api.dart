import 'package:app_shipper/core/constants/url_constant.dart';
import 'package:app_shipper/core/rest_api/dio_interceptor.dart';
import 'package:app_shipper/services/share_preferences_service.dart';
import 'package:dio/dio.dart';

class Api {
  Api._privateConstructor();

  final String _apiUrl = UrlConstant.API_URL;

  static final Api apiProvider = Api._privateConstructor();
  final _preferences = PreferencesService();

  final dio = Dio(
      BaseOptions(
        baseUrl: UrlConstant.API_URL,
      )
  )
    ..interceptors.add(
      Logging(),
    );

  _getUrlEndpoint(String endPoint) {
    final url = '$_apiUrl/$endPoint';
    return url;
  }

  dynamic get(String url) async {
    var requestHeaders = <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json, ",
      "Authorization": "Bearer ${await _preferences.getToken()}"
    };
    try {
      final response = await dio.get(_getUrlEndpoint(url),
          options: Options(
              headers: requestHeaders));
      return response;
    } on DioError catch (e) {
      print(e.toString() + '----------------');
      throw e.error;
    }
  }

  dynamic post(String url, {var body}) async {
    var requestHeaders = <String, String>{
      "Content-Type": "application/json",
      "Accept": '*/*',
      "Authorization": "Bearer ${await _preferences.getToken()}"
    };
    try {
      final response = await dio.post(_getUrlEndpoint(url),
          data: body,
          options: Options(
              headers: requestHeaders));
      return response;
    } on DioError catch (e) {
      throw e.error;
    }
  }

  dynamic postFormData(String url, {var body}) async {
    var requestHeaders = <String, String>{
      "Accept": '*/*',
      "Authorization": "Bearer ${await _preferences.getToken()}"
    };

    try {
      final response = await dio.post(_getUrlEndpoint(url),
          data: FormData.fromMap(body),
          options: Options(
              headers: requestHeaders));
      return response;
    } on DioError catch (e) {
      throw e.error;
    }
  }
}

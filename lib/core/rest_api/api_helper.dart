import 'package:app_shipper/core/constants/url_constant.dart';
import 'package:app_shipper/services/share_preferences_service.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  ApiHelper._privateConstructor();

   String _apiUrl = UrlConstant.API_URL;

  static final ApiHelper apiProvider = ApiHelper._privateConstructor();
  final _preferences = PreferencesService();

  _getUrlEndpoint(String endPoint) {
    final url = Uri.parse('$_apiUrl/$endPoint');
    return url;
  }

  dynamic get(String url) async {
    String? TOKEN = await _preferences.getToken();
    var requestHeaders = <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json, ",
      "Authorization": "Bearer " + TOKEN!
    };
    try {
      final response = await http.get(_getUrlEndpoint(url), headers: requestHeaders,);
      return response;
    } catch (e) {
      print(e);
    }
  }

  dynamic post(String url, dynamic body) async {
    String? TOKEN = await _preferences.getToken();

    var requestHeaders = <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json, ",
      "Authorization": "Bearer " + TOKEN!
    };
    try {
      final response = await http.post(_getUrlEndpoint(url), headers: requestHeaders, body: body);
      return response;
    } catch (e) {
      print(e);
    }
  }
}

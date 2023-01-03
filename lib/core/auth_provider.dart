import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/url_constant.dart';
import 'package:app_shipper/core/model/login_response.dart';
import 'package:app_shipper/core/rest_api/api.dart';
import 'package:app_shipper/core/rest_api/api_helper.dart';
import 'package:app_shipper/screens/dashboard/dashboard_screen.dart';
import 'package:app_shipper/screens/home/home_screen.dart';
import 'package:app_shipper/services/share_preferences_service.dart';
import 'package:app_shipper/utils/ToastUtils.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AuthProvider extends ChangeNotifier {
  final _preferences = PreferencesService();
  final _api = ApiHelper.apiProvider;
  final _apiDio = Api.apiProvider;
  bool _isLogin = false;
  bool _isConfirm = false;
  bool _isActive = false;
  String _phone = '';

  UserInfo? _userInfo;

  UserInfo? get userInfo => _userInfo;

  bool get isLogin => _isLogin;

  bool get isConfirm => _isConfirm;

  bool get isActive => _isActive;

  get phone => _phone;

  Future<String?> getToken() async {
    return await _preferences.getToken();
  }

  setUserInfo(UserInfo userInfo) {
    _userInfo = userInfo;
    notifyListeners();
  }

  setIsLogin(bool value) => _isLogin = value;

  setIsConfirm(bool value) => _isConfirm = value;

  signIn(String numberPhone, String password, BuildContext context) async {
    _phone = numberPhone;
    login(context, password);
  }

  login(context, String password) async {
    _isLogin = true;
    notifyListeners();
    String url = UrlConstant.API_URL + "/" + UrlConstant.SIGN_IN;
    print('signIn: $url');
    Map<String, dynamic> bodyLogin() => {"userName": _phone, "password": password,
      "tokenFireBase": '${_preferences.getTokenFirebase()}',};
    var data = FormData.fromMap(bodyLogin());
    try {
      final response = await Dio().post(url,
          options: Options(contentType: 'multipart/form-data', headers: {
            "Accept": '*/*',
            "Content-Type": "application/json",
          }),
          data: data);
      _isLogin = false;
      if (response.statusCode == 200) {
        var dataResponse = response.data['data'];
        _userInfo = UserInfo.fromJson(dataResponse['userInfo']);
        print('name: ${_userInfo!.fullName}');
        _isActive = _userInfo!.active;
        print("token: ${dataResponse['tokenInfo']['accessToken']}");
        await _preferences.setToken(dataResponse['tokenInfo']['accessToken'], dataResponse['tokenInfo']['timeExprise']);
        notifyListeners();
        Navigator.pushReplacementNamed(context, DashBoardScreen.routeName);
      } else {
        print(response.statusMessage);
      }
    } on DioError catch (e) {
      _isLogin = false;
      notifyListeners();
      showToastInApp(context, e.response!.data['message'],
          backgroundColor: kWarningColor, textColor: kWhiteColor);
      print(e.response!.data['message']);
    }
  }

  refreshToken(BuildContext context) async {
    try {
      final response = await _apiDio.get(UrlConstant.REFRESH_TOKEN);
      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        _userInfo = UserInfo.fromJson(dataResponse['userInfo']);
        _isActive = _userInfo!.active;
        await _preferences.setToken(dataResponse['tokenInfo']['accessToken'], dataResponse['tokenInfo']['timeExprise']);
        notifyListeners();
        Navigator.pushReplacementNamed(context, DashBoardScreen.routeName);
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  getUserInfo(BuildContext context) async {
    try {
      final response = await _apiDio.get(UrlConstant.GET_USER_INFO);
      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        _userInfo = UserInfo.fromJson(dataResponse);
        _isActive = _userInfo!.active;
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  changeActive(value) {
    _isActive = value;
    return _isActive;
  }

  String numberPhoneHidden() {
    return _phone.replaceRange(_phone.length - 3, _phone.length, "***");
  }
}

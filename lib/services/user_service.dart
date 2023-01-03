import 'dart:math';

import 'package:app_shipper/core/constants/url_constant.dart';
import 'package:app_shipper/core/model/dto/user_dto.dart';
import 'package:app_shipper/core/model/info_done.dart';
import 'package:app_shipper/core/model/login_response.dart';
import 'package:app_shipper/core/rest_api/api.dart';

class UserService {
  final _api = Api.apiProvider;

  get search => null;

  Future<InfoDone?> getInfoDone() async {
    late InfoDone infoDone;
    try {
      final response = await _api.get(UrlConstant.GET_INFO_CHART);

      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        infoDone = InfoDone.fromJson(dataResponse);
        print('infoDone: ' + infoDone.toString());
        return infoDone;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<List<UserDto>?> getAllUserByIsSeller(bool isSeller) async {
    late List<UserDto> users;
    try {
      final response = await _api.get(UrlConstant.GET_ALL_USER_BY_IS_SELLER + '?isSeller=$isSeller');
      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        print('res: ${dataResponse.map((e) => UserDto.fromJson(e)).toList()}');

        users = (dataResponse as List).map((e) => UserDto.fromJson(e)).toList();;
        print('users: ' + users.toString());
        return users;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
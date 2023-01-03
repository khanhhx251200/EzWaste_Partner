import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/constants/url_constant.dart';
import 'package:app_shipper/core/model/leaderboard.dart';
import 'package:app_shipper/core/rest_api/api.dart';
import 'package:dio/dio.dart';

class LeaderBoardService {
  static final Api _api = Api.apiProvider;

  Future<List<Leaderboard>> getListLeaderBoard(type, date) async {
    List<Leaderboard> list = [];
    try {
      final response = await _api.get(UrlConstant.GET_LEADERBOARD + "?type=${type == ORGANIC ? 1 : 2}&date=${date}");
      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        list = (dataResponse as List).map((e) => Leaderboard.fromJson(e)).toList();
        print('list: $list');
        return list;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print("data" + e.response!.data.toString());
      } else {
        print(e.requestOptions);
        print(e.message);
      }
      return list;
    }
    return list;
  }
}
import 'package:app_shipper/core/constants/url_constant.dart';
import 'package:app_shipper/core/rest_api/api.dart';

class OrderService {
  final _api = Api.apiProvider;

  Future<bool> sendConfirmOrganic(String idOrder, double mass) async {
    try {
      final response = await _api.post(UrlConstant.CONFIRM_HOUSEHOLD_GARBASE +
          '?userIdSaller=' +
          idOrder +
          '&mass=' +
          mass.toString());
      print('response' + response.statusCode.toString());

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}

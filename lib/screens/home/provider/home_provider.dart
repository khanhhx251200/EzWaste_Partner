import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/url_constant.dart';
import 'package:app_shipper/core/model/login_response.dart';
import 'package:app_shipper/core/model/my_error.model.dart';
import 'package:app_shipper/core/model/order.dart';
import 'package:app_shipper/core/model/order_model.dart';
import 'package:app_shipper/core/rest_api/api.dart';
import 'package:app_shipper/services/share_preferences_service.dart';
import 'package:app_shipper/utils/ToastUtils.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

class HomeProvider extends ChangeNotifier {
  final _dio = Dio();
  final _preferences = PreferencesService();
  final _api = Api.apiProvider;

  List<OrderModel> _listOrderPlastic = [];
  List<Order> _listOrderOrganic = [];
  List<Order> _listWorking = [];
  List<Order> _listReceive = [];
  List<Order> _listWorked = [];
  List<Order> _listComplete = [];
  bool _isWorking = false;
  DateTime _currentDateSelect = DateTime.now();

  bool get isWorking => _isWorking;

  List<OrderModel> get listOrderPlastic => _listOrderPlastic;

  List<Order> get listOrderOrganic => _listOrderOrganic;

  List<Order> get listWorking => _listWorking;

  List<Order> get listReceive => _listReceive;

  List<Order> get listWorked => _listWorked;

  List<Order> get listComplete => _listComplete;

  DateTime get currentDateSelect => _currentDateSelect;

  setDateSelect(DateTime dateTime) {
    _currentDateSelect = dateTime;
  }

  setIsWorking(bool value) {
    _isWorking = value;
    notifyListeners();
  }

  clearListOrder() {
    _listOrderPlastic.clear();
    _listOrderOrganic.clear();
    _listWorked.clear();
  }

  Future<List<OrderModel>> getListOrderPlastic() async {
    clearListOrder();
    try {
      final response = await _api.get(
          UrlConstant.GET_ALL_LIST_ORDER_BY_DATE_AND_STATUS +
              '?date=${DateFormat('dd-MM-yyyy').format(_currentDateSelect)}' +
              '&status=2');

      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        _listOrderPlastic =
            (dataResponse as List).map((e) => OrderModel.fromJson(e)).toList();
        print('_listOrderPlastic: ' + _listOrderPlastic.toString());
        notifyListeners();
        return _listOrderPlastic;
      }
      return _listOrderPlastic;
    } on Exception catch (_) {
      throw MyError(code: ErrorCode.unknown);
    }
  }

  Future<List<Order>> getListOrderOrganic(int status) async {
    clearListOrder();
    try {
      final response = await _api.get(UrlConstant.GET_ALL_LIST_ORDER_ORGANIC +
          '?date=${DateFormat('dd-MM-yyyy').format(_currentDateSelect)}'+'&status=$status');

      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        _listOrderOrganic =
            (dataResponse as List).map((e) => Order.fromJson(e)).toList();
        print('_listOrderOrganic: ' + _listOrderOrganic.toString());
        notifyListeners();
        return _listOrderOrganic;
      }
      return _listOrderOrganic;
    } on Exception catch (_) {
      throw MyError(code: ErrorCode.unknown);
    }
  }

  Future<void> getListWoking() async {
    try {
      final response = await _api
          .get(UrlConstant.GET_ALL_LIST_ORDER_BY_STATUS + '?status=2');
      print(response);
      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        _listWorking =
            (dataResponse as List).map((e) => Order.fromJson(e)).toList();
        notifyListeners();
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<void> getListReceived() async {
    try {
      final response = await _api
          .get(UrlConstant.GET_ALL_LIST_ORDER_BY_STATUS + '?status=3');
      print(response);
      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        _listReceive =
            (dataResponse as List).map((e) => Order.fromJson(e)).toList();
        notifyListeners();
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<List<Order>> getListWorked() async {
    clearListOrder();
    try {
      final response = await _api
          .get(UrlConstant.GET_ALL_LIST_ORDER_BY_STATUS + '?status=3');
      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        _listWorked =
            (dataResponse as List).map((e) => Order.fromJson(e)).toList();
        print(_listWorked);
        notifyListeners();
        return _listWorked;
      }
    } on DioError catch (e) {
      print(e);
      return [];
    }
    return [];
  }

  Future<List<Order>> getListComplete() async {
    clearListOrder();
    try {
      final response = await _api
          .get(UrlConstant.GET_ALL_LIST_ORDER_BY_STATUS + '?status=4');
      print(response);
      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        _listComplete =
            (dataResponse as List).map((e) => Order.fromJson(e)).toList();
        notifyListeners();
        return _listComplete;
      }
    } on DioError catch (e) {
      print(e);
      return [];
    }
    return [];
  }
}

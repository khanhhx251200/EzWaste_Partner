import 'dart:convert';

import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/url_constant.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/core/model/product.dart';
import 'package:app_shipper/core/rest_api/api.dart';
import 'package:app_shipper/screens/confirm_recycle/components/confirm_success.dart';
import 'package:app_shipper/utils/ToastUtils.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class AddConfirmProvider extends ChangeNotifier {
  final _api = Api.apiProvider;

  List<Product> _listProduct = [];
  List<Product> _listProductSelected = [];

  List<Product> get listProduct => _listProduct;

  List<Product> get listProductSelected => _listProductSelected;

  getListProduct() async {
    _listProduct = [];
    _listProductSelected = [];
    try {
      final response = await _api.get(UrlConstant.GET_ALL_PRODUCT);
      print(response);
      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        _listProduct =
            (dataResponse as List).map((e) => Product.fromJson(e)).toList();
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  resetList() {
    for (Product product in _listProduct) {
      product.mass = 0;
    }
    notifyListeners();
  }

  setListSelected(List<Product> products) {
    _listProductSelected = products;
  }

  addItemToList(Product product) {
    _listProductSelected.add(product);
  }

  setItemToList(Product product) {
    _listProduct.map((e) {
      if (product.id != e.id) {
        e.mass = product.mass;
      }
    });
  }

  confirmPlastic(id, context, {String note = ''}) async {
    if (_listProduct.isNotEmpty) {
      try {
        var json = [];
        for (var item in _listProduct) {
          if (item.mass > 0) {
            json.add(item.toJson());
          }
        }
        Map<String, dynamic> bodyRequest = {
          "idBooking": id,
          "itemsList": json,
        };
        final response = await _api.post(
            UrlConstant.REQUEST_CONFIRM_PLASTIC, body: jsonEncode(bodyRequest));
        if (response.statusCode == 200) {
          print('success');
          showToastInApp(context, 'Đã gửi xác nhận thu gom!',
              backgroundColor: kSuccessColor, textColor: kWhiteColor);
          Navigator.pushReplacementNamed(context, ConfirmSuccess.routeName);
        }
      } on DioError catch (e) {
        print(e);
      }
    } else {
      showToastInApp(context, 'Bạn chưa chọn mặt hàng thu gom!',
          backgroundColor: kWarningColor, textColor: kWhiteColor);
    }
  }

  Future<bool> confirmOrganic(Booking booking, context) async {
    try {
      final response = await _api.post(
          UrlConstant.CONFIRM_ORGANIC, body: jsonEncode(booking.toJson()));
      if (response.statusCode == 200) {
        showToastInApp(
            context, 'Đã thu gom KH ${booking.nameSeller}!', backgroundColor: kSuccessColor,
            textColor: kWhiteColor);
        return true;
      }
      return false;
    } on DioError catch (e) {
      print('confirmOrganic: $e');
      return false;
    }
  }
}

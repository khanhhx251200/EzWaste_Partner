import 'dart:convert';

import 'package:app_shipper/core/constants/url_constant.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/core/model/booking_search.dart';
import 'package:app_shipper/core/model/item.dart';
import 'package:app_shipper/core/rest_api/api.dart';

class BookingService {
  final _api = Api.apiProvider;

  Future<List<Booking>> getBookings(BookingSearch search) async {
    List<Booking> _listBooking = [];
    final bodyJson = jsonEncode(search.toJson());
    print('body: ' + bodyJson);
    try {
      final response = await _api.post(UrlConstant.GET_BOOKINGS
          + "?page=1&size=100", body: bodyJson);

      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        _listBooking =
            (dataResponse['objList'] as List).map((e) => Booking.fromJson(e)).toList();
        return _listBooking;
      }
      return _listBooking;
    } catch (e) {
      return [];
    }
  }

  Future<Booking?> getDetail(int id) async {
    Booking? booking;
    try {
      final response = await _api.get(
          UrlConstant.GET_DETAIL_BOOKING + "?idBooking=${id}");
      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        booking = Booking.fromJson(dataResponse);
      }
      return booking;
    } catch (e) {
      return null;
    }
  }

  Future<Booking?> shipperRegister(int idSeller, dynamic items) async {
    Booking? booking;
    try {
      Map<String, dynamic> bodyRequest = {
        "idSeller": idSeller,
        "typeGarbage": 2,
        "itemsList": items,
      };
      final response = await _api.post(
          UrlConstant.SHIPPER_REGISTER, body: jsonEncode(bodyRequest));
      if (response.statusCode == 200) {
        final dataResponse = response.data['data'];
        booking = Booking.fromJson(dataResponse);
      }
      return booking;
    } catch (e) {
      return null;
    }
  }
}
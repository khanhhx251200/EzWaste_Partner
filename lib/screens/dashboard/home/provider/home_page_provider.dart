import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/core/model/booking_search.dart';
import 'package:app_shipper/screens/dashboard/tracking/components/box_selection.dart';
import 'package:app_shipper/services/booking_service.dart';
import 'package:intl/intl.dart';
import 'package:app_shipper/core/rest_api/api.dart';
import 'package:flutter/material.dart';

class HomePageProvider extends ChangeNotifier {
  final _bookingService = BookingService();

  List<Booking> _listBooking = [];

  List<Booking> get listBooking => _listBooking;

  setListBooking(List<Booking> listNew) {
    _listBooking = listNew;
    notifyListeners();
  }

  clearListBooking() => _listBooking.clear();

  DateTime _dateSelect = DateTime.now();

  DateTime get dateSelect => _dateSelect;

  setDateSelect(DateTime dateTime, {isLoadList = false}) {
    _dateSelect = dateTime;
    print('dateSelected: ' + convertDateToString(_dateSelect));
    if (isLoadList) {
      getBookings();
    }
  }

  Future<List<Booking>> getBookings() async {
    _listBooking.clear();
    return await _bookingService.getBookings(prepareBodySearch());
  }

  BookingSearch prepareBodySearch() {
    final List<BoxSelection> types = [
      BoxSelection(
          title:
              _dateSelect.weekday % 2 == 0 ? kOrganicRecycle : kPlasticRecycle,
          isSelected: true,
          options: dateSelect.weekday % 2 == 0 ? FILTER_ORGANIC : FILTER_PLASTIC)
    ];
    final List<BoxSelection> status = [
      BoxSelection(
          title:
              kStatus,
          isSelected: true,
          options: FILTER_NOT_COLLECT)
    ];
    return BookingSearch(types, status, SORT_BY_NEAR, date: DateFormat('dd-MM-yyyy').format(_dateSelect));
  }
}

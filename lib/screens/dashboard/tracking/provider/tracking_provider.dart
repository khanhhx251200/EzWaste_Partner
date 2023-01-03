import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/core/model/booking_search.dart';
import 'package:app_shipper/screens/dashboard/tracking/components/box_selection.dart';
import 'package:app_shipper/services/booking_service.dart';
import 'package:flutter/material.dart';

class TrackingProvider extends ChangeNotifier {
  final BookingService _bookingService = BookingService();

  List<Booking> _listBooking = [];
  Booking? _bookingDetail;

  final List<BoxSelection> _listType = [
    BoxSelection(
        title: kOrganicRecycle, isSelected: false, options: FILTER_ORGANIC),
    BoxSelection(
        title: kPlasticRecycle, isSelected: false, options: FILTER_PLASTIC),
  ];

  final List<BoxSelection> _listStatus = [
    BoxSelection(
        title: kNotCollect, isSelected: false, options: FILTER_WAIT_CONFIRM),
    BoxSelection(title: kRefuse, isSelected: false, options: FILTER_REFUSE),
    BoxSelection(title: kComplete, isSelected: false, options: FILTER_COMPLETE),
    BoxSelection(
        title: kWaitConfirm, isSelected: false, options: FILTER_WAIT_CONFIRM),
  ];

  final List<BoxSelection> _listSortBy = [
    BoxSelection(
        title: kNearestCollectTime, isSelected: true, options: SORT_BY_NEAR),
    BoxSelection(
        title: kFurthestCollectTime, isSelected: false, options: SORT_BY_FAR),
  ];

  List<BoxSelection> get listStatus => _listStatus;

  List<BoxSelection> get listType => _listType;

  List<BoxSelection> get listSortBy => _listSortBy;

  List<Booking> get listBooking => _listBooking;

  Booking? get bookingDetail => _bookingDetail;

  BoxSelection _sortBy = BoxSelection(
      title: kNearestCollectTime, isSelected: true, options: SORT_BY_NEAR);

  BoxSelection get sortBy => _sortBy;

  setBookingDetail(Booking? booking) => _bookingDetail = booking;

  setSortBy(BoxSelection selection) {
    _sortBy = selection;
    print(_sortBy.title);
  }

  resetTypes() {
    for (BoxSelection item in _listType) {
      item.isSelected = false;
    }
  }

  resetStatus() {
    for (BoxSelection item in _listStatus) {
      item.isSelected = false;
    }
  }

  resetSort() {
    for (BoxSelection item in _listSortBy) {
      item.isSelected = false;
    }
    sortByAll();
  }

  sortByAll() {
    _sortBy = BoxSelection(title: '', isSelected: true, options: '');
  }

  Future<List<Booking>> getBookings() async {
    _listBooking = await _bookingService.getBookings(prepareBodySearch());
    notifyListeners();
    return _listBooking;
  }

  BookingSearch prepareBodySearch() {
    final List<BoxSelection> types =
    _listType.where((element) => element.isSelected).toList();
    final status = _listStatus.where((element) => element.isSelected).toList();
    return BookingSearch(types, status, _sortBy.options);
  }

  getDetail(int id) async {
    _bookingDetail = null;
    _bookingDetail = await _bookingService.getDetail(id);
    notifyListeners();
  }
}


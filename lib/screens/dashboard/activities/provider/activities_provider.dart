import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/core/model/dto/user_dto.dart';
import 'package:app_shipper/services/booking_service.dart';
import 'package:app_shipper/services/user_service.dart';
import 'package:flutter/material.dart';

class ActivitiesProvider extends ChangeNotifier {
  final userService = UserService();
  final _bookingService = BookingService();

  List<UserDto>? _users;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  List<UserDto>? get users => _users;
  DateTime? get rangeStart => _rangeStart;
  DateTime? get rangeEnd => _rangeEnd;

  setRangeStart(DateTime? dateTime) => _rangeStart = dateTime;
  setRangeEnd(DateTime? dateTime) => _rangeEnd = dateTime;

  getUsers() async {
    _users = await userService.getAllUserByIsSeller(true);
    notifyListeners();
  }

  Future<Booking?> shipperRegister(int idSeller, dynamic item) async {
    return await _bookingService.shipperRegister(idSeller, item);
  }
}
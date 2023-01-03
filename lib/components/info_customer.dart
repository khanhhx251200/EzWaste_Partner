import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:flutter/material.dart';

class InfoCustomer extends StatelessWidget {
  const InfoCustomer({
    Key? key,
    required this.booking,
  }) : super(key: key);

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset('assets/images/user_empty.png'),
      title: Text(
        booking.nameSeller!,
        style: const TextStyle(
            fontWeight: FontWeight.w500, color: kBlackColor),
      ),
      subtitle: Text(booking.phoneSeller!),
    );
  }
}

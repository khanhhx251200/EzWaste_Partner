import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/screens/dashboard/tracking/detail_tracking/components/info_user.dart';
import 'package:flutter/material.dart';

import 'info_plastic.dart';
class CollectionTab extends StatelessWidget {
  const CollectionTab({Key? key, required this.booking}) : super(key: key);
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: size24),
      child: Column(
        children: [
          InfoUser(
              fullName: booking.nameSeller!, userName: booking.phoneSeller!),
          const SizedBox(height: size24),
          // Thông tin sau khi đã thu gom (status = 3)
          // InfoOrganic(idOrder: 0, totalMass: 5, status: 3,),
          Expanded(
              child: InfoPlastic(
            booking: booking,
          )),
          const SizedBox(height: size24),
        ],
      ),
    );
  }
}

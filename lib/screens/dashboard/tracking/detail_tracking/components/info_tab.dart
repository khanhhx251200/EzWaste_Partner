import 'package:app_shipper/components/decoration_border_shadow.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:flutter/material.dart';

class InfoBookingTab extends StatelessWidget {
  const InfoBookingTab({Key? key, required this.booking}) : super(key: key);
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [labelTab(), contentTab(context)],
    );
  }

  Container contentTab(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: size24, vertical: size32),
      padding: const EdgeInsets.all(size18),
      decoration: boxDecorationShadow(radius: size20),
      child: Column(
        children: [
          itemBody(
              Icons.date_range, convertTimeStampToString(booking.dateBooking!)),
          itemBody(Icons.location_on, booking.address!),
          itemBody(Icons.delete_outline,
              valueByType(booking.type!, kOrganicRecycle, kPlasticRecycle)),
          booking.status! >= 3 && booking.type == 2
              ? itemBody(const IconData(0xf24e, fontFamily: 'MaterialIcons'),
                  booking.money.toString() + ' VNĐ')
              : const SizedBox(),
          booking.status! >= 3
              ? itemBody(const IconData(0xe235, fontFamily: 'MaterialIcons'),
                  booking.mass!.toStringAsFixed(3) + ' kg')
              : const SizedBox(),
          booking.noteSeller != null && booking.noteSeller != ''
              ? itemBody(Icons.event_note, booking.noteSeller!.trim())
              : const SizedBox(),
          const Divider(),
          itemBody(statusIcon(booking.status!), statusString(booking.status!),
              colorIcon: statusColor(booking.status!)),
        ],
      ),
    );
  }

  Padding itemBody(IconData icon, String data, {colorIcon = kGreenColor}) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(vertical: size8, horizontal: size8 / 2),
      child: Row(
        children: [
          Icon(
            icon,
            color: colorIcon,
            size: size18,
          ),
          const SizedBox(
            width: size12,
          ),
          Expanded(
            child: Text(
              data,
              style: const TextStyle(
                  fontSize: size12,
                  fontWeight: FontWeight.w500,
                  color: kBlackColor),
            ),
          )
        ],
      ),
    );
  }

  Text labelTab() {
    return const Text(
      kInfoBooking,
      style: TextStyle(fontSize: size18, fontWeight: FontWeight.w700),
    );
  }
}

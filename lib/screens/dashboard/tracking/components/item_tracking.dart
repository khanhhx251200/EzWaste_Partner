import 'package:app_shipper/components/decoration_border_shadow.dart';
import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/components/info_customer.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/screens/confirm_recycle/plastic/create_confirm_plastic.dart';
import 'package:app_shipper/screens/dashboard/tracking/detail_tracking/detail_booking_screen.dart';
import 'package:app_shipper/screens/dashboard/tracking/provider/tracking_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ItemTracking extends StatelessWidget {
  const ItemTracking({
    Key? key,
    required this.booking,
  }) : super(key: key);
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Provider.of<TrackingProvider>(context, listen: false)
            .getDetail(booking.id!);
        Navigator.pushNamed(context, DetailBookingScreen.routeName);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: size8, horizontal: size24),
        decoration: boxDecorationShadow(),
        padding: const EdgeInsets.all(size14),
        child: Column(
          children: [
            InfoCustomer(booking: booking),
            const SizedBox(
              height: size8,
            ),
            buildBody(),
            const SizedBox(
              height: size8,
            ),
            buildFooter(context, booking.type!)
          ],
        ),
      ),
    );
  }

  Column buildBody() {
    return Column(
      children: [
        itemBody(
            Icons.date_range, convertTimeStampToString(booking.dateBooking!),
            colorIcon: valueByType(booking.type, kOrganicColor, kPlasticColor)),
        itemBody(Icons.location_on, booking.address!,
            colorIcon: valueByType(booking.type, kOrganicColor, kPlasticColor)),
        itemBody(Icons.delete_outline,
            valueByType(booking.type, kOrganicRecycle, kPlasticRecycle),
            colorIcon: valueByType(booking.type, kOrganicColor, kPlasticColor)),
        booking.status! >= 3
            ? itemBody(const IconData(0xe235, fontFamily: 'MaterialIcons'),
            booking.mass.toString() + ' kg',
            colorIcon:
            valueByType(booking.type, kOrganicColor, kPlasticColor))
            : const SizedBox(),
        booking.noteSeller != null && booking.noteSeller != ''
            ? itemBody(Icons.event_note, booking.noteSeller!.trim(),
            colorIcon:
            valueByType(booking.type, kOrganicColor, kPlasticColor))
            : const SizedBox(),
        const Divider(),
        itemBody(statusIcon(booking.status!), statusString(booking.status!),
            colorIcon: statusColor(booking.status!)),
      ],
    );
  }

  String noteBooking(Booking booking) {
    if (booking.status! == 5) {
      return booking.reason!;
    } else if (booking.status! == 4) {
      return booking.feedback!;
    } else {
      return booking.noteSeller!;
    }
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

  Row buildFooter(BuildContext context, int type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        booking.status == 2 || booking.status == 5
            ? Expanded(
            child: DefaultButton(
              press: () {
                Navigator.pushNamed(context, CreateConfirmPlastic.routeName,
                    arguments: booking);
              },
              color: kGreenColor,
              text: kCollect,
              textSize: size12,
            ))
            : const SizedBox(),
        const SizedBox(
          width: size8 / 2,
        ),
      ],
    );
  }
}

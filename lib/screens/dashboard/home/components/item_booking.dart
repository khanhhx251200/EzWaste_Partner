import 'package:app_shipper/components/decoration_border_shadow.dart';
import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/components/info_customer.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/screens/confirm_recycle/organic/create_confirm_organic.dart';
import 'package:app_shipper/screens/confirm_recycle/plastic/create_confirm_plastic.dart';
import 'package:app_shipper/screens/dashboard/tracking/detail_tracking/detail_booking_screen.dart';
import 'package:app_shipper/screens/dashboard/tracking/provider/tracking_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class ItemBooking extends StatelessWidget {
  const ItemBooking({
    Key? key,
    required this.booking,
  }) : super(key: key);
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => viewDetailBooking(context),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: size20, vertical: size8),
        decoration: boxDecorationShadow(),
        padding: const EdgeInsets.all(size14),
        child: Column(
          children: [
            InfoCustomer(booking: booking),
            Row(
              children: [
                const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.date_range,
                      color: kGreenColor,
                      size: size18,
                    )),
                Expanded(
                  child: Text(
                    convertTimeStampToString(booking.dateBooking!),
                    style: const TextStyle(
                        fontSize: size12,
                        fontWeight: FontWeight.w500,
                        color: kBlackColor),
                  ),
                )
              ],
            ),
            Row(
              children: [
                const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.location_on,
                      color: kGreenColor,
                      size: size18,
                    )),
                Expanded(
                  child: Text(
                    booking.address!,
                    style: const TextStyle(
                        fontSize: size12,
                        fontWeight: FontWeight.w500,
                        color: kBlackColor),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: size8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DefaultButton(
                    press: () {
                      if (booking.type == 2) {
                        Navigator.pushNamed(
                            context, CreateConfirmPlastic.routeName,
                            arguments: booking);
                      } else {
                        Navigator.pushNamed(
                            context, CreateConfirmOrganic.routeName);
                      }
                    },
                    color: kSuccessColor,
                    text: 'Xác nhận thu gom',
                    textSize: size12,
                  ),
                ),
                const SizedBox(width: size8),
                if (booking.type == 2)
                  Expanded(
                    child: DefaultButton(
                      press: () async => viewDetailBooking(context),
                      text: 'Xem chi tiết',
                      textSize: size12,
                      color: kBlueColor,
                    ),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }

  viewDetailBooking(BuildContext context) async {
    if (booking.id != null) {
      Provider.of<TrackingProvider>(context, listen: false)
          .getDetail(booking.id!);
      Navigator.pushNamed(context, DetailBookingScreen.routeName);
    }
  }
}

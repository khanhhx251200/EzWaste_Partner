import 'package:app_shipper/components/decoration_border_shadow.dart';
import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/core/model/item.dart';
import 'package:app_shipper/screens/confirm_recycle/plastic/create_confirm_plastic.dart';
import 'package:flutter/material.dart';

class InfoPlastic extends StatelessWidget {
  const InfoPlastic({
    Key? key,
    required this.booking,
  }) : super(key: key);
  final Booking booking;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: boxDecorationShadow(radius: size20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              infoTotal(),
              booking.status! >= 3 && booking.items != null
                  ? Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: kGreyColor.withOpacity(0.2),
                                    width: 1))),
                        child: ListView.builder(
                          itemCount: booking.items!.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              itemList(booking.items![index]),
                        ),
                      ),
                    )
                  : const SizedBox(),
              btnAction(context)
            ],
          ),
        ),
      ],
    );
  }

  ListTile itemList(Item item) {
    return ListTile(
      dense: true,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 0, horizontal: size16),
      leading: Padding(
        padding: const EdgeInsets.all(size8),
        child: Container(
          height: size8,
          width: size8,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: kGreenColor),
        ),
      ),
      title: Text(
        item.name!,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: size12),
      ),
      trailing: Text(
        '${item.mass}kg',
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: size14),
      ),
    );
  }

  ListTile infoTotal() {
    return ListTile(
      leading: Icon(
        Icons.delete,
        color: booking.type == 1 ? kOrganicColor : kPlasticColor,
      ),
      title:  Text(
        booking.type == 1 ? kOrganicRecycle : kPlasticRecycle,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: size14),
      ),
      trailing: booking.status! >= 3
          ? Text(
              '${booking.mass!.toStringAsFixed(3)}kg',
              style: const TextStyle(
                  fontWeight: FontWeight.w700, fontSize: size16),
            )
          : const SizedBox(),
    );
  }

  Container btnAction(context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: size24, vertical: size14),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DefaultButton(
              color: statusColor(booking.status!),
              text: statusString(booking.status!),
              press: () => booking.status == 2 || booking.status == 5
                  ? Navigator.pushNamed(context, CreateConfirmPlastic.routeName,
                      arguments: booking)
                  : null,
            ),
          ),
        ],
      ),
    );
  }
}

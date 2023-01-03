import 'package:app_shipper/components/decoration_border_shadow.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/model/order.dart';
import 'package:app_shipper/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';

class ItemOrderOrganic extends StatelessWidget {
  const ItemOrderOrganic(
      {Key? key, required this.provider, required this.order})
      : super(key: key);
  final HomeProvider provider;
  final Order order;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      height: _size.width * 0.3,
      width: _size.width * 0.6,
      margin: const EdgeInsets.symmetric(
          horizontal: size8, vertical: size8),
      decoration: boxDecorationShadow(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(top: size8),
                width: 6,
                height: 40,
                decoration: BoxDecoration(
                    color: colorItemDate(provider.currentDateSelect),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    )),
              ),
              Expanded(
                  child: ListTile(
                title: const Padding(
                  padding: EdgeInsets.only(bottom: size8),
                  child: Text('Rác sinh hoạt',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                subtitle: Text('Địa chỉ: ${order.address}',
                    style: const TextStyle(fontSize: size12)),
                trailing: Text(order.userCreateType,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: kOrganicColor)),
              ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: size8),
            child: Divider(
              height: 2,
              color: colorItemDate(provider.currentDateSelect),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: size8, horizontal: size18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.person, color: kGreyColor, size: 20),
                      const SizedBox(width: size8),
                      Expanded(child: Text(order.userCreateFullName)),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.phone, color: kGreyColor, size: 20),
                      const SizedBox(width: size8),
                      Expanded(child: Text(order.userCreate)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  colorItemDate(DateTime element) {
    if (element.weekday == 1 ||
        element.weekday == 3 ||
        element.weekday == 5 ||
        element.weekday == 7) {
      return kPlasticColor;
    } else {
      return kOrganicColor;
    }
  }
}

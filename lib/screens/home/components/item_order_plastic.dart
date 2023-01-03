import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/order.dart';
import 'package:app_shipper/core/model/order_model.dart';
import 'package:app_shipper/screens/add_confirm/add_confirm_screen.dart';
import 'package:app_shipper/screens/add_confirm_household_garbase/add_confirm_household_garbase_screen.dart';
import 'package:app_shipper/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';

class ItemOrderPlastic extends StatelessWidget {
  const ItemOrderPlastic({Key? key, required this.provider, required this.order})
      : super(key: key);
  final HomeProvider provider;
  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Container(
      // height: provider.currentDateSelect == DateTime.now() ? 200 : 120,
      height: 200,
      width: _size.width * 0.6,
      margin: const EdgeInsets.symmetric(
          horizontal: size8, vertical: size8),
      decoration: BoxDecoration(
        color: kWhiteColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(size18),
        boxShadow: const [
          BoxShadow(
            color: kBackgroundColor,
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(4, 8), // Shadow position
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
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
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: size8),
                    child: Text(
                        colorItemDate(provider.currentDateSelect) ==
                                kOrganicColor
                            ? 'Rác sinh hoạt'
                            : 'Rác tái chế',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  subtitle: Text('Địa chỉ: ${order.address}',
                      style: TextStyle(fontSize: size12)),
                ))
              ],
            ),
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
                      const Icon(Icons.date_range, color: kGreyColor, size: 20),
                      const SizedBox(width: size8),
                      Expanded(
                          child: Text(convertTimeStampToString(order.time))),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.phone, color: kGreyColor, size: 20),
                      const SizedBox(width: size8),
                      Expanded(child: Text(order.userCreateBy)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Visibility(
            // visible: provider.currentDateSelect == DateTime.now(),
            visible: true,
            child: TextButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.all(0))),
                onPressed: () {
                  Navigator.pushNamed(context, AddConfirm.routeName,
                      arguments: order.id);
                },
                child: const Text('Thu gom')),
          )
        ],
      ),
    );
  }

  colorItemDate(DateTime element) {
    if (element.weekday == 1 || element.weekday == 3 || element.weekday == 5 || element.weekday == 7) {
      return kPlasticColor;
    }else {
      return kOrganicColor;
    }
  }
}

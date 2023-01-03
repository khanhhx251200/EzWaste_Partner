import 'package:app_shipper/components/loading_widget.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/my_error.model.dart';
import 'package:app_shipper/core/model/order.dart';
import 'package:app_shipper/screens/add_confirm_household_garbase/add_confirm_household_garbase_screen.dart';
import 'package:app_shipper/screens/add_confirm_household_garbase/provider/card_organic_provider.dart';
import 'package:app_shipper/screens/home/provider/home_provider.dart';
import 'package:app_shipper/utils/ToastUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'item_order_organic.dart';

class ListOrderOrganic extends StatefulWidget {
  const ListOrderOrganic({Key? key}) : super(key: key);

  @override
  State<ListOrderOrganic> createState() => _ListOrderOrganicState();
}

class _ListOrderOrganicState extends State<ListOrderOrganic> {
  late Future<List<Order>> getListOrder;

  @override
  void initState() {
    getListOrder = context.read<HomeProvider>().getListOrderOrganic(1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<List<Order>>(
          future: getListOrder,
          builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoadingWidget(color: kOrganicColor),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text((snapshot.error as MyError).errorMessage),
              );
            }
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final listOrders = provider.listOrderOrganic;
              return Column(
                children: [
                  if (listOrders.isNotEmpty) TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.all(0))),
                      onPressed: () {
                        // provider.getListOrderOrganic();
                        if (provider.currentDateSelect == DateTime.now()) {
                          Provider.of<CardOrganicProvider>(context,
                                  listen: false)
                              .setListUserOrder(provider.listOrderOrganic);
                          Navigator.pushNamed(
                              context, AddConfirmHousehold.routeName);
                        } else {
                          showToastInApp(context, 'Chưa đến thời gian thu gom', backgroundColor: kErrorColor, textColor: kWhiteColor);
                        }
                      },
                      child: const Text(
                        'Thu gom',
                        style: TextStyle(color: kOrganicColor),
                      )),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      color: kWhiteColor,
                      child: context
                              .read<HomeProvider>()
                              .listOrderOrganic
                              .isEmpty
                          ? const Center(child: Text('Không có lịch thu gom'))
                          : ListView.builder(
                              shrinkWrap: true,
                              itemCount: listOrders.length,
                              itemBuilder: (context, index) {
                                final user = listOrders[index];
                                return ItemOrderOrganic(
                                    provider: provider, order: user);
                              },
                            ),
                    ),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }

  colorItemDate(DateTime element) {
    if (element.weekday == 1 || element.weekday == 3 || element.weekday == 5) {
      return kPlasticColor;
    } else if (element.weekday == 2 ||
        element.weekday == 4 ||
        element.weekday == 6) {
      return kOrganicColor;
    } else {
      return kWarningColor;
    }
  }

  Card buildItemOrder(Order item, BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildHeader(item, context),
          const Divider(color: kGreyColor),
          buildContent(item),
        ],
      ),
    );
  }

  ListTile buildContent(Order item) {
    return ListTile(
      dense: true,
      leading: Image.asset('assets/images/user_empty.png'),
      title: buildTimeOrder(item),
      subtitle: buildAddressOrder(item),
    );
  }

  Row buildAddressOrder(Order item) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          kAddress + ": ",
          style: TextStyle(
              fontSize: size14,
              fontWeight: FontWeight.bold,
              color: kBlackColor),
        ),
        Expanded(
            child: Text(
          item.address,
          style: const TextStyle(
            fontSize: size14,
            height: 1.3,
          ),
        )),
      ],
    );
  }

  Padding buildTimeOrder(Order item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Text(
            'Thời gian: ',
            style: TextStyle(
                fontSize: size14,
                fontWeight: FontWeight.bold,
                color: kBlackColor),
          ),
          Expanded(
              child: Text(convertDateDetail(item.time),
                  style: const TextStyle(
                      fontSize: size14, fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  Padding buildHeader(Order item, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: size8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Đơn hàng mới',
              style: TextStyle(
                  fontSize: size14,
                  fontWeight: FontWeight.bold,
                  color: kThirdColor)),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(kPrimaryColor)),
              onPressed: () => null,
              child: const Text('Nhận đơn')),
        ],
      ),
    );
  }
}

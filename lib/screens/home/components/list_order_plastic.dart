import 'package:app_shipper/components/loading_widget.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/my_error.model.dart';
import 'package:app_shipper/core/model/order.dart';
import 'package:app_shipper/core/model/order_model.dart';
import 'package:app_shipper/screens/home/components/item_order_plastic.dart';
import 'package:app_shipper/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListOrderPlastic extends StatefulWidget {
  const ListOrderPlastic({Key? key}) : super(key: key);

  @override
  State<ListOrderPlastic> createState() => _ListOrderPlasticState();
}

class _ListOrderPlasticState extends State<ListOrderPlastic> {
  late Future<List<OrderModel>> getListOrder;

  @override
  void initState() {
    getListOrder = context.read<HomeProvider>().getListOrderPlastic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<List<OrderModel>>(
          future: getListOrder,
          builder:
              (BuildContext context, AsyncSnapshot<List<OrderModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: LoadingWidget(color: kPlasticColor),
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
              final listOrders = context.read<HomeProvider>().listOrderPlastic;
              return Container(
                height: 120,
                width: double.infinity,
                color: kWhiteColor,
                child: listOrders.isEmpty
                    ? const Center(child: Text('Không có lịch thu gom'))
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: listOrders.length,
                        itemBuilder: (context, index) {
                          final order = listOrders[index];
                          return ItemOrderPlastic(
                              provider: provider, order: order);
                        },
                      ),
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

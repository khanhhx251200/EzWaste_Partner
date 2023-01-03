import 'package:app_shipper/core/model/order.dart';
import 'package:app_shipper/screens/home/components/item_complete.dart';
import 'package:app_shipper/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
class ListWorked extends StatefulWidget {
  const ListWorked({Key? key, required this.provider}) : super(key: key);
  final HomeProvider provider;

  @override
  State<ListWorked> createState() => _ListWorkedState();
}

class _ListWorkedState extends State<ListWorked> {
  late Future<List<Order>> getListOrder;

  @override
  void initState() {
    getListOrder = widget.provider.getListWorked();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => widget.provider.getListWorked(),
      child: FutureBuilder<List<Order>>(
        future: getListOrder,
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return const Center(
              child: Text('Đã có lỗi xảy ra'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if ( snapshot.connectionState == ConnectionState.done) {
            final listOrders = widget.provider.listWorked;
            return listOrders.isEmpty ? const Center(child: Text('Không có lịch thu gom')) : ListView.builder(
              shrinkWrap: true,
              itemCount: widget.provider.listWorked.length,
              itemBuilder: (context, index) {
                final element = widget.provider.listWorked[index];
                return ItemComplete(item: element);
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}

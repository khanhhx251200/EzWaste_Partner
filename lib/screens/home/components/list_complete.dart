import 'package:app_shipper/core/model/order.dart';
import 'package:app_shipper/screens/home/components/item_complete.dart';
import 'package:app_shipper/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ListComplete extends StatefulWidget {
  const ListComplete({Key? key, required this.provider}) : super(key: key);
  final HomeProvider provider;

  @override
  State<ListComplete> createState() => _ListCompleteState();
}

class _ListCompleteState extends State<ListComplete> {
  late Future<List<Order>> getListOrder;

  @override
  void initState() {
    super.initState();
    getListOrder = widget.provider.getListComplete();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => widget.provider.getListComplete(),
      child: listComplete(),
    );
  }

  FutureBuilder listComplete () => FutureBuilder<List<Order>>(
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
        final listOrders = widget.provider.listComplete;
        return listOrders.isEmpty ? const Center(child: Text('Không có lịch thu gom')) : ListView.builder(
          shrinkWrap: true,
          itemCount: widget.provider.listComplete.length,
          itemBuilder: (context, index) {
            final element = widget.provider.listComplete[index];
            return ItemComplete(item: element);
          },
        );
      } else {
        return const SizedBox();
      }
    },
  );
}

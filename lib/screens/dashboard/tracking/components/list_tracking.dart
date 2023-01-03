import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/screens/dashboard/tracking/provider/tracking_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'item_tracking.dart';

class ListTracking extends StatefulWidget {
  const ListTracking({Key? key}) : super(key: key);

  @override
  State<ListTracking> createState() => _ListTrackingState();
}

class _ListTrackingState extends State<ListTracking> {
  @override
  void initState() {
    super.initState();

    Provider.of<TrackingProvider>(context, listen: false).getBookings();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Consumer<TrackingProvider>(
      builder: (context, provider, child) => SizedBox(
        width: _size.width,
        child: provider.listBooking.isNotEmpty
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: provider.listBooking.length,
                itemBuilder: (context, index) {
                  final Booking order = provider.listBooking[index];
                  return ItemTracking(booking: order);
                },
              )
            : const Center(
                child: Text('Không có lịch thu gom'),
              ),
      ),
    );
  }
}

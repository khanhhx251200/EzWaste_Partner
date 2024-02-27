import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/core/model/my_error.model.dart';
import 'package:app_shipper/screens/dashboard/home/provider/home_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'item_booking.dart';

class ListBooking extends StatefulWidget {
  const ListBooking({Key? key}) : super(key: key);

  @override
  State<ListBooking> createState() => _ListBookingState();
}

class _ListBookingState extends State<ListBooking> {
  late Future<List<Booking>> getListBooking;

  @override
  void initState() {
    super.initState();

    final HomePageProvider provider =
        Provider.of<HomePageProvider>(context, listen: false);
    getListBooking = provider.getBookings();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<HomePageProvider>(
      builder: (context, provider, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: size20, vertical: size8),
            child: Text(
              kInfoBooking,
              style: TextStyle(
                  fontSize: size20,
                  fontWeight: FontWeight.w500,
                  color: kBlackColor),
            ),
          ),
          Expanded(
            child: listBooking(context, provider),
          )
        ],
      ),
    );
  }

  Widget listBooking(BuildContext context, HomePageProvider provider) {
    final List<Booking> listBooking =
        Provider.of<HomePageProvider>(context).listBooking;
    return listBooking.isNotEmpty
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: listBooking.length,
            itemBuilder: (context, index) {
              final Booking booking = listBooking[index];
              return ItemBooking(booking: booking);
            },
          )
        : const Center(
            child: Text('Không có lịch thu gom'),
          );
  }
}

import 'package:app_shipper/components/app_bar.dart';
import 'package:app_shipper/components/loading_widget.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/screens/dashboard/tracking/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/collection_tab.dart';
import 'components/info_tab.dart';

class DetailBookingScreen extends StatefulWidget {
  static const String routeName = '/detail-booking';

  const DetailBookingScreen({Key? key}) : super(key: key);

  @override
  State<DetailBookingScreen> createState() => _DetailBookingScreenState();
}

class _DetailBookingScreenState extends State<DetailBookingScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int indexTabParent = 0;
  late int idBooking;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrackingProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: appBar(kInfoBooking),
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(color: kWhiteColor),
            child: Column(
              children: [
                buildTabBar(),
                provider.bookingDetail != null
                    ? Expanded(
                        child: TabBarView(
                        controller: _tabController,
                        children: [
                          InfoBookingTab(
                            booking: provider.bookingDetail!,
                          ),
                          CollectionTab(
                            booking: provider.bookingDetail!,
                          )
                        ],
                      ))
                    : const LoadingWidget(color: kPrimaryColor)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildTabBar() {
    return Container(
      margin: const EdgeInsets.all(size24),
      decoration: BoxDecoration(
        color: kGreenColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(size20),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(size20), color: kGreenColor),
        labelColor: kWhiteColor,
        unselectedLabelColor: kWhiteColor,
        onTap: (value) {
          setState(() {
            indexTabParent = value;
          });
        },
        tabs: const [
          Tab(
            text: kBooking,
          ),
          Tab(
            text: kCollect,
          ),
        ],
      ),
    );
  }
}

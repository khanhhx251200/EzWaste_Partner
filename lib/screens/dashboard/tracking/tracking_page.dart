import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/dashboard/components/title_page.dart';
import 'package:app_shipper/screens/dashboard/tracking/components/body.dart';
import 'package:app_shipper/screens/dashboard/tracking/provider/tracking_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({Key? key}) : super(key: key);

  @override
  _TrackingPageState createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TrackingProvider>(
      builder: (context, value, child) {
        return Container(
          color: kWhiteColor,
          child: Column(
            children: const [
              TitlePage(title: kFollowTracking),
              Expanded(
                child: Body(),
              )
            ],
          ),
        );
      },
    );
  }
}



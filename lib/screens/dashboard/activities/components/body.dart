import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/screens/dashboard/activities/components/detail_activities.dart';
import 'package:app_shipper/screens/dashboard/activities/components/filter_activities.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(size32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  const [
          FilterActivities(),
          SizedBox(height: size36),
          DetailActitivities()
        ],
      ),
    );
  }
}


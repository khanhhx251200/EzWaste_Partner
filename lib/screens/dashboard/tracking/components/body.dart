import 'package:app_shipper/screens/dashboard/tracking/components/filter_tracking.dart';
import 'package:app_shipper/screens/dashboard/tracking/components/list_tracking.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        FilterTracking(),
        Flexible(child: ListTracking())
      ],
    );
  }
}

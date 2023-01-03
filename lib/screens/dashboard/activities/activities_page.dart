import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/dashboard/activities/components/body.dart';
import 'package:app_shipper/screens/dashboard/activities/provider/activities_provider.dart';
import 'package:app_shipper/screens/dashboard/components/title_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivitiesProvider>(
      builder: (context, value, child) {
        return Container(
          color: kWhiteColor,
          child: Column(
            children: const [
              TitlePage(title: kMyChart),
              Body()
            ],
          ),
        );
      },
    );
  }
}

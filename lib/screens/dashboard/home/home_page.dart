import 'package:app_shipper/core/auth_provider.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/dashboard/home/components/list_booking.dart';
import 'package:app_shipper/screens/dashboard/components/title_page.dart';
import 'package:app_shipper/screens/dashboard/home/provider/home_page_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'components/filter_booking.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitlePage(title: kCalendarBooking),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: size20, vertical: size8),
              child: Text.rich(TextSpan(text: 'Khu vực thu gom: ', children: [
                TextSpan(
                    text: context.read<AuthProvider>().userInfo!.tenKhuVuc,
                    style: const TextStyle(
                        fontSize: size20,
                        fontWeight: FontWeight.bold,
                        color: kSuccessColor))
              ])),
            ),
            const FilterBooking(),
            const Expanded(child: ListBooking())
          ],
        );
      },
    );
  }
}

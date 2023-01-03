import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/screens/home/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'item_date.dart';

class ListNextDates extends StatefulWidget {
  const ListNextDates({Key? key, required this.provider}) : super(key: key);
  final HomeProvider provider;

  @override
  State<ListNextDates> createState() => _ListNextDatesState();
}

class _ListNextDatesState extends State<ListNextDates> {
  final _currentDate = DateTime.now();
  final dates = <DateTime>[];
  DateTime currentDateTime = DateTime.now();
  dynamic color;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    currentDateTime = _currentDate.add(const Duration(days: 0));
    widget.provider.setDateSelect(currentDateTime);
    for (int i = 0; i < 30; i++) {
      final DateTime date = _currentDate.add(Duration(days: i));
      if (i == 0) {
        color = date.weekday % 2 == 0 ? kOrganicColor : kPlasticColor;
      }
      dates.add(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: dates.length,
        itemBuilder: (BuildContext context, int index) {
          final element = dates[index];
          final _dayFormatter = DateFormat.d('vi');
          final _monthFormatter = DateFormat.E('vi');
          final colors;
          if (element.weekday == 1 || element.weekday == 3 || element.weekday == 5 || element.weekday == 7) {
            colors = kPlasticColor;
          }else {
            colors = kOrganicColor;
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                currentDateTime = element;
                widget.provider.setDateSelect(currentDateTime);
                if (element.weekday == 1 || element.weekday == 3 || element.weekday == 5 || element.weekday == 7) {
                  widget.provider.getListOrderPlastic();
                  color = kPlasticColor;
                } else {
                  widget.provider.getListOrderOrganic(1);
                  color = kOrganicColor;
                }
              });
            },
            child: ItemDate(currentDateTime: currentDateTime, element: element, colors: colors, monthFormatter: _monthFormatter, dayFormatter: _dayFormatter),
          );
        },
      ),
    );
  }
}


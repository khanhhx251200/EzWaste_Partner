import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/dashboard/activities/components/filter_calendar.dart';
import 'package:app_shipper/screens/dashboard/activities/provider/activities_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterActivities extends StatefulWidget {
  const FilterActivities({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterActivities> createState() => _FilterActivitiesState();
}

class _FilterActivitiesState extends State<FilterActivities> {
  final dateSearchController =
      TextEditingController(text: '22/10/2022 - 22/12/2022');

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: inputDateSearch()),
        const SizedBox(width: size8),
        DefaultButton(
          text: kFilter,
          color: kGreenColor,
          press: () async {
            final result = await Navigator.pushNamed(context, FilterCalendar.routeName);
            if (result != null) {
              showResultDateSelected(context);
            }
          },
        )
      ],
    );
  }

  void showResultDateSelected(BuildContext context) {
    final provider = Provider.of<ActivitiesProvider>(context, listen: false);
    if (provider.rangeStart != null && provider.rangeEnd == null) {
      dateSearchController.text = convertDateToString(provider.rangeStart!);
    } else if(provider.rangeStart != null && provider.rangeEnd != null) {
      dateSearchController.text = convertDateToString(provider.rangeStart!) + ' - ' + convertDateToString(provider.rangeEnd!);
    } else {
      dateSearchController.text = '';
    }
  }

  TextField inputDateSearch() {
    return TextField(
        enabled: false,
        controller: dateSearchController,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w600),
        decoration: decorationInputDate(),
      );
  }

  InputDecoration decorationInputDate() {
    return const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(size10)),
          borderSide: BorderSide(color: kGreenColor, width: 1.0),
        ),
        contentPadding:
            EdgeInsets.symmetric(horizontal: size14, vertical: size12));
  }
}

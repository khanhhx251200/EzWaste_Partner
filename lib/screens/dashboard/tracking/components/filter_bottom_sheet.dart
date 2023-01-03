import 'package:app_shipper/components/top_bottom_sheet.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/dashboard/tracking/components/box_selection.dart';
import 'package:app_shipper/screens/dashboard/tracking/components/filter_button.dart';
import 'package:flutter/material.dart';

class FilterBottom extends StatefulWidget {
  const FilterBottom({Key? key}) : super(key: key);

  @override
  State<FilterBottom> createState() => _FilterBottomState();
}

class _FilterBottomState extends State<FilterBottom> {
  List<BoxSelection> listType = [];
  List<BoxSelection> listStatus = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addTypes();
    addStatus();
  }

  void addTypes() {
    listType.add(BoxSelection(
        title: kOrganicRecycle, isSelected: false, options: ORGANIC));
    listType.add(BoxSelection(
        title: kPlasticRecycle, isSelected: false, options: PLASTIC));
  }

  void addStatus() {
    listStatus.add(
        BoxSelection(title: kNotDoing, isSelected: false, options: ORGANIC));
    listStatus
        .add(BoxSelection(title: kRefuse, isSelected: false, options: PLASTIC));
    listStatus
        .add(BoxSelection(title: kRefuse, isSelected: false, options: PLASTIC));
    listStatus.add(BoxSelection(
        title: kWaitConfirm, isSelected: false, options: kCompleted));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding:
          const EdgeInsets.symmetric(vertical: size14, horizontal: size36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopBottomSheet(),
          const SizedBox(
            height: size20,
          ),
          filterByTypeRecycle(),
          const SizedBox(
            height: size20,
          ),
          filterByStatusRecycle(),
        ],
      ),
    );
  }

  Column filterByTypeRecycle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          kClassifyRecycle,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: size18),
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: listType.map((type) => FilterButton(selection: type)).toList(),
        ),
      ],
    );
  }

  Column filterByStatusRecycle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          kStatus,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: size18),
        ),
        Wrap(
          alignment: WrapAlignment.spaceBetween,
          children: listStatus.map((type) => FilterButton(selection: type)).toList(),
        ),
      ],
    );
  }
}

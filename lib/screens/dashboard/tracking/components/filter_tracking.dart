import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/dashboard/tracking/components/filter_bottom_sheet.dart';
import 'package:app_shipper/screens/dashboard/tracking/components/sort_bottom_sheet.dart';
import 'package:app_shipper/screens/dashboard/tracking/provider/tracking_provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterTracking extends StatefulWidget {
  const FilterTracking({
    Key? key,
  }) : super(key: key);

  @override
  State<FilterTracking> createState() => _FilterTrackingState();
}

class _FilterTrackingState extends State<FilterTracking> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: size24, vertical: size8),
      child: Row(
        children: [
          buttonAction(
              kFilter, Icons.filter_alt_outlined, () => filter(context)),
          const SizedBox(width: size8),
          buttonAction(kSortBy, Icons.sort, () => sortBy(context)),
        ],
      ),
    );
  }

  OutlinedButton buttonAction(String label, IconData icon, Function? press) {
    return OutlinedButton.icon(
      label: Text(
        label,
        style: TextStyle(color: kTextColor, fontWeight: FontWeight.w500),
      ),
      onPressed: press != null ? press as Function()? : null,
      icon: Icon(icon, color: kGrey75Color),
      style: styleButtonAction(),
    );
  }

  ButtonStyle styleButtonAction() {
    return ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(size20),
            )));
  }

  filter(BuildContext context) async {
    await showMaterialModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.0), topLeft: Radius.circular(50.0)),
      ),
      builder: (context) => const FilterBottom(),
    );
    searchAfterFilter(context);
  }

  sortBy(BuildContext context) async {
    await showMaterialModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(50.0), topLeft: Radius.circular(50.0)),
      ),
      builder: (context) => const SortBottom(),
    );
    searchAfterFilter(context);
  }

  searchAfterFilter(BuildContext context) {
    final provider = Provider.of<TrackingProvider>(context, listen: false);
    setState(() {
      provider.getBookings();
    });
  }
}


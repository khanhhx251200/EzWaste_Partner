import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/screens/dashboard/tracking/components/box_selection.dart';
import 'package:app_shipper/screens/dashboard/tracking/provider/tracking_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  const FilterButton({Key? key, required this.selection}) : super(key: key);
  final BoxSelection selection;

  // final ValueChanged<bool> onSelected;

  @override
  State<FilterButton> createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  // _updateStatus(bool value) {
  //   widget.onSelected(value);
  //   setState(() {
  //     widget.selection.isSelected = value;
  //   });
  // }

  clickButton() {
    setState(() {
      widget.selection.isSelected = !widget.selection.isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: size8),
      child: OutlinedButton(
        onPressed: () {
          clickButton();
        },
        child: Text(
          widget.selection.title,
          style: TextStyle(
              color: widget.selection.isSelected ? kWhiteColor : kGreyColor,
              fontSize: size12),
        ),
        style: styleButtonAction(isSelect: widget.selection.isSelected),
      ),
    );
  }

  ButtonStyle styleButtonAction({bool isSelect = false}) {
    return ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            isSelect ? kGreenColor : kWhiteColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          side: BorderSide(color: isSelect ? kGreenColor : kGrey75Color),
          borderRadius: BorderRadius.circular(size20),
        )));
  }
}

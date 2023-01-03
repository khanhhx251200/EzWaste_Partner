import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:flutter/material.dart';

class TopBottomSheet extends StatelessWidget {
  const TopBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size8 / 2,
        width: 56,
        decoration: BoxDecoration(
            color: kGrey75Color,
            borderRadius: const BorderRadius.all(Radius.circular(size20))),
      ),
    );
  }
}

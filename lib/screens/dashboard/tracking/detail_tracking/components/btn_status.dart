import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:flutter/material.dart';
class ButtonStatus extends StatelessWidget {
  const ButtonStatus({Key? key, required this.status}) : super(key: key);
  final int status;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DefaultButton(
        text: statusString(status),
        color: statusColor(FILTER_PLASTIC),
        press: null,
      ),
    );
  }
}

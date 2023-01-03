import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:flutter/material.dart';
class BtnActionConfirm extends StatelessWidget {
  const BtnActionConfirm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: DefaultButton(
            text: kAgree,
            press: () => print('Đồng ý'),
          ),
        ),
        const SizedBox(
          width: size16,
        ),
        Expanded(
          child: DefaultButton(
            text: kRefuse,
            color: kErrorColor,
            press: () => print('Từ chối'),
          ),
        ),
      ],
    );
  }
}

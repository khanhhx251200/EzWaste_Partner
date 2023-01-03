import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:flutter/material.dart';
import '../size_config.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
    this.color,
    this.textSize,
    this.borderRadius,
  }) : super(key: key);
  final String? text;
  final Function? press;
  final Color? color;
  final double? textSize;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(36),
      child: ElevatedButton(
        style: TextButton.styleFrom(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? size24)),
            primary: kWhiteColor,
            backgroundColor: color ?? kPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 24)
        ),
        onPressed: press != null ? press as Function()? : null,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(textSize ?? size14),
            color: kWhiteColor,
          ),
        ),
      ),
    );
  }
}

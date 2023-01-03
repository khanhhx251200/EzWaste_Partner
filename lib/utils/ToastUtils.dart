import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void showToastInApp(BuildContext context, String content,
    {Color? backgroundColor, Color? textColor, String? align}) {
  StyledToastPosition? position;

  if (align == kTOP) {
    position = StyledToastPosition.top;
  } else if (align == kBOTTOM) {
    position = StyledToastPosition.bottom;
  } else {
    position = StyledToastPosition.center;
  }
  showToast(content,
      context: context,
      backgroundColor: backgroundColor,
      textStyle: TextStyle(color: textColor),
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.slideFromTop,
      startOffset: Offset(0.0, 3.0),
      reverseEndOffset: Offset(0.0, 3.0),
      position: position,
      duration: Duration(seconds: 4),
      animDuration: Duration(seconds: 1),
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn);
}

import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    fontFamily: "NotoSans",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    primaryColor: kGreenColor,
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(size8),
    borderSide:const BorderSide(color: kTextColor),
    gapPadding: size8,
  );
  OutlineInputBorder focusOutlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(size8),
    borderSide:const BorderSide(color: kGreenColor),
    gapPadding: size8,
  );
  return InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: size8, vertical: size12),
      enabledBorder: outlineInputBorder,
      focusedBorder: focusOutlineInputBorder,
      border: outlineInputBorder,
      floatingLabelStyle:const TextStyle(color: kPrimaryColor));
}

TextTheme textTheme() {
  return const TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return  AppBarTheme(
    color: kWhiteColor,
    elevation: 0,
    brightness: Brightness.light,
    centerTitle: true,
    iconTheme: IconThemeData(color: kGreyColor.withOpacity(0.7)),
    titleTextStyle: TextStyle(color: kGreyColor.withOpacity(0.7), fontSize: size16),
  );
}

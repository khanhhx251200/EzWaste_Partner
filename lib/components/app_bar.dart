import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

AppBar appBar(String text) {
  return AppBar(
    title: Text(
      text,
      style: const TextStyle(color: kBlackColor, fontWeight: FontWeight.bold),
    ),
    elevation: 4,
  );
}
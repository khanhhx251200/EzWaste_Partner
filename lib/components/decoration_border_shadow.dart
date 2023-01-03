import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:flutter/material.dart';

BoxDecoration boxDecorationShadow({radius = size8}) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(size20),
        topRight: Radius.circular(size20),
        bottomLeft: Radius.circular(size20),
        bottomRight: Radius.circular(size20)),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: size10 / 2,
        blurRadius: 7,
        offset: const Offset(0, 3), // changes position of shadow
      ),
    ],
  );
}
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:flutter/material.dart';

appBarConfirm() => AppBar(
      elevation: 1,
      title: const Text(
        kConfirmRecycle,
        style: TextStyle(fontWeight: FontWeight.w700, color: kBlackColor),
      ),
    );

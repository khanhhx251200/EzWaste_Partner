import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;

  const LoadingWidget({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isAndroid
          ?  CircularProgressIndicator(
        valueColor:  AlwaysStoppedAnimation<Color>(color),
      )
          : const CupertinoActivityIndicator(),
    );
  }
}

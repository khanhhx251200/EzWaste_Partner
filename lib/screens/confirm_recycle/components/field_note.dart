import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:flutter/material.dart';

class FieldNote extends StatelessWidget {
  const FieldNote({
    Key? key, required this.textEditingController,
  }) : super(key: key);
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      maxLines: 3,
      style: const TextStyle(
          fontWeight: FontWeight.w500, color: kBlackColor),
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20.0, top: size14),
          labelText: 'Ghi chú (nếu có)',
          floatingLabelStyle: const TextStyle(fontWeight: FontWeight.w600, color: kBlackColor),
          suffixIcon: const Icon(
            Icons.edit_outlined,
          )),
    );
  }
}

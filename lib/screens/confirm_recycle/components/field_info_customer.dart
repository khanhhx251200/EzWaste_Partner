import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:flutter/material.dart';

class FieldInfoCustomer extends StatelessWidget {
  const FieldInfoCustomer({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: size14),
          child: TextField(
            enabled: false,
            controller: TextEditingController(text: value),
            style: const TextStyle(
                fontWeight: FontWeight.w700, color: kBlackColor),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 20.0),
                labelText: label,
                floatingLabelStyle: const TextStyle(fontWeight: FontWeight.w600, color: kBlackColor),
                suffixIcon: const Icon(
                  Icons.check_circle,
                  color: kGreenColor,
                )),
          ),
        ),
      ],
    );
  }
}

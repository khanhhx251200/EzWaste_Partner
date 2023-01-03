import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:flutter/material.dart';
class InfoUser extends StatelessWidget {
  const InfoUser({Key? key, required this.fullName, required this.userName})
      : super(key: key);
  final String fullName;
  final String userName;

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;

    return Column(
      children: [
        const Text(
          kInfoCustomer,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: size18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: size36,
        ),
        CircleAvatar(
          radius: _size.height * 0.05,
          child: Image.asset(
            'assets/images/user_empty.png',
            height: _size.height * 0.3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            fullName,
            style: const TextStyle(
                color: kGreyColor,
                fontSize: size20,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          userName,
          style: const TextStyle(color: kSecondaryTextColor),
        ),
      ],
    );
  }
}

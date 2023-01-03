import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/confirm_recycle/components/field_info_customer.dart';
import 'package:flutter/material.dart';

class InfoCustomerConfirm extends StatelessWidget {
  const InfoCustomerConfirm(
      {Key? key,
      required this.address,
      required this.userName,
      required this.fullName})
      : super(key: key);
  final String address;
  final String userName;
  final String fullName;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kGreenColor,
      padding: const EdgeInsets.symmetric(horizontal: size32, vertical: size24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: size32,
            backgroundImage: AssetImage("assets/images/user_empty.png"),
          ),
          const SizedBox(
            width: size24,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fullName,
                  style: const TextStyle(
                      color: kWhiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: size20),
                ),
                const SizedBox(
                  height: size8,
                ),
                Text(
                  userName,
                  style: const TextStyle(color: kWhiteColor, fontSize: size12),
                ),
                const SizedBox(
                  height: size8,
                ),
                Text(
                  address,
                  style: const TextStyle(color: kWhiteColor, fontSize: size12),
                ),
              ],
            ),
          )
          // const SizedBox(
          //   height: size8,
          // ),
          // FieldInfoCustomer(
          //   label: 'Số điện thoại khách hàng',
          //   value: userName,
          // ),
          // FieldInfoCustomer(
          //   label: 'Họ tên khách hàng',
          //   value: fullName,
          // ),
        ],
      ),
    );
  }
}

import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'sign_in_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
          maxWidth: MediaQuery.of(context).size.width,
        ),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [kPrimaryColor, kPrimaryLightColor],
                begin: Alignment.topLeft,
                end: Alignment.centerRight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: size14, horizontal: size18),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Đăng nhập",
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: getProportionateScreenWidth(24),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "bằng số điện thoại",
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: getProportionateScreenWidth(22),
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ]),
                      ),
                    ),
                    Expanded(
                        child: Center(child: Image.asset('assets/icons/logo_login.png', height: 80, width: 80)))
                  ],
                )),
            const Expanded(flex: 3, child: SignInForm()),
          ],
        ),
      ),
    );
  }
}

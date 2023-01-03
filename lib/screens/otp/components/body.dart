import 'package:app_shipper/core/auth_provider.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/constants.dart';
import 'package:app_shipper/screens/otp/otp_screen.dart';
import 'package:app_shipper/size_config.dart';
import 'package:app_shipper/utils/ToastUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'otp_form.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) => SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                Text(
                  "Xác minh OTP",
                  style: headingStyle,
                ),
                Text(
                    "Chúng tôi gửi mã xác nhận đến ${provider.numberPhoneHidden()}"),
                buildTimer(),
                OtpForm(provider: provider),
                SizedBox(height: SizeConfig.screenHeight * 0.05),
                GestureDetector(
                  onTap: () {
                    // OTP code resend
                    print('resend');
                    showToastInApp(context, 'Đã gửi lại mã xác nhận',
                        backgroundColor: kPrimaryLightColor,
                        textColor: kWhiteColor);
                    provider.setIsConfirm(false);
                    Navigator.popAndPushNamed(context, OtpScreen.routeName);
                  },
                  child: const Text(
                    "Gửi lại mã OTP",
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Mã này sẽ hết hạn sau "),
        TweenAnimationBuilder(
          tween: Tween(begin: 60.0, end: 0.0),
          duration: const Duration(seconds: 60),
          builder: (_, dynamic value, child) {
            return Text(
              "00:${value != 0 ? value.toInt() : '00'}",
              style: TextStyle(color: value != 0 ? kPrimaryColor : kErrorColor),
            );
          },
        ),
      ],
    );
  }
}

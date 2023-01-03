import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/components/loading_widget.dart';
import 'package:app_shipper/core/auth_provider.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/constants.dart';
import 'package:app_shipper/size_config.dart';
import 'package:app_shipper/utils/ToastUtils.dart';
import 'package:flutter/material.dart';


class OtpForm extends StatefulWidget {
  const OtpForm({
    Key? key, required this.provider,
  }) : super(key: key);
  final AuthProvider provider;

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;

  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  String getOTP(){
    String otp = otp1Controller.text + otp2Controller.text + otp3Controller.text + otp4Controller.text;
    print('OTP:  $otp');
    return otp;
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: SizeConfig.screenHeight * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  controller: otp1Controller,
                  autofocus: true,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  controller: otp2Controller,
                  focusNode: pin2FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin3FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  controller: otp3Controller,
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) => nextField(value, pin4FocusNode),
                ),
              ),
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  controller: otp4Controller,
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin4FocusNode!.unfocus();
                      // Then you need to check is the code is correct or not
                      if(otp1Controller.text.isEmpty || otp2Controller.text.isEmpty || otp3Controller.text.isEmpty || otp4Controller.text.isEmpty){
                        showToastInApp(context, 'Vui lòng nhập đủ thông tin', backgroundColor: kWarningColor, textColor: kWhiteColor);
                      } else {

                        // widget.provider.confirmOTP(context, getOTP(), _formKey);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.05),
          widget.provider.isConfirm ? const LoadingWidget(color: kPrimaryColor) : SizedBox(
            height: getProportionateScreenHeight(48),
            width: SizeConfig.screenWidth,
            child: DefaultButton(
              text: "Xác nhận",
              press: (){
                if(otp1Controller.text.isEmpty || otp2Controller.text.isEmpty || otp3Controller.text.isEmpty || otp4Controller.text.isEmpty){
                  showToastInApp(context, 'Vui lòng nhập đủ thông tin', backgroundColor: kWarningColor, textColor: kWhiteColor);
                } else {
                  // widget.provider.confirmOTP(context, getOTP(), _formKey);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

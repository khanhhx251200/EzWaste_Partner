import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF0EB043);
const kPrimaryLightColor = Color(0xFF58C582);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [kPrimaryLightColor, kPrimaryColor],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const kGreyColor = Colors.grey;
const kBlackColor = Colors.black;
const kSecondaryTextColor = Color(0xFFBBBBBB);
const kWhiteColor = Colors.white;
const bgColor = Color(0xFFF6F5F2);
const kWarningColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);
const kSuccessColor = Color(0xFF42BA96);
const kThirdColor = Color(0xFFF56618);
const kThirdLightColor = Color(0xFFFEF4EA);
const kFourLightColor = Color(0xFF454480);
const kNoSelectButtonColor = Color(0xFFEFEFEF);
const kNoSelectTextnColor = Color(0xFF686868);
const kBackgroundColor = Color(0xFFF2F2F2);
const kOrganicColor = Color(0xFFFF6E7C);
const kPlasticColor = Color(0xFF4BC999);
const kLabelColor = Color(0xFF8E8E8E);
const kGreenColor = Color(0xFF3FBE81);
const kBlueColor = Color(0xFF4E71FF);
final kGrey75Color = Colors.grey.withOpacity(0.75);

Color statusColor(int status) {
  if (status == 1 || status == 5) {
    return kErrorColor;
  } else if (status == 2 || status == 3) {
    return kWarningColor;
  } else {
    return kSuccessColor;
  }
}
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class AppbarDashboard extends StatelessWidget {
  const AppbarDashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // leading: IconButton(
      //   onPressed: () {},
      //   icon: Icon(Icons.menu),
      // ),
      centerTitle: false,
      title: Image.asset('assets/images/logo_app.png', height: 48),
      actions: [
        SvgPicture.asset(
            "assets/icons/bell.svg",
        ),
        const SizedBox(width: size24,)
      ],
    );
  }
}

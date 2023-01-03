import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';

class ConfirmSuccess extends StatelessWidget {
  static String routeName = "/confirm_success";

  const ConfirmSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage('assets/images/background_booking.png'), fit: BoxFit.cover)
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size14, vertical: _size.height * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(size14),
                  child: Text(
                    'Thu gom hoàn tất',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: size18),
                  ),
                ),
              ),
              Image.asset(
                'assets/images/hand_and_heart.png',
                width: _size.width * 0.6,
                height: _size.height * 0.5,
              ),
              SizedBox(
                width: _size.width,
                child: DefaultButton(
                  press: () => Navigator.pushReplacementNamed(
                      context, DashBoardScreen.routeName),
                  color: kGreenColor,
                  text: kBackToHome,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

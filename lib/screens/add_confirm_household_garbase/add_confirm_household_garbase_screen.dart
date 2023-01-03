import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/model/electronic_scale.dart';
import 'package:app_shipper/screens/add_confirm_household_garbase/components/organic_confirm_card.dart';
import 'package:app_shipper/screens/add_confirm_household_garbase/provider/card_organic_provider.dart';
import 'package:app_shipper/screens/dashboard/home/provider/home_page_provider.dart';
import 'package:app_shipper/screens/home/home_screen.dart';
import 'package:app_shipper/screens/home/provider/home_provider.dart';
import 'package:app_shipper/services/order_service.dart';
import 'package:app_shipper/utils/ToastUtils.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddConfirmHousehold extends StatefulWidget {
  static const routeName = '/confirm-household';

  const AddConfirmHousehold({Key? key}) : super(key: key);

  @override
  State<AddConfirmHousehold> createState() => _AddConfirmHouseholdState();
}

class _AddConfirmHouseholdState extends State<AddConfirmHousehold> {
  final OrderService _orderService = OrderService();
  bool isConnect = false;
  bool isConnecting = false;
  double mass = 0;

  getKL() async {
    setState(() => isConnecting = true);
    print('cân điện tử');
    if (!isConnect) {
      try {
        final http.Response response =
            await http.get(Uri.parse("http://45.117.80.11:1884/get=12345"));
        setState(() => isConnecting = false);
        final parsed = json.decode(utf8.decode(response.bodyBytes));
        print('res: ' + response.toString());

        Future.delayed(const Duration(milliseconds: 250), () {
          getKL();
        });
        setState(() {
          isConnect = true;
          ElectronicScale electronicScale = ElectronicScale.fromJson(parsed);
          mass = convertKL(electronicScale.value);
        });
      } catch (e) {
        setState(() => isConnecting = false);
      }
    }
  }

  validateConfirm() async {
    if (isConnect) {
      // test
      // mass = 6.9;
      if (mass > 0) {
        await confirmOrganic();
      } else {
        showToastInApp(context, 'Số lượng cân đang bằng 0!',
            backgroundColor: kErrorColor, textColor: kWhiteColor);
      }
    } else {
      showToastInApp(context, 'Chưa kết nối với cân điện tử!',
          backgroundColor: kErrorColor, textColor: kWhiteColor);
    }
  }

  Future<void> confirmOrganic() async {
    final provider = Provider.of<CardOrganicProvider>(context, listen: false);
    final order = provider.orderSelected;
    if (order != null) {
      String id = order.idCreate.toString();
      try {
        final response = await _orderService.sendConfirmOrganic(id, mass);
        print('res: ' + response.toString());
        if (response) {
          showToastInApp(
              context, 'Đã gửi xác nhận thu gom ${order.userCreateFullName}!',
              backgroundColor: kSuccessColor, textColor: kWhiteColor);
          setState(() => mass = 0.0);
          provider.confirm();
          if (provider.listUserOrder.isEmpty) {
            showToastInApp(
                context, 'Hoàn thành lịch thu gom ngày hôm nay!',
                backgroundColor: kSuccessColor, textColor: kWhiteColor);
          }
        } else {
          showToastInApp(context, 'Đã có lỗi khi gửi xác nhận thu gom!',
              backgroundColor: kErrorColor, textColor: kWhiteColor);
        }
      } catch (e) {
        showToastInApp(context, 'Đã có lỗi khi gửi xác nhận thu gom!',
            backgroundColor: kErrorColor, textColor: kWhiteColor);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildLogo(),
          const SizedBox(height: size14),
          Expanded(
            child: context.read<HomePageProvider>().listBooking.isEmpty ? completeToday() : Column(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: size14),
                    child: buildCards(),
                  ),
                ),
                const SizedBox(height: size14),
                buildButton(),
                const SizedBox(height: size8),
                Visibility(
                  visible: isConnect,
                  child: const Padding(
                    padding: EdgeInsets.all(size8),
                    child: Center(
                        child: Text(
                          'Số lượng cân rác sinh hoạt',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor,
                              fontSize: size20),
                        )),
                  ),
                ),
                Visibility(
                    visible: isConnect,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text.rich(TextSpan(text: 'Số cân: ', children: [
                          TextSpan(
                              text: '$mass kg',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: kSuccessColor))
                        ])),
                      ),
                    )),
                Visibility(
                  visible: isConnect,
                  child: Container(
                    padding: const EdgeInsets.all(size8),
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all<Color>(kPrimaryColor)),
                        onPressed: () => validateConfirm(),
                        child: const Text('Xác nhận')),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  Widget buildCards() {
    final provider = Provider.of<CardOrganicProvider>(context);
    final listUserOrder = provider.listUserOrder;
    return Stack(
      children: listUserOrder
          .map((userInfo) => OrganicConfirmCard(
                order: userInfo,
                isFront: listUserOrder.last == userInfo,
              ))
          .toList(),
    );
  }

  double convertKL(double klg) {
    return klg * 0.001;
  }

  ElevatedButton buildButtonConnect(bool isConnect) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
        onPressed: () {
          getKL();
        },
        child: const Text('Kết nối cân điện tử'));
  }

  Widget buildLogo() => Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: size20, top: size14),
            child: Image.asset(
              'assets/images/logo_app.png',
              height: 80,
            ),
          ),
          const Spacer()
        ],
      );

  Widget buildButton() {
    final provider = Provider.of<CardOrganicProvider>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
            style: styleButtonAction(),
            onPressed: () {
              setState(() => isConnect = false);
              Navigator.pop(context);
            },
            child: const Icon(Icons.clear, color: Colors.red, size: 40)),
        ElevatedButton(
            style: styleButtonAction(),
            onPressed: () {
              getKL();
            },
            child: Icon(isConnect ? Icons.refresh : Icons.play_arrow,
                color: kWarningColor, size: 40)),
        ElevatedButton(
            style: styleButtonAction(),
            onPressed: () => validateConfirm(),
            child: const Icon(Icons.check, color: kSuccessColor, size: 40)),
      ],
    );
  }

  Padding completeToday() => Padding(
    padding: const EdgeInsets.all(size14),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check, color: kSuccessColor, size: size36,),
            Expanded(child: Text('Đã hoàn thành lịch thu gom', style: TextStyle(fontSize: size24, color: kSuccessColor),)),
          ],
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: size14),
          child: DefaultButton(
            text: 'Quay lại',
            press: () => Navigator.pop(context),
          ),
        )
      ],
    ),
  );

  ButtonStyle styleButtonAction() => ElevatedButton.styleFrom(
      elevation: size8,
      primary: kWhiteColor,
      shape: const CircleBorder(),
      minimumSize: const Size.square(60));
}

import 'dart:convert';

import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/core/auth_provider.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/screens/dashboard/home/provider/home_page_provider.dart';
import 'package:app_shipper/utils/ToastUtils.dart';
import 'package:http/http.dart' as http;
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/electronic_scale.dart';
import 'package:app_shipper/screens/add_confirm/provider/add_confirm_provider.dart';
import 'package:app_shipper/screens/confirm_recycle/components/app_bar.dart';
import 'package:app_shipper/screens/confirm_recycle/components/info_customer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CreateConfirmOrganic extends StatefulWidget {
  static const String routeName = '/confirm-organic';

  const CreateConfirmOrganic({Key? key}) : super(key: key);

  @override
  _CreateConfirmOrganicState createState() => _CreateConfirmOrganicState();
}

class _CreateConfirmOrganicState extends State<CreateConfirmOrganic> {
  final inputMassController = TextEditingController(text: "0");
  double sizeButton = 48;
  double mass = 0;
  int indexCollect = 0;
  bool isConfirm = false;

  getKL() async {
    print('cân điện tử');
    try {
      final http.Response response =
          await http.get(Uri.parse("http://45.117.80.11:1884/get=12345"));
      final parsed = json.decode(utf8.decode(response.bodyBytes));
      print('res: ' + response.toString());

      // Future.delayed(const Duration(milliseconds: 250), () {
      //   getKL();
      // });
      setState(() {
        ElectronicScale electronicScale = ElectronicScale.fromJson(parsed);
        print('kl: ${convertKL(electronicScale.value)}');

        mass = convertKL(electronicScale.value) +
            double.parse(inputMassController.text);
        inputMassController.text = mass.toStringAsFixed(3);
        print('mass: $mass');
      });
    } catch (e) {
      showToastInApp(context, 'Không thể kết nối tới cân điện tử',
          backgroundColor: kWarningColor);
    }
  }

  double convertKL(double klg) {
    return klg * 0.001;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, provider, child) => Scaffold(
        appBar: appBarConfirm(),
        backgroundColor: kWhiteColor,
        body: indexCollect == provider.listBooking.length
            ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(
                      Icons.check,
                      color: kSuccessColor,
                      size: size36,
                    ),
                    Expanded(
                        child: Text(
                      'Đã hoàn thành lịch thu gom',
                      style: TextStyle(fontSize: size24, color: kSuccessColor),
                    )),
                  ],
                ),
              )
            : SafeArea(
                child: SingleChildScrollView(
                child: Column(
                  children: [
                    InfoCustomerConfirm(
                      address: provider.listBooking[indexCollect].address!,
                      fullName: provider.listBooking[indexCollect].nameSeller!,
                      userName: provider.listBooking[indexCollect].phoneSeller!,
                      // address: booking.address!,
                      // fullName: booking.nameSeller!,
                      // userName: booking.phoneSeller!,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(size32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            kOrganicRecycle,
                            style: TextStyle(
                                fontSize: size20,
                                fontWeight: FontWeight.w700,
                                color: kOrganicColor),
                          ),
                          const SizedBox(
                            height: size32,
                          ),
                          Text(
                            'Số lượng thùng rác: ${Provider.of<AuthProvider>(context, listen: false).userInfo!.clientId}',
                            style: const TextStyle(
                              fontSize: size16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: size32,
                          ),
                          inputTotalMass(),
                          const SizedBox(
                            height: size16,
                          ),
                          SizedBox(
                            height: sizeButton,
                            width: double.infinity,
                            child: DefaultButton(
                              text: 'Nhận thông tin từ cân điện tử',
                              color: kGreenColor,
                              borderRadius: 15,
                              press: () async {
                                await getKL();
                              },
                            ),
                          ),
                          const SizedBox(
                            height: size16,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: sizeButton,
                                  child: DefaultButton(
                                    text: isConfirm ? kCompleted : kSendInfo,
                                    color: isConfirm ? kSuccessColor : kGreenColor,
                                    borderRadius: 15,
                                    press: isConfirm
                                        ? null
                                        : () async {
                                            provider.listBooking[indexCollect]
                                                .setMass = mass;
                                            isConfirm = await Provider.of<
                                                        AddConfirmProvider>(
                                                    context,
                                                    listen: false)
                                                .confirmOrganic(
                                                    provider.listBooking[
                                                        indexCollect],
                                                    context);
                                            setState(() {});
                                          },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: size8,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: sizeButton,
                                  child: DefaultButton(
                                    text: kNext,
                                    color: kBlueColor,
                                    borderRadius: 15,
                                    press: isConfirm
                                        ? () {
                                            if (indexCollect <=
                                                provider.listBooking.length) {
                                              setState(() {
                                                indexCollect++;
                                                isConfirm = false;
                                                inputMassController.text = '0';
                                              });
                                            }
                                          }
                                        : () => showToastInApp(context,
                                            'Bạn chưa gửi thông tin thu gom',
                                            backgroundColor: kWarningColor,
                                            textColor: kWhiteColor),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
      ),
    );
  }

  TextField inputTotalMass() {
    return TextField(
      controller: inputMassController,
      readOnly: true,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
      ],
      style: const TextStyle(fontWeight: FontWeight.bold, color: kBlackColor),
      decoration: InputDecoration(
        labelText: 'Trọng lượng tổng (kg)',
        hintText: '0',
        focusColor: kGreenColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: size20, vertical: size12),
        floatingLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600, color: kBlackColor),
        prefixIcon: const Icon(
          Icons.local_grocery_store,
        ),
        suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                mass = 0;
                inputMassController.text = '0';
              });
            },
            icon: const Icon(
              Icons.refresh,
            )),
      ),
      onChanged: (value) {},
    );
  }
}

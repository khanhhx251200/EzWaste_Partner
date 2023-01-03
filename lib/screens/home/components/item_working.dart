import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/order.dart';
import 'package:app_shipper/screens/add_confirm/add_confirm_screen.dart';
import 'package:app_shipper/size_config.dart';
import 'package:flutter/material.dart';

class ItemWorking extends StatelessWidget {
  const ItemWorking({Key? key, required this.item}) : super(key: key);
  final Order item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(
          padding: EdgeInsets.all(size8),
          child: Text('Lịch thu gom sắp tới',
              style: TextStyle(
                  fontSize: size16,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold)),
        ),
        Card(
          elevation: size12,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(size8),
                child: Row(
                  children: [
                    SizedBox(
                      height: getProportionateScreenHeight(64),
                      width: getProportionateScreenWidth(64),
                      child: const CircleAvatar(
                        backgroundImage:
                            AssetImage("assets/images/user_empty.png"),
                      ),
                    ),
                    const SizedBox(width: size8),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          item.userCreateFullName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kBlackColor),
                        ),
                        SizedBox(
                            height:
                                getProportionateScreenHeight(size8)),
                        Text(
                          item.userCreate,
                          style: const TextStyle(
                            color: kTextColor,
                            fontSize: size12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                            height:
                                getProportionateScreenHeight(size8)),
                        Text(
                          "Địa chỉ: ${item.address}",
                          style: const TextStyle(
                              color: kTextColor, fontSize: size12),
                        ),
                      ],
                    ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(size8),
                child: Row(
                  children: [
                    const Text('Thời gian thu gom: ',
                        style: TextStyle(fontSize: size12)),
                     Expanded(
                      child: Text(convertDateDetail(item.time),
                          style:const TextStyle(
                              fontSize: size12,
                              fontWeight: FontWeight.bold,
                              color: kBlackColor)),
                    ),
                    // item.status == 2 ? ElevatedButton(
                    //   style: ButtonStyle(
                    //       backgroundColor: MaterialStateProperty.all<Color>(
                    //           kPrimaryColor)),
                    //   child: const Text('Thu gom'),
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, AddConfirm.routeName,
                    //         arguments: item.id);
                    //   },
                    // ) : const SizedBox()
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

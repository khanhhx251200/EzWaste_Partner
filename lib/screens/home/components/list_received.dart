import 'dart:ui';

import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/home/provider/home_provider.dart';
import 'package:app_shipper/size_config.dart';
import 'package:flutter/material.dart';

class ListReceived extends StatefulWidget {
  const ListReceived({Key? key, required this.provider}) : super(key: key);
  final HomeProvider provider;

  @override
  State<ListReceived> createState() => _ListReceivedState();
}

class _ListReceivedState extends State<ListReceived> {
  @override
  void initState() {
    super.initState();
    widget.provider.getListReceived();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => widget.provider.getListReceived(),
      child: ListView.builder(
        itemCount: widget.provider.listReceive.length,
        itemBuilder: (context, index) {
          final element = widget.provider.listReceive[index];
          return Card(
            elevation: size12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
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
                            element.userCreateFullName ,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: kFourLightColor),
                          ),
                           Text(
                            element.userCreate,
                            style: const TextStyle(
                                color: kTextColor, fontSize: size12),
                          ),
                          Row(
                            children: [
                              const Text('Thời gian thu gom: ',
                                  style: TextStyle(fontSize: size12)),
                              Expanded(
                                child: Text(convertDateDetail(element.time),
                                    style: const TextStyle(
                                        fontSize: size12,
                                        fontWeight: FontWeight.bold,
                                        color: kFourLightColor)),
                              ),
                            ],
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Địa chỉ: ',
                                  style: TextStyle(fontSize: size12)),
                              Expanded(
                                child: Text(element.address,
                                    style: const TextStyle(
                                        fontSize: size12,
                                        fontWeight: FontWeight.bold,
                                        color: kFourLightColor)),
                              ),
                            ],
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

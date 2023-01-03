import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/order.dart';
import 'package:app_shipper/size_config.dart';
import 'package:flutter/material.dart';

class ItemComplete extends StatefulWidget {
  const ItemComplete({Key? key, required this.item}) : super(key: key);
  final Order item;

  @override
  State<ItemComplete> createState() => _ItemCompleteState();
}

class _ItemCompleteState extends State<ItemComplete> {
  bool _isSeeMore = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => Navigator.pushNamed(context, DetailComplete.routeName),
      onTap: () => print(''),
      child: Padding(
        padding: const EdgeInsets.only(top: size8),
        child: Container(
          decoration: const BoxDecoration(color: kWhiteColor),
          padding: const EdgeInsets.all(size8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.item.type == 1 ? 'Rác sinh hoạt' : 'Rác tái chế',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.item.type == 1
                              ? kOrganicColor
                              : kPlasticColor,
                          fontSize: size12)),
                  Spacer(),
                  const Icon(Icons.done, color: kSuccessColor),
                  SizedBox(width: getProportionateScreenWidth(size8)),
                  const Text('Đã hoàn thành',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kSuccessColor,
                          fontSize: size12)),
                ],
              ),
              const Divider(color: kGreyColor),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text('Mã đơn hàng',
              //         style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             color: kFourLightColor,
              //             fontSize: smallSize)),
              //     GestureDetector(
              //       onTap: () {
              //         Clipboard.setData(ClipboardData(text: "220109BVRJ4NYD"));
              //         showToastInApp(
              //             context, "Đã sao chép 220109BVRJ4NYD vào bộ nhớ tạm",
              //             textColor: kWhiteColor, align: kBOTTOM);
              //       },
              //       child: RichText(
              //           text: TextSpan(children: [
              //         TextSpan(
              //           text: '220109BVRJ4NYD'.toUpperCase(),
              //           style: const TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: kFourLightColor,
              //               fontSize: smallSize),
              //         ),
              //         TextSpan(
              //           text: " " + kCopy.toUpperCase(),
              //           style: const TextStyle(
              //               fontWeight: FontWeight.bold,
              //               color: kPrimaryLightColor,
              //               fontSize: smallSize),
              //         ),
              //       ])),
              //     ),
              //   ],
              // ),
              if (widget.item.type == 2) SizedBox(height: getProportionateScreenHeight(size8)),
              if (widget.item.type == 2) Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Thời gian tạo đơn',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kSecondaryTextColor,
                          fontSize: size12)),
                  Text(convertDateDetail(widget.item.createDate),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kSecondaryTextColor,
                          fontSize: size12)),
                ],
              ),
              SizedBox(height: getProportionateScreenHeight(size8)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Thời gian thu gom',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kSecondaryTextColor,
                          fontSize: size12)),
                  Text(convertDateDetail(widget.item.time),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kSecondaryTextColor,
                          fontSize: size12)),
                ],
              ),
              const Divider(color: kGreyColor),
              Row(
                children: [
                  Expanded(
                      child: ListTile(
                    dense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    leading: Image.asset(
                      "assets/images/weight.png",
                      width: 32,
                      height: 32,
                    ),
                    title: const Text('Khối lượng',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kFourLightColor,
                            fontSize: size12)),
                    subtitle: Text('${widget.item.mass.toStringAsFixed(2)} kg',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  )),
                  Expanded(
                      child: ListTile(
                    dense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                    leading: Image.asset(
                      "assets/images/total_money.png",
                      width: 32,
                      height: 32,
                    ),
                    title: const Text('Thành tiền',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kFourLightColor,
                            fontSize: size12)),
                    subtitle:
                        Text(widget.item.money.toStringAsFixed(0) + ' VNĐ',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                  ))
                ],
              ),
              Visibility(
                  visible: _isSeeMore,
                  child: SizedBox(
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.item.listItem.length,
                          itemBuilder: (context, index) {
                            final element = widget.item.listItem[index];
                            return ListTile(
                              title: Text(element.idItemsModel.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kBlackColor,
                                      fontSize: size12)),
                              subtitle: Text('${element.khoiluong} kg',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size10)),
                              trailing: Text(getItemMoney(element),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: kBlackColor,
                                      fontSize: size12)),
                            );
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: size20),
                          padding: const EdgeInsets.symmetric(
                              horizontal: size14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Tổng (${widget.item.mass.toStringAsFixed(2)}kg)',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size12,
                                      color: kBlackColor)),
                              Text(
                                  widget.item.money.toStringAsFixed(0) + ' VNĐ',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: size12,
                                      color: kBlackColor)),
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              Visibility(
                visible: widget.item.type == 2,
                child: Center(
                    child: TextButton(
                  onPressed: () {
                    setState(() {
                      _isSeeMore = !_isSeeMore;
                    });
                  },
                  child: Text(!_isSeeMore ? kSeeMore : kCollapse,
                      style: const TextStyle(
                          fontSize: size12, color: kNoSelectTextnColor)),
                )),
              ),
              const Divider(color: kGreyColor),
              ListTile(
                dense: true,
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: size8),
                leading: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user_empty.png"),
                ),
                title: Text(widget.item.userCreateFullName,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kFourLightColor,
                        fontSize: size14)),
                subtitle: Text(widget.item.userCreate,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    )),
                trailing: const Text('Hoàn thành',
                    style: TextStyle(
                        fontSize: size12, color: kPrimaryLightColor)),
              ),
              //  Divider(color: kGreyColor),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     const Text('Chưa nhận được đánh giá nào',
              //         style: TextStyle(
              //             fontSize: smallSize, color: kNoSelectTextnColor)),
              //     SizedBox(
              //       height: 40,
              //       width: 120,
              //       child: ElevatedButton(
              //         style: ButtonStyle(
              //             backgroundColor:
              //                 MaterialStateProperty.all(kPrimaryColor)),
              //         onPressed: () {},
              //         child: Text(kRate),
              //       ),
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  String getTotalWeight(ItemData item) {
    double weight = 0;
    for (int i = 0; i < item.listItem.length; i++) {
      weight += item.listItem[i].khoiluong;
    }
    return weight.toStringAsFixed(1);
  }

  String getTotalMoney(ItemData item) {
    double money = 0;
    for (int i = 0; i < item.listItem.length; i++) {
      money += item.listItem[i].idItemsModel.money * item.listItem[i].khoiluong;
    }
    return convertIntToCurrency(int.parse(money.toString().split(".")[0]));
  }

  String getItemMoney(ListItem item) {
    double money = 0;
    money = item.khoiluong * item.idItemsModel.money;
    return convertIntToCurrency(int.parse(money.toString().split(".")[0]));
  }
}

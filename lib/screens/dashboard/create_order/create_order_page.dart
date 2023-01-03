import 'package:app_shipper/components/decoration_border_shadow.dart';
import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/components/loading_widget.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/dto/user_dto.dart';
import 'package:app_shipper/core/model/product.dart';
import 'package:app_shipper/screens/add_confirm/provider/add_confirm_provider.dart';
import 'package:app_shipper/screens/confirm_recycle/components/info_customer.dart';
import 'package:app_shipper/screens/confirm_recycle/components/list_input.dart';
import 'package:app_shipper/screens/dashboard/activities/provider/activities_provider.dart';
import 'package:app_shipper/screens/dashboard/components/title_page.dart';
import 'package:app_shipper/utils/ToastUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({Key? key}) : super(key: key);

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  UserDto? user;
  bool isLoading= false;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ActivitiesProvider>(context, listen: false);
    provider.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivitiesProvider>(
      builder: (context, provider, child) {
        return Container(
          color: kWhiteColor,
          child: Column(
            children: [
              const TitlePage(title: kCreateOrder),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      if (provider.users != null &&
                          provider.users!.isNotEmpty)
                        Container(
                          decoration: boxDecorationShadow(radius: 20),
                          margin: const EdgeInsets.all(size8),
                          padding: const EdgeInsets.symmetric(horizontal: size8),
                          child: DropdownButton(
                            isExpanded: true,
                            value: user,
                            items: provider.users!.map((UserDto user) {
                              return DropdownMenuItem(
                                value: user,
                                child: ListTile(
                                  leading: Image.asset(
                                      'assets/images/user_empty.png'),
                                  title: Text(user.fullName,
                                      style: const TextStyle(
                                          color: kBlackColor,
                                          fontWeight: FontWeight.w600)),
                                  subtitle: Text(user.userName),
                                ),
                              );
                            }).toList(),
                            selectedItemBuilder: (_) {
                              return provider.users!
                                  .map<Widget>((UserDto user) {
                                return Center(
                                  widthFactor: 1,
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: size12),
                                      child: Text(user.fullName,
                                          style: const TextStyle(
                                              color: kBlackColor,
                                              fontWeight: FontWeight.bold))),
                                );
                              }).toList();
                            },
                            onChanged: (UserDto? value) {
                              setState(() {
                                user = value!;
                              });
                            },
                          ),
                        ),
                      const SizedBox(
                        height: size8,
                      ),
                      if (user != null)
                        InfoCustomerConfirm(
                          address: user!.address,
                          fullName: user!.fullName,
                          userName: user!.userName,
                        ),
                      Text(
                        kPlasticRecycle,
                        style: TextStyle(
                            fontSize: size24,
                            fontWeight: FontWeight.w700,
                            color: valueByType(2, kOrganicColor, kPlasticColor)),
                      ),
                      const SizedBox(
                        height: size8,
                      ),
                      const ListInputConfirm(),
                      const SizedBox(
                        height: size8,
                      ),
                      const SizedBox(
                        height: size8,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 48,
                margin: const EdgeInsets.all(size8),
                child: isLoading ? const LoadingWidget(color: kPrimaryColor) : DefaultButton(
                  text: kSendInfoCollect,
                  color: kGreenColor,
                  press: () {
                    confirm(context, provider);
                    // provider.confirmFastBooking(order.id, context,
                    //     note: noteController.text);
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void confirm(BuildContext context, ActivitiesProvider provider) async {
    if(user != null) {
      List<Product> list = Provider.of<AddConfirmProvider>(context, listen: false).listProduct;
      var json = [];
      for(var item in list){
        if(item.mass > 0 ){
          json.add(item.toJson());
        }
      }
      if(json.isNotEmpty) {
        setState(() => isLoading = true);
        final bookingResponse = await provider.shipperRegister(user!.id, json);
        if (bookingResponse != null) {
          showToastInApp(context, 'Tạo đơn thành công', backgroundColor: kSuccessColor, textColor: kWhiteColor);
          setState(() {
            user = null;
            isLoading = false;
          });
          Provider.of<AddConfirmProvider>(context, listen: false).getListProduct();
        }
      } else {
        showToastInApp(context, 'Bạn chưa nhập đơn vị cho loại rác nào', backgroundColor: kWarningColor, textColor: kWhiteColor);
      }
    } else {
      showToastInApp(context, 'Bạn chưa chọn người bán', backgroundColor: kWarningColor, textColor: kWhiteColor);
    }
  }
}

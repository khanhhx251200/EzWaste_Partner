import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/core/model/booking.dart';
import 'package:app_shipper/screens/add_confirm/provider/add_confirm_provider.dart';
import 'package:app_shipper/screens/confirm_recycle/components/app_bar.dart';
import 'package:app_shipper/screens/confirm_recycle/components/info_customer.dart';
import 'package:app_shipper/screens/confirm_recycle/components/list_input.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class CreateConfirmPlastic extends StatefulWidget {
  static const String routeName = '/confirm-plastic';

  const CreateConfirmPlastic({Key? key}) : super(key: key);

  @override
  State<CreateConfirmPlastic> createState() => _CreateConfirmPlasticState();
}

class _CreateConfirmPlasticState extends State<CreateConfirmPlastic> {
  final TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Booking booking =
        ModalRoute.of(context)?.settings.arguments as Booking;
    return Scaffold(
      appBar: appBarConfirm(),
      backgroundColor: kWhiteColor,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            InfoCustomerConfirm(
              address: booking.address!,
              fullName: booking.nameSeller!,
              userName: booking.phoneSeller!,
            ),
            Padding(
              padding: const EdgeInsets.all(size32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueByType(
                        booking.type!, kOrganicRecycle, kPlasticRecycle),
                    style: TextStyle(
                        fontSize: size20,
                        fontWeight: FontWeight.w700,
                        color: valueByType(2, kOrganicColor, kPlasticColor)),
                  ),
                  const SizedBox(
                    height: size32,
                  ),
                  const ListInputConfirm(),
                  // const SizedBox(
                  //   height: size8,
                  // ),
                  // FieldNote(
                  //   textEditingController: noteController,
                  // ),
                  const SizedBox(
                    height: size8,
                  ),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: DefaultButton(
                      text: kSendInfoCollect,
                      color: kGreenColor,
                      borderRadius: 15,
                      press: () {
                        final provider = Provider.of<AddConfirmProvider>(
                            context,
                            listen: false);

                        provider.confirmPlastic(booking.id, context,
                            note: noteController.text);
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

import 'package:app_shipper/components/decoration_border_shadow.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:flutter/material.dart';

class DetailActitivities extends StatelessWidget {
  const DetailActitivities({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelQuantity(),
        SizedBox(
          height: size36,
        ),
        Row(
          children: [
            Image.asset('assets/images/capa.png'),
            const SizedBox(
              width: size14,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  boxDetail(kOrganicRecycle, kOrganicColor),
                  const SizedBox(
                    height: size20,
                  ),
                  boxDetail(kPlasticRecycle, kPlasticColor),
                ],
              ),
            )
          ],
        )
      ],
    );
  }

  Container boxDetail(String label, Color color) {
    return Container(
      decoration: boxDecorationShadow(),
      child: ListTile(
        leading: IconButton(
          icon: Icon(Icons.delete, color: color),
          onPressed: null,
        ),
        title: Text(
          '9 kg',
          style: TextStyle(
              color: color, fontSize: size20, fontWeight: FontWeight.w700),
        ),
        subtitle: Text(label,
          style: TextStyle(
              color: color, fontSize: size12)),
      ),
    );
  }

  Text labelQuantity() {
    return Text(
      kQuantityTaken,
      style: TextStyle(
          fontSize: size16, fontWeight: FontWeight.w600, color: kBlackColor),
    );
  }
}

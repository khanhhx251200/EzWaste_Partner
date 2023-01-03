import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/screens/add_confirm/provider/add_confirm_provider.dart';
import 'package:app_shipper/screens/confirm_recycle/components/field_product.dart';
import 'package:app_shipper/core/model/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListInputConfirm extends StatefulWidget {
  const ListInputConfirm({
    Key? key,
  }) : super(key: key);

  @override
  State<ListInputConfirm> createState() => _ListInputConfirmState();
}

class _ListInputConfirmState extends State<ListInputConfirm> {
  @override
  void initState() {
    super.initState();
    Provider.of<AddConfirmProvider>(context, listen: false).getListProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddConfirmProvider>(
      builder: (BuildContext context, AddConfirmProvider provider, child) =>
          Padding(
            padding: const EdgeInsets.all(size8),
            child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Loại rác thu gom',
                  style: TextStyle(
                      fontSize: size16,
                      fontWeight: FontWeight.w700,
                      color: kBlackColor),
                ),
                Text(
                  'Đơn vị (kg)',
                  style: TextStyle(
                    fontSize: size12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: size8,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: provider.listProduct.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: size8),
                  child: FieldProduct(
                    product: provider.listProduct[index],
                  ),
                );
              },
            ),
        ],
      ),
          ),
    );
  }
}

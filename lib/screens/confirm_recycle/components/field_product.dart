import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/model/product.dart';
import 'package:app_shipper/screens/add_confirm/provider/add_confirm_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class FieldProduct extends StatefulWidget {
  const FieldProduct({
    Key? key,
    required this.product,
  }) : super(key: key);
  final Product product;

  @override
  State<FieldProduct> createState() => _FieldProductState();
}

class _FieldProductState extends State<FieldProduct> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]+[,.]{0,1}[0-9]*')),
      ],
      textAlign: TextAlign.end,
      style: const TextStyle(fontWeight: FontWeight.bold, color: kBlackColor),
      decoration: InputDecoration(
        labelText: widget.product.name,
        hintText: '0',
        focusColor: kGreenColor,
        contentPadding: const EdgeInsets.symmetric(
            horizontal: size20, vertical: size12),
        floatingLabelStyle:
            const TextStyle(fontWeight: FontWeight.w600, color: kBlackColor),
        suffixIcon: const Icon(
          Icons.local_grocery_store,
        ),
      ),
      onChanged: (value) {
        widget.product.mass = value == '' ? 0 : double.parse(value);
        Provider.of<AddConfirmProvider>(context, listen: false).setItemToList(widget.product);
      },
    );
  }
}

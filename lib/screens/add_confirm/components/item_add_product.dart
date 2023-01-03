import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/model/product.dart';
import 'package:app_shipper/screens/add_confirm/provider/add_confirm_provider.dart';
import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class ItemAddProduct extends StatefulWidget {
  const ItemAddProduct({
    Key? key,
    required this.product,
    required this.provider,
  }) : super(key: key);
  final Product product;
  final AddConfirmProvider provider;

  @override
  State<ItemAddProduct> createState() => _ItemAddProductState();
}

class _ItemAddProductState extends State<ItemAddProduct> {
  bool _isAdd = false;
  TextEditingController weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  changeMassInList(num newValue) {
    print(newValue);

    widget.product.mass = double.parse(newValue.toStringAsFixed(3));
    print(widget.product.mass);
    widget.provider.setItemToList(widget.product);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text(
            widget.product.name,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              const Expanded(child: Text('Khối lượng (Kg)')),
              Expanded(
                child:
                _isAdd
                    ? NumberInputWithIncrementDecrement(
                        controller: weightController,
                        isInt: false,
                        incDecFactor: 0.1,
                        min: 0,
                        max: 1000,
                        onChanged: (newValue) => changeMassInList(newValue),
                        onDecrement: (newValue) => changeMassInList(newValue),
                        onIncrement: (newValue) => changeMassInList(newValue),
                      )
                    :
                btnAdd(widget.provider),
              )
            ],
          ),
        ),
        const Divider()
      ],
    );
  }

  SizedBox btnAdd(AddConfirmProvider provider) {
    return SizedBox(
      height: 36,
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor)),
        onPressed: () {
          provider.addItemToList(widget.product);
          setState(() {
            _isAdd = true;
          });
        },
        child: const Text('Thêm'),
      ),
    );
  }
}

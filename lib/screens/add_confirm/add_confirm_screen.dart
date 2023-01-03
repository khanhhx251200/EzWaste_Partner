import 'package:app_shipper/components/loading_widget.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/model/product.dart';
import 'package:app_shipper/screens/add_confirm/components/item_add_product.dart';
import 'package:app_shipper/screens/add_confirm/provider/add_confirm_provider.dart';
import 'package:app_shipper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddConfirm extends StatefulWidget {
  static String routeName = '/add_confirm';

  const AddConfirm({Key? key}) : super(key: key);

  @override
  _AddConfirmState createState() => _AddConfirmState();
}

class _AddConfirmState extends State<AddConfirm> {

  @override
  void initState() {
    super.initState();
    Provider.of<AddConfirmProvider>(context, listen: false).getListProduct();
  }

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    print('arg: $id');
    return Consumer<AddConfirmProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: buildAppBar(provider, id),
          body: SafeArea(
            child: ListView.builder(
              itemCount: provider.listProduct.length,
              itemBuilder: (context, index) {
                final Product element = provider.listProduct[index];
                return ItemAddProduct(
                  product: element,
                  provider: provider,
                );
              },
            ),
          ),
        );
      },
    );
  }

  AppBar buildAppBar(AddConfirmProvider provider, int id) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      leading: const BackButton(
        color: kWhiteColor,
      ),
      title: const Text('Mặt hàng thu gom'),
      actions: [
        IconButton(
            onPressed: () => provider.confirmPlastic(id, context),
            icon: const Icon(Icons.shopping_cart)),
        SizedBox(width: getProportionateScreenWidth(size8))
      ],
    );
  }
}

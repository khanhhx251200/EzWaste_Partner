import 'package:flutter/material.dart';

class DropdownCustomers extends StatefulWidget {
  const DropdownCustomers({Key? key}) : super(key: key);

  @override
  _DropdownCustomersState createState() => _DropdownCustomersState();
}

class _DropdownCustomersState extends State<DropdownCustomers> {
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down),
        items: items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            // selectedValue = value as String;
          });
        },
      ),
    );
  }
}

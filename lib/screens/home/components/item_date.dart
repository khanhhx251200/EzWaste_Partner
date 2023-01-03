import 'package:flutter/material.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:intl/intl.dart';
import 'package:app_shipper/core/constants/color_constants.dart';

class ItemDate extends StatelessWidget {
  const ItemDate({
    Key? key,
    required this.currentDateTime,
    required this.element,
    required this.colors,
    required DateFormat monthFormatter,
    required DateFormat dayFormatter,
  }) : _monthFormatter = monthFormatter, _dayFormatter = dayFormatter, super(key: key);

  final DateTime currentDateTime;
  final DateTime element;
  final dynamic colors;
  final DateFormat _monthFormatter;
  final DateFormat _dayFormatter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: size8),
      decoration: BoxDecoration(
        color: currentDateTime == element ? colors : kBackgroundColor,
        borderRadius: BorderRadius.circular(size18),
        border:
        element.day == DateTime.now().day ? Border.all(color: colors) : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _monthFormatter.format(element),
            style: TextStyle(
              color: currentDateTime == element ? kWhiteColor : kLabelColor,
            ),
          ),
          const SizedBox(height: size8),
          Text(
            _dayFormatter.format(element),
            style: TextStyle(
                color:
                currentDateTime == element ? kWhiteColor : kLabelColor,
                fontWeight: FontWeight.bold,
                fontSize: size14),
          ),
        ],
      ),
    );
  }
}

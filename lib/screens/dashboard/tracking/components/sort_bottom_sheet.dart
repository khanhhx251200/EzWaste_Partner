import 'package:app_shipper/components/top_bottom_sheet.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/dashboard/tracking/components/box_selection.dart';
import 'package:app_shipper/screens/dashboard/tracking/provider/tracking_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class SortBottom extends StatefulWidget {
  const SortBottom({Key? key}) : super(key: key);

  @override
  State<SortBottom> createState() => _SortBottomState();
}

class _SortBottomState extends State<SortBottom> {
  List<BoxSelection> listSortBy = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    addSortBy();
  }

  addSortBy() {
    listSortBy.add(BoxSelection(
        title: "Thời gian thu gom gần nhất",
        isSelected: false,
        options: "NEAR"));
    listSortBy.add(BoxSelection(
        title: "Thời gian thu gom xa nhất", isSelected: false, options: "FAR"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      padding:
          const EdgeInsets.symmetric(vertical: size14, horizontal: size36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const TopBottomSheet(),
          const SizedBox(
            height: size8,
          ),
          const Text(
            kSortBy,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: size14),
          ),
          Expanded(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: listSortBy.length,
              itemBuilder: (context, index) => ListTile(
                onTap: () {
                  onTapSelectSort(index);
                },
                minLeadingWidth: 0,
                dense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 0,
                ),
                title: Text(
                  listSortBy[index].title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: listSortBy[index].isSelected
                    ? const Icon(
                        Icons.check,
                        color: kGreenColor,
                      )
                    : const SizedBox(),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onTapSelectSort(int index) {
    final provider = Provider.of<TrackingProvider>(context, listen: false);

    for (int i = 0; i < listSortBy.length; i++) {
      final selection = listSortBy[i];
      if (i == index) {
        setState(() {
          selection.isSelected = selection.isSelected ? false : true;
        });
        if (selection.isSelected) {
          provider.setSortBy(selection);
        } else {
          provider.sortByAll();
        }
      } else {
        setState(() {
          selection.isSelected = false;
        });
      }
    }
  }
}

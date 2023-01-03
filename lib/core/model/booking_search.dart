import 'package:app_shipper/screens/dashboard/tracking/components/box_selection.dart';

class BookingSearch {
  final List<BoxSelection> types;
  final List<BoxSelection> listStatus;
  final String sortBy;
  String? date;

  BookingSearch(this.types, this.listStatus, this.sortBy, {this.date});

  Map<String, dynamic> toJson() => {
        "types": types.map((e) => e.options).toList(),
        "status": listStatus.map((e) => e.options).toList(),
        "sortBy": sortBy,
        "date": date,
      };
}

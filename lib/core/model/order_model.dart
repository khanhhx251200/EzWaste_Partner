import 'package:app_shipper/core/model/order.dart';

class OrderModel {
  OrderModel({
    required this.id,
    required this.type,
    required this.time,
    required this.address,
    required this.status,
    required this.listItem,
    required this.userCreateBy,
    required this.userShipper,
  });

  int id;
  int type;
  int time;
  String address;
  int status;
  List<ListItem> listItem;
  String userCreateBy;
  String userShipper;

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    id: json["id"],
    type: json["type"],
    time: json["time"],
    address: json["address"] != null ? json['address'] : '',
    status: json["status"],
    listItem: json["listItem"] != null
        ? List<ListItem>.from(
        json["listItem"].map((x) => ListItem.fromJson(x)))
        : [],
    userCreateBy: json["userCreate"],
    userShipper: json["userShipper"],
  );

  Map<String, dynamic> toJson() => {
  "id": id,
  "type": type,
  "time": time,
  "address": address,
  "status": status,
  "listItem": listItem == null
  ? []
      : List<dynamic>.from(listItem.map((x) => x.toJson())),
  "userCreatBy": userCreateBy,
  "userShipper": userShipper,
  };
}

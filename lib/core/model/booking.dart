import 'package:app_shipper/core/model/item.dart';

/// dateBooking : 1669852800000
/// noteSeller : "ABC"
/// type : 2
/// address : "sô 0023"
/// status : 3
/// money : 13.0
/// mass : 5.0
/// nameSeller : "Hoàng Xuân Khánh"
/// phoneSeller : "0328962512"
/// nameShipper : "Đàm Mạnh Hòa"
/// phoneShipper : "0857112512"
/// feedback : null
/// reason : null
/// items : null

class Booking {
  Booking({
    int? id,
    int? dateBooking,
    int? idSeller,
    String? noteSeller,
    int? type,
    String? address,
    int? status,
    double? money,
    double? mass,
    String? nameSeller,
    String? phoneSeller,
    String? nameShipper,
    String? phoneShipper,
    dynamic feedback,
    dynamic reason,
    List<Item>? items,
  }) {
    _id = id;
    _dateBooking = dateBooking;
    _idSeller = idSeller;
    _noteSeller = noteSeller;
    _type = type;
    _address = address;
    _status = status;
    _money = money;
    _mass = mass;
    _nameSeller = nameSeller;
    _phoneSeller = phoneSeller;
    _nameShipper = nameShipper;
    _phoneShipper = phoneShipper;
    _feedback = feedback;
    _reason = reason;
    _items = items;
  }

  Booking.fromJson(dynamic json) {
    _id = json['id'];
    _dateBooking = json['dateBooking'];
    _idSeller = json['idSeller'];
    _noteSeller = json['noteSeller'];
    _type = json['type'];
    _address = json['address'];
    _status = json['status'];
    _money = json['money'];
    _mass = json['mass'];
    _nameSeller = json['nameSeller'];
    _phoneSeller = json['phoneSeller'];
    _nameShipper = json['nameShipper'];
    _phoneShipper = json['phoneShipper'];
    _feedback = json['feedback'];
    _reason = json['reason'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Item.fromJson(v));
      });
    }
  }

  int? _id;
  int? _dateBooking;
  int? _idSeller;
  String? _noteSeller;
  int? _type;
  String? _address;
  int? _status;
  double? _money;
  double? _mass;
  String? _nameSeller;
  String? _phoneSeller;
  String? _nameShipper;
  String? _phoneShipper;
  dynamic _feedback;
  dynamic _reason;
  List<Item>? _items;

  int? get id => _id;

  int? get dateBooking => _dateBooking;

  int? get idSeller => _idSeller;

  String? get noteSeller => _noteSeller;

  int? get type => _type;

  String? get address => _address;

  int? get status => _status;

  double? get money => _money;

  double? get mass => _mass;

  String? get nameSeller => _nameSeller;

  String? get phoneSeller => _phoneSeller;

  String? get nameShipper => _nameShipper;

  String? get phoneShipper => _phoneShipper;

  dynamic get feedback => _feedback;

  dynamic get reason => _reason;

  List<Item>? get items => _items;

  set setMass(double value) {
    _mass = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dateBooking'] = _dateBooking;
    map['idSeller'] = _idSeller;
    map['noteSeller'] = _noteSeller;
    map['address'] = _address;
    map['mass'] = _mass;
    map['money'] = 0;
    return map;
  }
}

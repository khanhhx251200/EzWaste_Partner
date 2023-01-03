/// id : 3
/// active : true
/// createDate : null
/// updateDate : 1671805409708
/// createBy : null
/// updateBy : 13
/// clientId : 1
/// url : null
/// mass : 28.0
/// money : 100.0
/// scores : null
/// name : "logo-congan"
/// intoMoney : 2800.0

class Item {
  Item({
    int? id,
    bool? active,
    dynamic createDate,
    int? updateDate,
    dynamic createBy,
    int? updateBy,
    int? clientId,
    dynamic url,
    double? mass,
    double? money,
    dynamic scores,
    String? name,
    double? intoMoney,
  }) {
    _id = id;
    _active = active;
    _createDate = createDate;
    _updateDate = updateDate;
    _createBy = createBy;
    _updateBy = updateBy;
    _clientId = clientId;
    _url = url;
    _mass = mass;
    _money = money;
    _scores = scores;
    _name = name;
    _intoMoney = intoMoney;
  }

  Item.fromJson(dynamic json) {
    _id = json['id'];
    _active = json['active'];
    _createDate = json['createDate'];
    _updateDate = json['updateDate'];
    _createBy = json['createBy'];
    _updateBy = json['updateBy'];
    _clientId = json['clientId'];
    _url = json['url'];
    _mass = json['mass'];
    _money = json['money'];
    _scores = json['scores'];
    _name = json['name'];
    _intoMoney = json['intoMoney'];
  }

  int? _id;
  bool? _active;
  dynamic _createDate;
  int? _updateDate;
  dynamic _createBy;
  int? _updateBy;
  int? _clientId;
  dynamic _url;
  double? _mass;
  double? _money;
  dynamic _scores;
  String? _name;
  double? _intoMoney;

  int? get id => _id;

  bool? get active => _active;

  dynamic get createDate => _createDate;

  int? get updateDate => _updateDate;

  dynamic get createBy => _createBy;

  int? get updateBy => _updateBy;

  int? get clientId => _clientId;

  dynamic get url => _url;

  double? get mass => _mass;

  double? get money => _money;

  dynamic get scores => _scores;

  String? get name => _name;

  double? get intoMoney => _intoMoney;

  set setMass(double? mass) {
    _mass = mass;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['active'] = _active;
    map['createDate'] = _createDate;
    map['updateDate'] = _updateDate;
    map['createBy'] = _createBy;
    map['updateBy'] = _updateBy;
    map['clientId'] = _clientId;
    map['url'] = _url;
    map['mass'] = _mass;
    map['money'] = _money;
    map['scores'] = _scores;
    map['name'] = _name;
    map['intoMoney'] = _intoMoney;
    return map;
  }
}

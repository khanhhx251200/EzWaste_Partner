class Order {
  Order({
    required this.id,
    required this.idCreate,
    required this.type,
    required this.time,
    required this.createDate,
    required this.updateDate,
    required this.address,
    required this.status,
    required this.listItem,
    required this.userCreate,
    required this.userCreateType,
    required this.userShipper,
    required this.userCreateFullName,
    required this.userShipperFullName,
    required this.mass,
    required this.money,
  });

  int? id;
  int idCreate;
  int type;
  int time;
  int createDate;
  int updateDate;
  String address;
  int status;
  List<ListItem> listItem;
  String userCreate;
  String userCreateType;
  String userShipper;
  String userCreateFullName;
  String userShipperFullName;
  double mass;
  double money;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"] ?? -1,
    idCreate: json["idCreate"] ?? -1,
    type: json["type"],
    time: json["time"] ?? -1,
    createDate: json["createDate"] ?? -1,
    updateDate: json["updateDate"] ?? -1,
    address: json["address"] != null ? json['address'] : '',
    userCreateType: json["userCreateType"] != null ? json['userCreateType'] : '',
    status: json["status"],
    listItem: json["listItem"] != null
        ? List<ListItem>.from(
        json["listItem"].map((x) => ListItem.fromJson(x)))
        : [],
    userCreate: json["userCreate"],
    userShipper: json["userShipper"],
    userCreateFullName: json["userCreateFullName"],
    userShipperFullName: json["userShipperFullName"],
    mass: json["mass"] != null ? json["mass"] : 0,
    money: json["money"] != null ? json["money"] : 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "time": time,
    "address": address,
    "status": status,
    "listItem": listItem.isEmpty
        ? null
        : List<ListItem>.from(listItem.map((x) => x.toJson())),
    "userCreate": userCreate,
    "userShipper": userShipper,
  };
}

class ItemData {
  ItemData({
    required this.id,
    required this.active,
    required this.createDate,
    required this.updateDate,
    required this.createBy,
    required this.updateBy,
    required this.clientId,
    required this.type,
    required this.time,
    required this.address,
    required this.status,
    required this.idShipper,
    required this.listItem,
    required this.statusSchedule,
    required this.userCreatBy,
    required this.userShipper,
  });

  int id;
  bool active;
  int createDate;
  int updateDate;
  int createBy;
  int updateBy;
  int clientId;
  int type;
  int time;
  String address;
  int status;
  int idShipper;
  List<ListItem> listItem;
  String statusSchedule;
  User? userCreatBy;
  User? userShipper;

  factory ItemData.fromJson(Map<String, dynamic> json) => ItemData(
        id: json["id"],
        active: json["active"],
        createDate: json["createDate"],
        updateDate: json["updateDate"],
        createBy: json["createBy"],
        updateBy: json["updateBy"],
        clientId: json["clientId"],
        type: json["type"],
        time: json["time"],
        address: json["address"] != null ? json['address'] : '',
        status: json["status"],
        idShipper: json["idShipper"] ?? 0,
        listItem: json["listItem"] != null ? List<ListItem>.from(
                json["listItem"].map((x) => ListItem.fromJson(x))) : [],
        statusSchedule: json["statusSchedule"] != null ? json["statusSchedule"] : '',
        userCreatBy: User.fromJson(json["userCreatBy"]),
        userShipper: json["userShipper"] != null ? User.fromJson(json["userShipper"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "active": active,
        "createDate": createDate,
        "updateDate": updateDate,
        "createBy": createBy,
        "updateBy": updateBy,
        "clientId": clientId,
        "type": type,
        "time": time,
        "address": address,
        "status": status,
        "idShipper": idShipper == null ? null : idShipper,
        "listItem": listItem,
      };
}

class ListItem {
  ListItem({
    required this.id,
    required this.active,
    required this.createDate,
    required this.updateDate,
    required this.createBy,
    required this.updateBy,
    required this.clientId,
    required this.idOrders,
    required this.idItems,
    required this.idItemsModel,
    required this.khoiluong,
  });

  int id;
  bool active;
  int createDate;
  int updateDate;
  int createBy;
  int updateBy;
  int clientId;
  int idOrders;
  int idItems;
  IdItemsModel idItemsModel;
  double khoiluong;

  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
        id: json["id"] == null ? null : json["id"],
        active: json["active"] == null ? null : json["active"],
        createDate: json["createDate"] == null ? null : json["createDate"],
        updateDate: json["updateDate"] == null ? null : json["updateDate"],
        createBy: json["createBy"] == null ? null : json["createBy"],
        updateBy: json["updateBy"] == null ? null : json["updateBy"],
        clientId: json["clientId"] == null ? null : json["clientId"],
        idOrders: json["idOrders"] == null ? null : json["idOrders"],
        idItems: json["idItems"] == null ? null : json["idItems"],
        idItemsModel:  IdItemsModel.fromJson(json["idItemsModel"]),
        khoiluong:
            json["khoiluong"] == null ? null : json["khoiluong"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "active": active == null ? null : active,
        "createDate": createDate == null ? null : createDate,
        "updateDate": updateDate == null ? null : updateDate,
        "createBy": createBy == null ? null : createBy,
        "updateBy": updateBy == null ? null : updateBy,
        "clientId": clientId == null ? null : clientId,
        "idOrders": idOrders == null ? null : idOrders,
        "idItems": idItems == null ? null : idItems,
        "idItemsModel": idItemsModel == null ? null : idItemsModel.toJson(),
        "khoiluong": khoiluong == null ? null : khoiluong,
      };
}

class IdItemsModel {
  IdItemsModel({
    required this.id,
    required this.active,
    required this.createDate,
    required this.updateDate,
    required this.createBy,
    required this.updateBy,
    required this.clientId,
    required this.url,
    required this.mass,
    required this.money,
    required this.name,
  });

  int id;
  bool active;
  int createDate;
  int updateDate;
  int createBy;
  int updateBy;
  int clientId;
  String url;
  double mass;
  double money;
  String name;

  factory IdItemsModel.fromJson(Map<String, dynamic> json) => IdItemsModel(
        id: json["id"] == null ? null : json["id"],
        active: json["active"] == null ? null : json["active"],
        createDate: json["createDate"] == null ? null : json["createDate"],
        updateDate: json["updateDate"] == null ? null : json["updateDate"],
        createBy: json["createBy"] == null ? null : json["createBy"],
        updateBy: json["updateBy"] == null ? null : json["updateBy"],
        clientId: json["clientId"] == null ? null : json["clientId"],
        url: json["url"] == null ? null : json["url"],
        mass: json["mass"] == null ? null : json["mass"],
        money: json["money"] == null ? null : json["money"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "active": active == null ? null : active,
        "createDate": createDate == null ? null : createDate,
        "updateDate": updateDate == null ? null : updateDate,
        "createBy": createBy == null ? null : createBy,
        "updateBy": updateBy == null ? null : updateBy,
        "clientId": clientId == null ? null : clientId,
        "url": url == null ? null : url,
        "mass": mass == null ? null : mass,
        "money": money == null ? null : money,
        "name": name == null ? null : name,
      };
}

class User {
  User({
    required this.id,
    required this.active,
    required this.clientId,
    this.fullName,
    required this.userName,
    this.passwordnew,
    this.birthday,
    this.email,
    this.gender,
    this.indentity,
    this.title,
    this.photo,
    this.signature,
    this.phoneCaProvider,
    this.employeeId,
    required this.isSeller,
    required this.moneySeller,
    required this.khoiluongShipper,
    this.roles,
    this.authorize,
    this.position,
    this.groupId,
    this.address,
  });

  int id;
  bool active;
  int clientId;
  dynamic fullName;
  String userName;
  dynamic passwordnew;
  dynamic birthday;
  dynamic email;
  dynamic gender;
  dynamic indentity;
  dynamic title;
  dynamic photo;
  dynamic signature;
  dynamic phoneCaProvider;
  dynamic employeeId;
  bool isSeller;
  double moneySeller;
  double khoiluongShipper;
  dynamic roles;
  dynamic authorize;
  dynamic position;
  dynamic groupId;
  dynamic address;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        active: json["active"] == null ? null : json["active"],
        clientId: json["clientId"] == null ? null : json["clientId"],
        fullName: json["fullName"],
        userName: json["userName"] == null ? null : json["userName"],
        passwordnew: json["passwordnew"],
        birthday: json["birthday"],
        email: json["email"],
        gender: json["gender"],
        indentity: json["indentity"],
        title: json["title"],
        photo: json["photo"],
        signature: json["signature"],
        phoneCaProvider: json["phoneCAProvider"],
        employeeId: json["employeeId"],
        isSeller: json["isSeller"] == null ? null : json["isSeller"],
        moneySeller: json["moneySeller"] == null ? null : json["moneySeller"],
        khoiluongShipper: json["khoiluongShipper"] == null
            ? null
            : json["khoiluongShipper"].toDouble(),
        roles: json["roles"],
        authorize: json["authorize"],
        position: json["position"],
        groupId: json["groupId"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "active": active == null ? null : active,
        "clientId": clientId == null ? null : clientId,
        "fullName": fullName,
        "userName": userName == null ? null : userName,
        "passwordnew": passwordnew,
        "birthday": birthday,
        "email": email,
        "gender": gender,
        "indentity": indentity,
        "title": title,
        "photo": photo,
        "signature": signature,
        "phoneCAProvider": phoneCaProvider,
        "employeeId": employeeId,
        "isSeller": isSeller == null ? null : isSeller,
        "moneySeller": moneySeller == null ? null : moneySeller,
        "khoiluongShipper": khoiluongShipper == null ? null : khoiluongShipper,
        "roles": roles,
        "authorize": authorize,
        "position": position,
        "groupId": groupId,
        "address": address,
      };
}





class ElectronicScale {
  final String deviceId;
  final String name;
   double value;

  ElectronicScale(this.deviceId, this.name, this.value);

  factory ElectronicScale.fromJson(Map<String, dynamic> json) =>
      ElectronicScale(
        json["device_id"],
        json["name"],
        double.parse(json['value']),
      );
}

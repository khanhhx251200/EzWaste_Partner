class UserDto {
  final int id;
  final String fullName;
  final String userName;
  final String address;

  UserDto(this.id, this.fullName, this.userName, this.address);

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      UserDto(
        json["id"],
        json["fullName"],
        json["userName"],
        json["address"],
      );
}
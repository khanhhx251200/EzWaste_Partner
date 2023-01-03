class Leaderboard{
  late final String imageUrl;
  late final String fullName;
  late final int topRank;
  late final double total;

  Leaderboard({required this.fullName, required this.topRank, required this.total});

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
    fullName: json["fullName"],
    topRank: json["rating"],
    total: json["khoiluongShipper"],
  );
}
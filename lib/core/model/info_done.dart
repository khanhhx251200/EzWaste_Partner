class InfoDone {
  final double organic;
  final double plastic;

  InfoDone(this.organic, this.plastic);

  factory InfoDone.fromJson(Map<String, dynamic> json) =>
      InfoDone(
          json["organic"],
          json["plastic"],
      );
}
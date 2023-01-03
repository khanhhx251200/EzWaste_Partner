import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/model/leaderboard.dart';
import 'package:app_shipper/screens/learderboard/provider/leaderboard_provider.dart';
import 'package:app_shipper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Body extends StatefulWidget {
  const Body({Key? key, required this.type}) : super(key: key);
  final int type;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          context.read<LeaderBoardProvider>().listLeaderBoard.length > 0 ? buildHeader(_size) : SizedBox(),
          SizedBox(height: getProportionateScreenHeight(size8)),
          context.read<LeaderBoardProvider>().listLeaderBoard.length > 3 ? Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: context.read<LeaderBoardProvider>().listLeaderBoard.length - 3,
              itemBuilder: (context, index) {
                final user = context.read<LeaderBoardProvider>().listLeaderBoard[index + 3];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  )),
                  color: bgColor,
                  child: ListTile(
                    title: Text(user.fullName),
                    trailing: Text("${user.total}kg"),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            index % 2 == 0
                                ? Icon(Icons.arrow_drop_up,
                                color: kSuccessColor)
                                : Icon(Icons.arrow_drop_down,
                                color: kErrorColor),
                            Text("${index + 4}"),
                          ],
                        ),
                        SizedBox(
                            width: getProportionateScreenWidth(size8)),
                        CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/user_empty.png"),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ) : Center(
            child: Text("Không có dữ liệu"),
          ),
        ],
      ),
    );
  }

  Container buildHeader(Size _size) {
    return Container(
      height: _size.height * 0.3,
      width: _size.width,
      padding: EdgeInsets.symmetric(vertical: 32, horizontal: size14),
      decoration: BoxDecoration(
          color: context.read<LeaderBoardProvider>().currentColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          context.read<LeaderBoardProvider>().listLeaderBoard.length >= 2 ? Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: size14),
            child: buildRankTop(context.read<LeaderBoardProvider>().listLeaderBoard[1]),
          )) : SizedBox(),
          context.read<LeaderBoardProvider>().listLeaderBoard.length >= 1 ? Expanded(
              child: buildRankTop(context.read<LeaderBoardProvider>().listLeaderBoard[0])) : SizedBox(),
          context.read<LeaderBoardProvider>().listLeaderBoard.length >= 3 ? Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: size14 * 1.6),
            child: buildRankTop(context.read<LeaderBoardProvider>().listLeaderBoard[2]),
          )) : SizedBox(),
        ],
      ),
    );
  }

  Widget buildRankTop(Leaderboard leaderboard) {
    double parentRadius = 75;
    double childRadius = 65;

    return GestureDetector(
      child: SizedBox(
        height: 105 - (leaderboard.topRank * 12),
        width: 95 - (leaderboard.topRank * 12),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Hero(
              tag: leaderboard.topRank.toStringAsFixed(0),
              child: CircleAvatar(
                radius: parentRadius,
                backgroundColor: kWhiteColor,
                child: CircleAvatar(
                  radius: childRadius,
                  backgroundImage: AssetImage("assets/images/user_empty.png"),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -32,
              child: Center(
                child: Text(
                  '${leaderboard.fullName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kWhiteColor, fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: -64,
              child: Center(
                child: Text(
                  '${leaderboard.total}Kg',
                  textAlign: TextAlign.center,
                  style: styleNameRank(),
                ),
              ),
            ),
            Positioned(
              right: 0,
              left: 0,
              top: getTopSize(leaderboard.topRank),
              child: SizedBox(
                height: getHeightRank(leaderboard.topRank),
                child: getMetal(leaderboard.topRank),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getMetal(int topRank) {
    if (topRank == 1) {
      return Image.asset("assets/images/crown.png");
    } else if (topRank == 2) {
      return Image.asset(
        "assets/images/silver-cup.png",
      );
    } else if (topRank == 3) {
      return Image.asset(
        "assets/images/bronze_cup.png",
      );
    } else {
      return Image.asset("assets/images/crown.png");
    }
  }

  getAvatarTop(int topRank) {
    if (topRank == 1) {
      return Image.asset("assets/images/crown.png");
    } else if (topRank == 2) {
      return Image.asset(
        "assets/images/silver-cup.png",
      );
    } else if (topRank == 3) {
      return Image.asset(
        "assets/images/bronze_cup.png",
      );
    }
  }

  double getHeightRank(int topRank) {
    if (topRank == 1) {
      return 46.0;
    } else if (topRank == 2) {
      return size32;
    } else if (topRank == 3) {
      return 28.0;
    } else {
      return 0;
    }
  }

  double getTopSize(int topRank) {
    if (topRank == 1) {
      return -size36;
    } else if (topRank == 2) {
      return -size32;
    } else if (topRank == 3) {
      return -28.0;
    } else {
      return 0;
    }
  }

  TextStyle styleNameRank() {
    return TextStyle(color: kWhiteColor, fontSize: 13);
  }
}

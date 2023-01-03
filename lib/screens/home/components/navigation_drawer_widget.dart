import 'package:app_shipper/core/auth_provider.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/learderboard/leaderboard_screen.dart';
import 'package:app_shipper/screens/sign_in/sign_in_screen.dart';
import 'package:app_shipper/services/share_preferences_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';
class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const urlImage = "assets/images/user_empty.png";

    return Drawer(
      child: Material(
        color: kPrimaryColor,
        child: ListView(
          children: [
            buildHeader(
                urlImage: urlImage,
                name: context.read<AuthProvider>().userInfo!.fullName,
                phone: context.read<AuthProvider>().userInfo!.userName,
                onClicked: () {}),
            Container(
              padding: padding,
              child: Column(
                children: [
                  // buildMenuItem(
                  //     text: 'Đã hoàn thành',
                  //     icon: Icons.done_all,
                  //     onClicked: () {}),
                  // buildMenuItem(
                  //     text: 'Thi đua',
                  //     icon: Icons.emoji_events_sharp,
                  //     onClicked: () {
                  //       Navigator.pushNamed(context, LeaderboardScreen.routeName);
                  //     }),
                  buildMenuItem(
                      text: kLogOut,
                      icon: Icons.logout,
                      onClicked: () => _openSignOutDrawer(context)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => PeoplePage(),
        // ));
        break;
      case 1:
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => FavouritesPage(),
        // ));
        break;
    }
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String phone,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Row(
            children: [
              const SizedBox(width: 20),
              CircleAvatar(radius: 30, backgroundImage: AssetImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    phone,
                    style: const TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  void _openSignOutDrawer(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: kPrimaryColor,
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.only(
              top: size8,
              bottom: 0,
              left: 24,
              right: 24,
            ),
            height: getProportionateScreenHeight(150),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: context.read<AuthProvider>().userInfo!.fullName,
                          style: TextStyle(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              fontSize: size18,
                              fontWeight: FontWeight.w600)),
                      TextSpan(
                        text: ", bạn có chắc chắn muốn đăng xuất không?",
                        style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: size16,
                            fontWeight: FontWeight.w300),
                      )
                    ])),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          logout(context);
                        },
                        color: Colors.white,
                        child: const Text(
                          kLogOut,
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: getProportionateScreenWidth(size20)),
                    Expanded(
                      child: OutlineButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        borderSide: BorderSide(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        color: Theme.of(context).primaryColor,
                        child: Text(
                          "Ở lại",
                          style: TextStyle(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  logout(context) async {
    final _pref = PreferencesService();
    await _pref.logout();
    Navigator.of(context).pushNamedAndRemoveUntil(
        SignInScreen.routeName, (Route<dynamic> route) => false);
  }

}

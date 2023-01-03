import 'package:app_shipper/core/auth_provider.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/model/login_response.dart';
import 'package:app_shipper/screens/home/components/item_working.dart';
import 'package:app_shipper/screens/home/components/list_complete.dart';
import 'package:app_shipper/screens/home/components/list_order_organic.dart';
import 'package:app_shipper/screens/home/components/list_order_plastic.dart';
import 'package:app_shipper/screens/home/components/list_received.dart';
import 'package:app_shipper/screens/home/components/list_worked.dart';
import 'package:app_shipper/screens/home/components/navigation_drawer_widget.dart';
import 'package:app_shipper/screens/home/provider/home_provider.dart';
import 'package:app_shipper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import 'components/list_next_dates.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with
        AutomaticKeepAliveClientMixin<HomeScreen>,
        SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isSwitched = false;
  final globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    isSwitched = Provider.of<AuthProvider>(context, listen: false).isActive;
    Provider.of<HomeProvider>(context, listen: false).getListWoking();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          key: globalKey,
          drawer: const NavigationDrawerWidget(),
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            elevation: size8,
            backgroundColor: kWhiteColor,
            leading: IconButton(
              icon: const Icon(
                Icons.menu,
                color: kPrimaryColor,
                size: 32,
              ),
              onPressed: () {
                globalKey.currentState!.openDrawer();
              },
            ),
            centerTitle: false,
            title: Text(
                context.read<AuthProvider>().userInfo!.fullName ?? '',
                style: const TextStyle(
                    color: kFourLightColor, fontWeight: FontWeight.bold)),
            actions: [
              // FlutterSwitch(
              //   width: 72.0,
              //   height: 32.0,
              //   valueFontSize: 14.0,
              //   value: isSwitched,
              //   borderRadius: 32.0,
              //   showOnOff: true,
              //   activeColor: kPrimaryLightColor,
              //   activeText: 'Bật',
              //   inactiveText: 'Tắt',
              //   onToggle: (val) {
              //     setState(() {
              //       isSwitched = context.read<AuthProvider>().changeActive(val);
              //       if (!isSwitched) {
              //         provider.setIsWorking(false);
              //       }
              //     });
              //   },
              // ),
              IconButton(
                  onPressed: () => showDialogWallet(provider),
                  icon: const Icon(
                    Icons.account_balance_wallet_outlined,
                    color: kFourLightColor,
                    size: 32,
                  ))
            ],
          ),
          body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(size8),
                child: Text.rich(TextSpan(text: 'Khu vực thu gom: ', children: [
                  TextSpan(
                      text: context.read<AuthProvider>().userInfo!.tenKhuVuc,
                      style: const TextStyle(
                          fontSize: size20,
                          fontWeight: FontWeight.bold,
                          color: kSuccessColor))
                ])),
              ),
              // isSwitched && provider.listWorking.isNotEmpty
              //     ? ItemWorking(item: provider.listWorking[0])
              //     : const SizedBox(),
              isSwitched
                  ? TabBar(
                      indicatorColor: kPrimaryColor,
                      unselectedLabelColor: kNoSelectTextnColor,
                      labelColor: kPrimaryColor,
                      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                      tabs: const [
                        Tab(
                          text: 'Lịch thu gom',
                        ),
                        Tab(
                          text: 'Đã thu gom',
                        ),
                        Tab(
                          text: 'Đã hoàn thành',
                        ),
                      ],
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    )
                  : const SizedBox(),
              Expanded(
                  child: isSwitched
                      ? TabBarView(
                          controller: _tabController,
                          children: [
                            Column(
                              children: [
                                ListNextDates(provider: provider),
                                Expanded(child:  provider.currentDateSelect.weekday == 1 || provider.currentDateSelect.weekday == 3
                                    || provider.currentDateSelect.weekday == 5 || provider.currentDateSelect.weekday == 7
                                      ? const ListOrderPlastic()
                                      : const ListOrderOrganic()),
                              ],
                            ),
                            ListWorked(provider: provider),
                            ListComplete(provider: provider),
                          ],
                        )
                      : const Center(
                          child: Text('Bạn đang không hoạt động'),
                        ))
            ],
          )),
        );
      },
    );
  }

  showDialogWallet(HomeProvider provider) async {
    UserInfo? userInfo = context.read<AuthProvider>().userInfo;
    await showGeneralDialog(
        context: context,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Align(
              alignment: Alignment.topCenter,
              child: Card(
                margin: const EdgeInsets.only(top: 120),
                elevation: 24,
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.all(size8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircleAvatar(
                          radius: 54,
                          backgroundImage:
                              AssetImage('assets/images/user_empty.png'),
                        ),
                        SizedBox(
                            height: getProportionateScreenHeight(size14)),
                        Text(
                          userInfo!.fullName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                            height:
                                getProportionateScreenHeight(size8)),
                        Text(
                          userInfo.userName,
                          style: const TextStyle(),
                        ),
                        SizedBox(
                            height: getProportionateScreenHeight(size14)),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Khối lượng (kg)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(
                                          size8)),
                                  Text(
                                    userInfo
                                        .khoiluongShipper
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const VerticalDivider(
                              color: Colors.black,
                              thickness: 2,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Giới tính",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: kPrimaryColor),
                                  ),
                                  SizedBox(
                                      height: getProportionateScreenHeight(
                                          size8)),
                                  Text(
                                    userInfo.gender == 1 ? 'Nam' : 'Nữ',
                                    style:
                                        const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ));
        },
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierDismissible: true,
        barrierColor: Colors.transparent,
        transitionDuration: const Duration(milliseconds: 450));
  }

  @override
  bool get wantKeepAlive => true;
}

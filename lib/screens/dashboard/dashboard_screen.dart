import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/dashboard/activities/activities_page.dart';
import 'package:app_shipper/screens/dashboard/create_order/create_order_page.dart';
import 'package:app_shipper/screens/dashboard/home/home_page.dart';
import 'package:app_shipper/screens/dashboard/tracking/tracking_page.dart';
import 'package:app_shipper/screens/home/components/navigation_drawer_widget.dart';
import 'package:flutter/material.dart';

import 'components/appbar_dashboard.dart';

class DashBoardScreen extends StatefulWidget {
  static const String routeName = "/dashboard";

  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}
final globalDashboardKey = GlobalKey<ScaffoldState>();

class _DashBoardScreenState extends State<DashBoardScreen> {
  final double heightAppBar = 60;
  int currentTabs = 0;
  Widget? currentPage;
  final PageStorageBucket _bucket = PageStorageBucket();

  List<Widget> pages =  const [
    HomePage(),
    CreateOrderPage(),
    TrackingPage(),
    ActivitiesPage(),
  ];

  @override
  void initState() {
    super.initState();
    currentPage = pages[0];
  }

  onTapHandler(int index) {
    setState(() {
      currentTabs = index;
      currentPage = pages[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    Color colorUnselected = Colors.grey.withOpacity(0.75);
    return Scaffold(
      key: globalDashboardKey,
      drawer: const NavigationDrawerWidget(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(heightAppBar),
          child: const AppbarDashboard()),
      body: PageStorage(bucket: _bucket, child: currentPage!),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 4,
        backgroundColor: colorUnselected,
        selectedIconTheme: const IconThemeData(color: kGreenColor, size: 32),
        selectedLabelStyle:
            const TextStyle(color: kGreenColor, fontWeight: FontWeight.bold),
        selectedItemColor: kGreenColor,
        unselectedItemColor: colorUnselected,
        unselectedLabelStyle: TextStyle(color: colorUnselected),
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.view_quilt,
            ),
            label: kHome,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wysiwyg),
            label: kCreateOrder,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timelapse),
            label: kFollow,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart),
            label: kChart,
          ),
        ],
        onTap: onTapHandler,
        currentIndex: currentTabs,
      ),
    );
  }
}

import 'package:app_shipper/components/decoration_border_shadow.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/screens/dashboard/home/provider/home_page_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

class FilterBooking extends StatefulWidget {
  const FilterBooking({Key? key}) : super(key: key);

  @override
  _FilterBookingState createState() => _FilterBookingState();
}

class _FilterBookingState extends State<FilterBooking>
    with
        AutomaticKeepAliveClientMixin<FilterBooking>,
        TickerProviderStateMixin {
  late TabController _tabController;
  int tabIndex = DateTime.now().weekday % 2 == 0 ? 0 : 1;

  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;

  final currentDate = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  checkTimeSelected() {
    print('weekday: ' + (currentDate.weekday % 2 == 0).toString());
    if (currentDate.weekday % 2 != 0) {
      setState(() {
        tabIndex == 1;
      });
    }
    Provider.of<HomePageProvider>(context, listen: false)
        .setDateSelect(_selectedDay);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: tabIndex);
    initializeDateFormatting();

    checkTimeSelected();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(size20),
      decoration: boxDecorationShadow(),
      child: Column(
        children: [
          TabBar(
              indicatorColor: colorByTabIndex(),
              unselectedLabelColor: kNoSelectTextnColor,
              labelColor: colorByTabIndex(),
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              onTap: (value) => setState(() {
                    final provider =
                        Provider.of<HomePageProvider>(context, listen: false);
                    tabIndex = value;
                    provider.setListBooking([]);
                  }),
              tabs: const [
                Tab(
                  text: 'Rác sinh hoạt',
                ),
                Tab(
                  text: 'Rác tái chế',
                ),
              ]),
          Builder(builder: (BuildContext context) {
            return buildTableCalendar();
          }),
        ],
      ),
    );
  }

  TableCalendar<dynamic> buildTableCalendar() {
    return TableCalendar(
      currentDay: currentDate,
      locale: 'vi-VN',
      firstDay: currentDate,
      lastDay: DateTime(currentDate.year + 5),
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarFormat: _calendarFormat,
      onFormatChanged: (CalendarFormat format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      focusedDay: _focusedDay,
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },

      enabledDayPredicate: (DateTime date) {
        if (tabIndex == 0) {
          return date.weekday % 2 == 0;
        }
        return date.weekday % 2 != 0;
      },

      //Day change
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
        Provider.of<HomePageProvider>(context, listen: false)
            .setDateSelect(_selectedDay, isLoadList: true);
      },
      selectedDayPredicate: (DateTime date) {
        return isSameDay(_selectedDay, date);
      },

      //To style the calendar
      calendarStyle: CalendarStyle(
          isTodayHighlighted: true,
          selectedDecoration:
              BoxDecoration(color: colorByTabIndex(), shape: BoxShape.circle),
          todayDecoration: const BoxDecoration(
              color: kSecondaryTextColor, shape: BoxShape.circle)),
      daysOfWeekStyle: const DaysOfWeekStyle(
          weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
          weekendStyle: TextStyle(fontWeight: FontWeight.bold)),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        formatButtonTextStyle: const TextStyle(color: kGreenColor),
        titleTextStyle: TextStyle(
            color: colorByTabIndex(),
            fontWeight: FontWeight.bold,
            fontSize: size16),
      ),
    );
  }

  Color colorByTabIndex() => tabIndex == 0 ? kOrganicColor : kPlasticColor;

  @override
  bool get wantKeepAlive => true;
}

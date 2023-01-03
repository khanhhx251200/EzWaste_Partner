import 'package:app_shipper/components/decoration_border_shadow.dart';
import 'package:app_shipper/components/default_button.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/core/constants/strings_constant.dart';
import 'package:app_shipper/screens/dashboard/activities/provider/activities_provider.dart';
import 'package:app_shipper/screens/dashboard/components/title_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';

class FilterCalendar extends StatefulWidget {
  static const String routeName = '/filter_calendar';

  const FilterCalendar({Key? key}) : super(key: key);

  @override
  _FilterCalendarState createState() => _FilterCalendarState();
}

class _FilterCalendarState extends State<FilterCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  final DateTime currentDate = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          kFilterTime,
          style: TextStyle(fontWeight: FontWeight.w700, color: kBlackColor),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          const TitlePage(title: 'Chọn khoảng thời gian theo dõi'),
          Container(
            margin: const EdgeInsets.all(size24),
            decoration: boxDecorationShadow(),
            child: calendarFilter(),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: size24),
            child: DefaultButton(
              text: kApply,
              color: kGreenColor,
              press: () => Navigator.pop(context, true),
            ),
          )
        ],
      )),
    );
  }

  TableCalendar<dynamic> calendarFilter() {
    final provider = Provider.of<ActivitiesProvider>(context, listen: false);

    return TableCalendar(
            currentDay: currentDate,
            locale: 'vi-VN',
            startingDayOfWeek: StartingDayOfWeek.monday,
            firstDay: DateTime(currentDate.year - 10),
            lastDay: DateTime(currentDate.year + 5),
            focusedDay: _focusedDay,
            selectedDayPredicate: (DateTime date) =>
                isSameDay(_selectedDay, date),
            rangeStartDay: provider.rangeStart,
            rangeEndDay: provider.rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,

            //Day change
            // onDaySelected: (DateTime selectedDay, DateTime focusedDay) =>
            //     onDaySelected(selectedDay, focusedDay),
            onRangeSelected: (start, end, focusedDay) =>
                onRangeSelected(focusedDay, start, end),
            onFormatChanged: (CalendarFormat format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            //To style the calendar
            calendarStyle: CalendarStyle(
                isTodayHighlighted: true,
                selectedDecoration: const BoxDecoration(
                    color: kGreenColor, shape: BoxShape.circle),
                rangeHighlightColor: kGreenColor.withOpacity(0.3),
                rangeStartDecoration: const BoxDecoration(
                    color: kGreenColor, shape: BoxShape.circle),
                rangeEndDecoration: const BoxDecoration(
                    color: kGreenColor, shape: BoxShape.circle),
                todayDecoration: const BoxDecoration(
                    color: kSecondaryTextColor, shape: BoxShape.circle)),
            daysOfWeekStyle: const DaysOfWeekStyle(
                weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                weekendStyle: TextStyle(fontWeight: FontWeight.bold)),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                  color: kGreenColor,
                  fontWeight: FontWeight.bold,
                  fontSize: size16),
            ),
          );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final provider = Provider.of<ActivitiesProvider>(context, listen: false);
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        provider.setRangeStart(null);
        _rangeEnd = null;
        provider.setRangeEnd(null);
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
    }
  }

  void onRangeSelected(DateTime focusedDay, DateTime? start, DateTime? end) {
    final provider = Provider.of<ActivitiesProvider>(context, listen: false);

    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      provider.setRangeStart(_rangeStart);
      _rangeEnd = end;
      provider.setRangeEnd(_rangeEnd);
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });
  }
}

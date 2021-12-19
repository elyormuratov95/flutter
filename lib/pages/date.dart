
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class DatePage extends StatefulWidget {
  void onDateSelect(DateTime date) {
//    print("Selected: ${date}");
  }

  _DatePageState createState() {
    return _DatePageState(onDateSelected: onDateSelect);
  }
}

class _DatePageState extends State<DatePage> {
  Function onDateSelected;
  DateTime _selectedDateRange = DateTime.now();
  DateTime? _selectedDate = null;
  int? _selectedIndex = null;
  List<Widget> _days = [];

  _DatePageState({required this.onDateSelected});

  initState() {
    _days = _renderDays();
    super.initState();
  }

  Widget _renderDay(DateTime date) {
    var newFormat = DateFormat("E");
    String weekdayName = newFormat.format(date);
    bool selected = false;
    if (_selectedDate != null) {
      selected = _selectedDate!.isAtSameMomentAs(date);
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Container(
          decoration: selected ? BoxDecoration(borderRadius: BorderRadius.circular(3), color: Color.fromRGBO(0, 167, 149, 1)) : null,
          child: SizedBox(
              width: 40,
              child: Column(children: [
                Padding(child: Text(weekdayName.substring(0, 2), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)), padding: EdgeInsets.only(bottom: 10)),
                Text(date.day.toString(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 14)),
                SizedBox(
                  width: 15,
                  child: Divider(color: Colors.white, height: 8),
                  height: 8,
                )
              ]))),
      onTap: () {
        this.setState(() {
          _selectedDate = date;
          _days = _renderDays();
          this.onDateSelected(date);
        });
      },
    );
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  List<Widget> _renderDays() {
    var start = getDate(_selectedDateRange.subtract(Duration(days: _selectedDateRange.weekday - 1)));

    List<Widget> _days = [];
    for (int i = 0; i < 6; i++) {
      if (start.weekday == 7) {
        continue;
      }

      _days.add(_renderDay(start));
      start = start.add(Duration(days: 1));
    }

    return _days;
  }

  @override
  Widget build(BuildContext context) {
    var newFormat = DateFormat("MMMM d");
    String weekdayName = "";
    if (_selectedDate == null) {
      weekdayName = newFormat.format(_selectedDateRange);
    } else {
      weekdayName = newFormat.format(_selectedDate!);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("App"),
        actions: [],
      ),
      body: Row(children: [
        Expanded(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.22,
              color: Colors.black,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text(weekdayName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
                      Row(children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                          onPressed: () {
                            DateTime d = getDate(_selectedDateRange.subtract(Duration(days: _selectedDateRange.weekday - 1)));
                            d = d.subtract(Duration(days: 7));
                            this.setState(() {
                              _selectedDateRange = d;
                              _selectedDate = null;
                              _days = _renderDays();
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                          onPressed: () {
                            DateTime d = getDate(_selectedDateRange.add(Duration(days: DateTime.daysPerWeek - _selectedDateRange.weekday)));
                            d = d.add(Duration(days: 1));
                            this.setState(() {
                              _selectedDateRange = d;
                              _selectedDate = null;
                              _days = _renderDays();
                            });
                          },
                        )
                      ])
                    ]),
                    Padding(padding: EdgeInsets.all(10), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: _days))
                  ],
                ),
              )),
        )
      ]),
    );
  }
}

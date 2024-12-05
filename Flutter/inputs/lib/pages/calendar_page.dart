import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late DateTime _date, _initialDate;

  @override
  void initState() {
    super.initState();
    _initialDate = DateTime(1991, 05, 29);
    _date = _initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: /*_date != _initialDate ? () {} : null*/ _save,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: SafeArea(
        child: CalendarDatePicker(
          initialDate: _date,
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
          // initialCalendarMode: DatePickerMode.year,
          selectableDayPredicate: (date) {
            return date.weekday !=6 && date.weekday !=7;
          },
          onDateChanged: (date) {
            setState(() {
              _date = date;
            });
          },
        ),
      ),
    );
  }

  void _save(){
    if(_initialDate != _date){
      print(_date);
    }
    Navigator.pop(context);
  }
}

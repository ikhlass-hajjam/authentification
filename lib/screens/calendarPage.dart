import 'package:authentification_test_2/screens/statusPage.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}


class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDay = DateTime.now();


  void _onDaySelected(DateTime day, DateTime focusDay) {
    setState(() {
      selectedDay = day;
    });

    // Navigate to the StatusPage when a day is selected
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatusPage(selectedDay: selectedDay),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home PoM'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text("Selected day = ${selectedDay?.toString().split(" ")[0] ?? 'None'}"),
          GestureDetector(
            onTap: () {},
            child:TableCalendar(
              locale:"en_US",
              rowHeight: 100,
              headerStyle:
              const HeaderStyle(formatButtonVisible: false, titleCentered: true),
              selectedDayPredicate: (day)=>isSameDay(day,selectedDay),
              focusedDay: selectedDay,
              firstDay: DateTime.utc(2018,10,16),
              lastDay: DateTime.utc(2040,3,14),
              onDaySelected: _onDaySelected,
            ),
          ),
        ],
      ),
    );
  }
}















/*class _CalendarPageState extends State<CalendarPage> {
  //int counter=1;
  DateTime today= DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusDay){
    setState(() {
      today=day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
          title:Text('Home PoM'), centerTitle:true
         ),
      body:content(),
    );
  }

  Widget content(){
    return Column(
      children:[
        Text("Selected day = "+today.toString().split(" ")[0]),
        Container(
          child:TableCalendar(
            locale:"en_US",
            rowHeight: 100,
            headerStyle:
              const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            selectedDayPredicate: (day)=>isSameDay(day,today),
            focusedDay: today,
            firstDay: DateTime.utc(2018,10,16),
            lastDay: DateTime.utc(2040,3,14),
            onDaySelected: _onDaySelected,

          ),
        ),
      ],
    );
  }
}*/

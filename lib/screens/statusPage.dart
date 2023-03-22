/*import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  _StatusPageState createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  //DateTime? _selectedDate;
  String? _selectedStatus;
  DateTime _selectedDate = DateTime.now();

  final Map<DateTime, String> _statusMap = {};

  void _onDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      _selectedStatus = _statusMap[date];
    });
  }

  void _onStatusSelected(String? status) {
    setState(() {
      _selectedStatus = status;
      _statusMap[_selectedDate!] = status!;
    });
  }

  Widget _buildStatusButton(String status) {
    return ElevatedButton(
      onPressed: () => _onStatusSelected(status),
      child: Text(status),
      style: ElevatedButton.styleFrom(
        primary: _selectedStatus == status ? Colors.blue : null,
      ),
    );
  }

  Widget _buildCalendar() {
    return TableCalendar(
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2023, 12, 31),
      focusedDay: _selectedDate ?? DateTime.now(),
      selectedDayPredicate: (day) {
        return _selectedDate != null &&
            day.year == _selectedDate!.year &&
            day.month == _selectedDate!.month &&
            day.day == _selectedDate!.day;
      },
      onDaySelected: _onDateSelected,
    );
  }

  Widget _buildStatusButtons() {
    return Column(
      children: [
        _buildStatusButton('Happy'),
        SizedBox(height: 8),
        _buildStatusButton('Neutral'),
        SizedBox(height: 8),
        _buildStatusButton('Sad'),
      ],
    );
  }

  Widget _buildSelectedStatus() {
    return Text(
      _selectedStatus ?? 'Select a status',
      style: TextStyle(fontSize: 24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Status'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCalendar(),
            SizedBox(height: 16),
            _buildStatusButtons(),
            SizedBox(height: 16),
            _buildSelectedStatus(),
          ],
        ),
      ),
    );
  }
}
*/












/****
import 'package:authentification_test_2/screens/statusPage.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../Data/MoodDatabase.dart';
import '../Model/Mood.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime selectedDay = DateTime.now();
  List<String> selectedMoods = [];

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

  void _onMoodSelected(String moodName) {
    setState(() {
      if (selectedMoods.contains(moodName)) {
        selectedMoods.remove(moodName);
      } else {
        selectedMoods.add(moodName);
      }
    });
  }

  void _saveSelectedMoods() async {
    final moodDatabase = MoodDatabase();
    await moodDatabase.open();
    for (final moodName in selectedMoods) {
      final mood = Mood(
        id: null,
        name: moodName,
        date: selectedDay,
      );
      await moodDatabase.insertMood(mood);
    }
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
          SizedBox(height: 20),
          Text('Select your mood(s):'),
          Wrap(
            spacing: 8.0,
            children: [
              MoodButton(
                moodName: 'Happy',
                isSelected: selectedMoods.contains('Happy'),
                onTap: _onMoodSelected,
              ),
              MoodButton(
                moodName: 'Sad',
                isSelected: selectedMoods.contains('Sad'),
                onTap: _onMoodSelected,
              ),
              MoodButton(
                moodName: 'Angry',
                isSelected: selectedMoods.contains('Angry'),
                onTap: _onMoodSelected,
              ),
              MoodButton(
                moodName: 'Excited',
                isSelected: selectedMoods.contains('Excited'),
                onTap: _onMoodSelected,
              ),
              MoodButton(
                moodName: 'Tired',
                isSelected: selectedMoods.contains('Tired'),
                onTap: _onMoodSelected,
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _saveSelectedMoods,
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}

class MoodButton extends StatelessWidget {


*/


















//il marche mais pas comme je veux
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Data/MoodDatabase.dart';
import '../Model/Mood.dart';



class StatusPage extends StatelessWidget {
  final DateTime selectedDay;
  //String? _selectedMood;

  const StatusPage({required this.selectedDay, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Query the database to get all the moods for the selected day
    final database = MoodDatabase();
    final moods = database.getMoodsForDay(selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: Text('Moods for ${selectedDay.toString().split(' ')[0]}'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Mood>>(
        future: moods,
        builder: (BuildContext context, AsyncSnapshot<List<Mood>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No moods recorded for this day.'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final mood = snapshot.data![index];
              return ListTile(
                title: Text(mood.name),
                subtitle: Text(mood.date.toIso8601String()),
              );
            },
          );
        },
      ),
    );
  }
}





















































/*import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Data/MoodDatabase.dart';


class StatusPage extends StatelessWidget {
  final DateTime selectedDay;

  //StatusPage({required this.selectedDay});
  const StatusPage({required this.selectedDay, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    // Query the database to get all the moods for the selected day
    final database = MoodDatabase();
    final moods = database.getMoodsForDay(selectedDay);

    return Scaffold(
      appBar: AppBar(
        title: Text('Moods for ${selectedDay.toString().split(' ')[0]}'),
        centerTitle: true,
      ),
      body:
      //Center(child:Text("The ${selectedDay.toString().split(" ")[0]}"),),
        ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            final mood = snapshot.data![index];
            return ListTile(
              title: Text(mood.name),
              subtitle: Text(mood.date.toIso8601String()),
            );
          },
        ),
    );
  }
}*/

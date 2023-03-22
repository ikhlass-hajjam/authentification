import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../Data/MoodDatabase.dart';
import '../Model/Mood.dart';

class TodayPage extends StatefulWidget {
  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  //int counter=0;
  MoodDatabase database = MoodDatabase();
  final items=['happy','okey','not okey','so sad'];
  String? value;

  final pages = {
    'happy': HappyPage(),
    'okey': OkeyPage(),
    'not okey': NotOkeyPage(),
    'so sad': SoSadPage(),
  };

  @override
  Widget build(BuildContext context)=> Scaffold(

    appBar: AppBar(title: Text('how are you ?'),centerTitle: true),
    body:Center(
      child:Container(
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
        decoration:BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border:Border.all(color: Colors.black, width: 2),
        ),
        child:DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              iconSize: 36,
              isExpanded: true,
              items: items.map(buildMenuItem).toList(),
              onChanged: (value) async{
                await database.insertMood(Mood(id: DateTime.now().millisecondsSinceEpoch, name: value!,date: DateTime.now()));
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => pages[value] as Widget),
                );
              },
            ),
        ),

      )

    ),

  );

  DropdownMenuItem<String> buildMenuItem(String item)=> DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style:TextStyle(fontSize: 20),
      )
  );



}

class HappyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Happy Page')),
      body: Center(child: Text('You selected Happy')),
    );
  }
}

class OkeyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Okey Page')),
      body:
      Center(
          child: Text('You selected Okey')),
    );
  }
}

class NotOkeyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Not Okey Page')),
    body: Center(child: Text('You selected not Okey')),
    );
  }
}

class SoSadPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('So sad Page')),
      body: Center(child: Text('You selected so sad')),
    );
  }
}
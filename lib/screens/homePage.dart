import 'package:authentification_test_2/common/textFormField.dart';
import 'package:authentification_test_2/screens/calendarPage.dart';
import 'package:authentification_test_2/screens/contactsPage.dart';
import 'package:authentification_test_2/screens/loginForm.dart';
import 'package:authentification_test_2/screens/todayPage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Data/dbHelper.dart';
import '../Model/UserModel.dart';
import '../common/comHelper.dart';

class HomeForm extends StatefulWidget {
  @override
  _HomeFormState createState() => _HomeFormState();
}

class _HomeFormState extends State<HomeForm> {
  int currentIndex = 0;
  final screens = [
    TodayPage(),
    CalendarPage(),
    ContactsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
          title:Text('Home PoM'),
          centerTitle:true,
      ),*/
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        //type:BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions_outlined),
            label: 'Today!',
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'Calender',
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Contacts',
            backgroundColor: Colors.lightBlue,
          ),
        ],

      ),
      body: screens[currentIndex],

    );
  }
}
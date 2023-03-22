import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatefulWidget {
  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  //int counter=2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body:ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Ikhlass Hajjam'),
            subtitle: Text('h.ikhlass.2000@gmail.com'),
            onTap: () async {

              launch("tel:+33631586344");
            },
          ),

          ListTile(
            leading: Icon(Icons.fire_truck_outlined),
            title: Text('SAMU'),
            //subtitle: Text('janedoe@example.com'),
            onTap: () {
              launch("tel:15");
            },
          ),

          ListTile(
            leading: Icon(Icons.local_police_outlined),
            title: Text('The police'),
            subtitle: Text('Emergency Police / Gendarmerie'),
            onTap: () {
              launch("tel:17");
            },
          ),

          ListTile(
            leading: Icon(Icons.sos_sharp),
            title: Text('SOS'),
            subtitle: Text('european phone number'),
            onTap: () {
              launch("tel:112");
            },
          ),

          ListTile(
            leading: Icon(Icons.emergency),
            title: Text('Emergency number'),
            subtitle: Text('Marine emergency'),
            onTap: () {
              launch("tel:196");
            },
          ),

          ListTile(
            leading: Icon(Icons.security),
            title: Text('Emergency number'),
            subtitle: Text('Aeronautical emergency'),
            onTap: () {
              launch("tel:191");
            },
          ),
        ],
      ),
    );

  }
}

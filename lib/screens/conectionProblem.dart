import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../common/textFormField.dart';
import 'package:flutter_sms/flutter_sms.dart';


class ConectionProblem extends StatefulWidget {
  @override
  State<ConectionProblem> createState() =>  _ConectionProblemState();
}

class _ConectionProblemState extends State<ConectionProblem> {

  //final _conPassword = TextEditingController();
  //final _conEmail = TextEditingController();
  //TextEditingController forgetPasswordController=TextEditingController();

  final _conPhoneNumber = TextEditingController();





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text('SignUp'),
      ),
      body: Form(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[



                  SizedBox(height:40.0),//pour l'espace
                  Text('Reset your password', style:TextStyle(
                      fontWeight:FontWeight.bold,
                      color:Colors.black54,
                      fontSize: 30.0),
                  ),
                  SizedBox(height:15.0),
                  Image.asset("assets/images/logo2.png",
                    height: 140.0,
                    width:140.0,
                  ),
                  SizedBox(height:10.0),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 23.0),
                    child:Text(
                      'Please enter your email and we will send you a password reset',
                      textAlign:TextAlign.center,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),

                  getTextFormField(
                      controller: _conPhoneNumber ,
                      icon: Icons.call,
                      inputType: TextInputType.phone,
                      hintName: 'Phone number'),
                  SizedBox(height: 10.0),
                  //le boutton
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    margin:EdgeInsets.only(top:35.0,bottom:10.0),
                    decoration: BoxDecoration(
                        color:Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30.0)
                    ),
                    //margin: EdgeInsets.all(60.0),
                    //width:double.infinity,
                    child: OutlinedButton(
                      child: Text(
                        'Sens SMS',
                        style: TextStyle(color:Colors.white),
                      ),
                      onPressed: (){},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );




  }
}

import 'package:authentification_test_2/common/comHelper.dart';
import 'package:authentification_test_2/screens/conectionProblem.dart';
import 'package:authentification_test_2/screens/homePage.dart';
import 'package:authentification_test_2/screens/signupForm.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Data/dbHelper.dart';
import '../Model/UserModel.dart';
import '../common/textFormField.dart';

class  LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = new GlobalKey<FormState>();
  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;


  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  login() async {
    String uid = _conUserId.text;
    String passwd = _conPassword.text;

    if (uid.isEmpty) {
      alertDialog(context, "Please Enter User ID");
    } else if (passwd.isEmpty) {
      alertDialog(context, "Please Enter Password");
    } else {
      await dbHelper.getLoginUser(uid, passwd).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => HomeForm()),
                    (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, "Error: User Not Found");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Error: Login Fail");
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id);
    sp.setString("user_name", user.user_name);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text('Login with signup'),
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                SizedBox(height:40.0),//pour l'espace
                Text('Peace of mind', style:TextStyle(
                    fontWeight:FontWeight.bold,
                    color:Colors.black54,
                    fontSize: 25.0, fontStyle: FontStyle.italic),
                  ),
                SizedBox(height:15.0),
                Image.asset("assets/images/logo2.png",
                height: 140.0,
                width:140.0,
                ),
                SizedBox(height:10.0),



                // le champs por le username
                getTextFormField(
                    controller: _conUserId,
                    icon: Icons.person,
                    hintName: 'User ID'),

                SizedBox(height: 10.0),

                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Password',
                  isObscureText: true,
                ),


                // le champs pour le mdpss


                //le boutton
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  margin:EdgeInsets.only(top:35.0,bottom:10.0),
                  //margin: EdgeInsets.all(60.0),
                  //width:double.infinity,
                  child: TextButton(
                    child: Text(
                      'Login',
                      style: TextStyle(color:Colors.white),
                    ),
                    onPressed: login,// j'arrive
                  ),
                  decoration: BoxDecoration(
                    color:Colors.lightBlue,
                    borderRadius: BorderRadius.circular(30.0)
                  ),
                ),





                // pour le lien pour s'inscrire
                Container(
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text("Don't have account? "),
                      TextButton(
                        child: Text(
                            'Signup',
                            style: TextStyle(color:Colors.blue)
                        ),
                        onPressed: () {
                          // je navigue vers la route
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_)=>SignupForm()));
                        },
                          )
                    ]
                  ),
                ),

                // forget pswd
                SizedBox(height:20.0),
                Container(
                  child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        //Text("Connection problem ?"),
                        OutlinedButton(
                          child: Text(
                              'Connection problem ?',
                              style: TextStyle(color:Colors.redAccent)
                          ),
                          onPressed: () {
                            // je navigue vers la route
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_)=>ConectionProblem()));
                          },
                        )
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

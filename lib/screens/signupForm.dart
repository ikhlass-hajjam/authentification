import 'package:authentification_test_2/screens/loginForm.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../Data/dbHelper.dart';
import '../Model/UserModel.dart';
import '../common/comHelper.dart';
import '../common/textFormField.dart';

class SignupForm extends StatefulWidget {

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();

  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }


  signUp() async {
    final form=_formKey.currentState;

    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    // confiming the password

    if (form?.validate()==true) {
      if (passwd != cpasswd) {
        alertDialog(context, 'Password Mismatch');
        print('ok');
      } else {
        _formKey?.currentState?.save();

        UserModel uModel = UserModel(uid, uname, email, passwd);
        await dbHelper.saveData(uModel).then((userData) {
          alertDialog(context, "Successfully Saved");

          Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginForm()));
        }).catchError((error) {
          print(error);
          alertDialog(context, "Error: Data Save Fail");
        });
      }
    }




  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          //title: Text('SignUp'),
      ),
      body: Form(
        key:_formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                  SizedBox(height:40.0),//pour l'espace
              Text('Sign up', style:TextStyle(
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



                      getTextFormField(
                          controller: _conUserId,
                          icon: Icons.person,
                          hintName: 'User ID'),
                      SizedBox(height: 10.0),
                      getTextFormField(
                          controller: _conUserName,
                          icon: Icons.person_outline,
                          inputType: TextInputType.name,
                          hintName: 'User Name'),
                    SizedBox(height: 10.0),
                    getTextFormField(
                          controller: _conEmail,
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          hintName: 'Email'),
                    SizedBox(height: 10.0),
                    getTextFormField(
                          controller: _conPassword,
                          icon: Icons.lock,
                          hintName: 'Password',
                          isObscureText: true,
                          ),
                    SizedBox(height: 10.0),
                    getTextFormField(
                          controller: _conCPassword,
                          icon: Icons.lock_reset,
                          hintName: 'Confirm Password',
                          isObscureText: true,
                          ),

                //le boutton
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 50.0),
                  margin:EdgeInsets.only(top:35.0,bottom:10.0),
                  //margin: EdgeInsets.all(60.0),
                  //width:double.infinity,
                  child: TextButton(
                    child: Text(
                      'Sign up',
                      style: TextStyle(color:Colors.white),
                    ),
                    onPressed: signUp,
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
                        Text('You already have account? '),
                        TextButton(
                          child: Text(
                              'Login',
                              style: TextStyle(color:Colors.blue)
                          ),
                          onPressed: () {
                            // je navigue vers la route
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_)=>LoginForm()));
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
      ),
  );
 }
}

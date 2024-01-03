import 'package:aninda_yemek/data/entitiy/users.dart';
import 'package:aninda_yemek/ui/views/anasayfa.dart';
import 'package:aninda_yemek/ui/views/bottom_navigator_page.dart';
import 'package:aninda_yemek/ui/views/registration_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var tfEmail = TextEditingController();
  var tfPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFF778da9),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/lllogin.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Container(
                        height: 200.0,
                        child: Image.asset('images/logo.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 60.0,
                  ),
                  Padding(
                    padding: ProjectPaddings.textFieldPadding,
                    child: TextField(
                      controller: tfEmail,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Color(0xffedf2f4)),

                        filled: true,
                        fillColor: Color(0xff8d99ae),
                        icon: Icon(Icons.mail,color: Color(0xff0d1b2a),),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: ProjectPaddings.textFieldPadding,
                      child: TextField(
                        obscureText: true,
                        controller: tfPassword,
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(color: Color(0xffedf2f4)),
                          filled: true,
                          fillColor: Color(0xff8d99ae),
                          icon: Icon(Icons.lock,color: Color(0xff0d1b2a),),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistrationScreen()));
                        },
                        child: const Text("Sign Up",style: TextStyle(color: Color(0xffedf2f4),fontFamily: "BlackOpsOne"),),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xff0d1b2a),
                            elevation: 7,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),

                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (tfEmail.text.isEmpty ||
                                tfPassword.text.isEmpty) {
                              AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.ERROR,
                                      title: "Warning!",
                                      desc: "Please fill in all fields",
                                      btnOkColor: Color(0xff0d1b2a),
                                      btnOkOnPress: () {})
                                  .show();
                            } else if (tfPassword.text.length < 8) {
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.ERROR,
                                  animType: AnimType.SCALE,
                                  title: "Error!",
                                  desc:
                                      "The password you enter must be at least 8 characters long!",
                                  btnOkColor: Color(0xff0d1b2a),
                                  btnOkOnPress: () {
                                    Navigator.pop(context);
                                  }).show();
                            } else {
                              if (!emailValid(tfEmail.text)) {
                                AwesomeDialog(
                                    context: context,
                                    dialogType: DialogType.ERROR,
                                    animType: AnimType.SCALE,
                                    title: "Warning!",
                                    desc: "Please enter a valid email!",
                                    btnOkColor: Color(0xff0d1b2a),
                                    btnOkOnPress: () {
                                      Navigator.pop(context);
                                    }).show();
                              } else {
                                signIn();
                              }
                            }
                          },
                          child: const Text("Login",style: TextStyle(color:Color(0xffedf2f4),fontFamily: 'BlackOpsOne' ),),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff0d1b2a),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        )),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tfEmail.text.trim(), password: tfPassword.text.trim());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigatorPage()),
          (Route<dynamic> route) => false);
    } catch (e) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          title: "Warning!",
          desc: "You entered incorrect information",
          btnOkColor: Colors.red,
          btnOkOnPress: () {
            Navigator.pop(context);
          }).show();
    }
  }

  Stream<Users> readUser(String e) => FirebaseFirestore.instance
      .collection("users")
      .snapshots()
      .map((snapshot) => snapshot.docs
              .map((doc) => Users.fromJson(doc.data()))
              .toList()
              .firstWhere((eachElement) => eachElement.email == e, orElse: () {
            return Users(
                email: tfEmail.text, userName: "", timeStamp: DateTime.now());
          }));

  bool emailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}

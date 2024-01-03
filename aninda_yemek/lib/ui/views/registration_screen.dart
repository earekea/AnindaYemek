import 'package:aninda_yemek/data/entitiy/users.dart';
import 'package:aninda_yemek/ui/views/login_screen.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:aninda_yemek/ui/views/registration_success_page.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  var tfEmail = TextEditingController();
  var tfUserName = TextEditingController();
  var tfPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFF778da9),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/register.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: 'logo',
                          child: Container(
                            height: 200.0,
                            child: Image.asset('images/logo.png'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 9,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: tfEmail,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) {},
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Color(0xffedf2f4)),
                        filled: true,
                        icon: Icon(Icons.mail,color: Color(0xff0d1b2a)),
                        fillColor: Color(0xff8d99ae),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: tfUserName,
                      decoration: InputDecoration(
                        hintText: "UserName",
                        hintStyle: TextStyle(color: Color(0xffedf2f4)),
                        filled: true,
                        fillColor: Color(0xff8d99ae),
                        icon: Icon(Icons.person,color: Color(0xff0d1b2a)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      obscureText: true,
                      controller: tfPassword,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Color(0xffedf2f4)),
                        filled: true,
                        fillColor: Color(0xff8d99ae),
                        icon: Icon(Icons.lock,color: Color(0xff0d1b2a)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
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
                                      btnOkColor: Colors.black,
                                      btnOkOnPress: () {})
                                  .show();
                            } else {
                              if (!emailValid(tfEmail.text)) {
                                AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.ERROR,
                                        animType: AnimType.SCALE,
                                        title: "Warning!",
                                        desc: "Please enter a valid email!",
                                        btnOkColor: Colors.black,
                                        btnOkOnPress: () {})
                                    .show();
                              } else {
                                signUp();
                              }
                            }
                          },
                          child: const Text("Register",style: TextStyle(color: Color(0xffedf2f4),fontFamily: "BlackOpsOne"),),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff0d1b2a),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        
                      )),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        }, child: Text("I have Account",style: TextStyle(color: Color(0xffedf2f4),fontFamily: "BlackOpsOne"),),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xff0d1b2a),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Future signUp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: tfEmail.text, password: tfPassword.text);

      try {
        FirebaseAuth auth = FirebaseAuth.instance;
        var userId = auth.currentUser!.uid;

        final doc = FirebaseFirestore.instance.collection("users").doc(userId);
        final json = {
          'email': tfEmail.text,
          'userName': tfUserName.text,
          'timestamp': DateTime.now(),
        };
        print("$json");
        var user = Users(
            email: tfEmail.text,
            userName: tfUserName.text,
            timeStamp: DateTime.now());
        var newJson = user.toJson();
        await doc.set(newJson);
      } catch (Exception) {}

      Navigator.pushReplacement(
          context,
          (MaterialPageRoute(
              builder: (context) => RegistrationSuccessPage(
                    firstTimeLogin: true,
                  ))));
    } on FirebaseAuthException catch (e) {
      print(e.message);

      if (e.code == "email-already-in-use") {
        AwesomeDialog(
            context: context,
            headerAnimationLoop: false,
            dialogType: DialogType.question,
            animType: AnimType.topSlide,
            title: "Warning!",
            desc: "Such an account already exists",
            btnOkColor: Color(0xff0d1b2a),
            btnOkOnPress: () {
              Navigator.pop(context);
            }).show();
      } else {
        AwesomeDialog(
                context: context,
                dialogType: DialogType.info,
                animType: AnimType.rightSlide,
                title: "Warning!",
                desc: "You entered incorrect information",
                btnOkColor: Color(0xff0d1b2a),
                btnOkOnPress: () {})
            .show();
      }
    } finally {}
  }

  bool emailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}

class ProjectPaddings {
  static const textFieldPadding =
      EdgeInsets.symmetric(horizontal: 40, vertical: 10);
}

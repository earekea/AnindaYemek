import 'package:flutter/material.dart';

import 'package:aninda_yemek/ui/views/login_screen.dart';

class RegistrationSuccessPage extends StatefulWidget {
  const RegistrationSuccessPage({Key? key, required bool firstTimeLogin}) : super(key: key);

  @override
  State<RegistrationSuccessPage> createState() =>
      _RegistrationSuccessPageState();
}

class _RegistrationSuccessPageState extends State<RegistrationSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8d99ae),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                width: 400,
                height: 400,
                child: Image.asset("images/welcome.png")),
            SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                  },
                  child: const Text("Continue",style: TextStyle(color: Color(0xffedf2f4)),),
                  style: ElevatedButton.styleFrom(
                      primary: Color(0XFF1b263b),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ))
          ],
        ),
      ),
    );
  }
}
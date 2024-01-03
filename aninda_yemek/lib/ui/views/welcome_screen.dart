import 'package:aninda_yemek/rounded_button.dart';
import 'package:aninda_yemek/ui/views/login_screen.dart';
import 'package:aninda_yemek/ui/views/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin{

  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller= AnimationController(duration:Duration(seconds: 2) ,vsync: this);
    animation= ColorTween(begin: Color(0XFF1b263b),end: Color(0xFF778da9)).animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {
      });
    },);
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      backgroundColor: animation.value,

      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 250.0,
                      padding: EdgeInsets.only(right: 10.0),
                    ),

                  ),
                  SizedBox(
                    height: 20,
                  ),
                  DefaultTextStyle(style: TextStyle(fontSize: 55.0,
                      fontWeight:FontWeight.bold,fontFamily: "Lobster",
                      color: Color(0xff0d1b2a)
                  ), child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText('Anında Yemek',),

                    ],
                  )
                  )
                ],
              ),
              SizedBox(
                height: 130.0,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedButton(title: 'Log İn', color: Color(0xff0d1b2a),onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },),
                  RoundedButton(title: 'Register', color: Color(0xff0d1b2a), onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationScreen()));
                  }),
                ],
              ),

              SizedBox(
                height: 20.0,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

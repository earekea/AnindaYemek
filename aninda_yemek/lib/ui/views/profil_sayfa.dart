

import 'package:aninda_yemek/data/entitiy/users.dart';
import 'package:aninda_yemek/ui/views/lokasyon_sayfa.dart';
import 'package:aninda_yemek/ui/views/sepet_sayfa.dart';
import 'package:aninda_yemek/ui/views/welcome_screen.dart';
import 'package:flutter/material.dart';

class ProfilSayfa extends StatefulWidget{


  @override
  State<ProfilSayfa> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilSayfa> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Color(0xFF778da9),
  
  drawer: Drawer(
backgroundColor: Color(0xFF778da9),
child: ListView(padding: EdgeInsets.all(3),
  children: [
    AppBar(
      backgroundColor: Color(0XFF1b263b).withOpacity(0.1),
      title: Text("Profilim",style: TextStyle(color: Color(0xffd9d9d9),fontFamily: "RubikBubbles"),),
    ),
    Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [


          TextButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
          }, child: Row(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.exit_to_app,size: 30,color: Color(0xff0d1b2a),),
              SizedBox(
                width: 10,
              ),
              Text('Çıkış',style: TextStyle(fontSize: 30,color: Color(0xffd9d9d9),fontFamily: "BlackOpsOne"),),
            ],
          ))
        ],
      ),
    )
  ],
),
  ),
      appBar: AppBar(
        backgroundColor: Color(0XFF1b263b),
        centerTitle: true,
        title: Text("PROFİLİM",style: TextStyle(color: Color(0xffd9d9d9),fontSize: 30,fontFamily: "RubikBubbles"),),
      ),
body:
     Container(
         decoration: BoxDecoration(
           image: DecorationImage(image: AssetImage("images/welcome2.png"))
         ),
      ),

    );

  }
}
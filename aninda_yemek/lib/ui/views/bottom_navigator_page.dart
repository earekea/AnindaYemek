import 'package:aninda_yemek/ui/views/anasayfa.dart';
import 'package:aninda_yemek/ui/views/lokasyon_sayfa.dart';
import 'package:aninda_yemek/ui/views/profil_sayfa.dart';
import 'package:aninda_yemek/ui/views/sepet_sayfa.dart';
import 'package:flutter/material.dart';

class BottomNavigatorPage extends StatefulWidget {
  const BottomNavigatorPage({super.key});

  @override
  State<BottomNavigatorPage> createState() => _BottomNavigatorPageState();
}

var sayfaListesi=[Anasayfa(),LokasyonSayfa(),SepetSayfa(),ProfilSayfa()];
int secilenSayfa=0;

class _BottomNavigatorPageState extends State<BottomNavigatorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sayfaListesi[secilenSayfa],
      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed, // Fixed
        backgroundColor: Color(0xff0d1b2a), // <-- This works for fixed
        selectedItemColor: Colors.greenAccent,
        unselectedItemColor: Color(0xffedf2f4),

        items: [


        BottomNavigationBarItem(icon: Icon(Icons.home),
            label: "Anasayfa"),
        BottomNavigationBarItem(icon: Icon(Icons.location_on),
            label: "Lokasyon",backgroundColor:Color(0xff0d1b2a) ),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),
            label: "Sepetim"),
        BottomNavigationBarItem(icon: Icon(Icons.person),
            label: "Profil"),


      ],
        elevation: 0,

        iconSize: 20,
        currentIndex: secilenSayfa,
        onTap: (value){
          setState(() {
            secilenSayfa=value;
          });
        },
      ),
    );
  }
}


import 'package:aninda_yemek/ui/views/anasayfa.dart';
import 'package:aninda_yemek/ui/views/sepet_sayfa.dart';
import 'package:flutter/material.dart';

class DrawerPage extends StatefulWidget {

  const DrawerPage({Key? key}) : super(key: key);

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}
class _DrawerPageState extends State<DrawerPage> {

  @override
  Widget build(BuildContext context) {

    return Drawer(
      // backgroundColor: color4,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: Colors.black,
              child: DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(onTap: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilPage()));
                    },child: CircleAvatar(backgroundImage: AssetImage("images/profil.png"),maxRadius: 28,)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa()));
              },
              child: drawerItems(
                  icons: Icon(
                    Icons.home,
                    color: Colors.pink,
                    size: 26,
                  ),
                  text: 'Home'),
            ),
            drawerItems(
                icons: Icon(
                  Icons.settings,
                  color: Colors.yellow,
                  size: 26,
                ),
                text: 'Settings'),
            GestureDetector(
              onTap: (){
                // Navigator.push(context,
                //     // MaterialPageRoute(builder: (context) => LocationPage()));
              },
              child: drawerItems(
                  icons: Icon(
                    Icons.location_on_rounded,
                    color: Colors.red,
                    size: 26,
                  ),
                  text: 'Location'),
            ),
            drawerItems(
                icons: Icon(
                  Icons.notifications,
                  color: Colors.green,
                  size: 26,
                ),
                text: 'Notifications'),
            drawerItems(
                icons: Icon(
                  Icons.question_mark_rounded,
                  color: Colors.brown,
                  size: 26,
                ),
                text: 'Help'),
            SizedBox(height: 180),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SepetSayfa()));
              },
              child: drawerItems(
                  icons: Icon(
                    Icons.login_rounded,
                    color: Colors.black,
                    size: 26,
                  ),
                  text: 'Log Out'),
            ),
          ],
        ));
  }
}

class drawerItems extends StatelessWidget {
  const drawerItems({
    Key? key,
    required this.icons,
    required this.text,
  }) : super(key: key);

  final Icon icons;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: icons,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.black45, fontSize: 14,),
          ),
        ],
      ),
    );
  }
}
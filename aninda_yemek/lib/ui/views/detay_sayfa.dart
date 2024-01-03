import 'package:aninda_yemek/data/entitiy/sepet_yemekler.dart';
import 'package:aninda_yemek/data/entitiy/yemekler.dart';
import 'package:aninda_yemek/data/repo/usersdao_repository.dart';

import 'package:aninda_yemek/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:aninda_yemek/ui/views/bottom_navigator_page.dart';
import 'package:aninda_yemek/ui/views/sepet_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetaySayfa extends StatefulWidget {
  Yemekler yemek;

  DetaySayfa({
    required this.yemek,
  });

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {
  var urepo = UserRepository();
  int yemek_siparis_adet = 1;
  bool favoriteButton = true;



  @override
  Widget build(BuildContext context) {


    var yemek= widget.yemek;
    int total = int.parse(yemek.yemek_fiyat) * yemek_siparis_adet;

    return Container(
decoration: BoxDecoration(
              color: Color(0xff8d99ae),
        borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),topRight: Radius.circular(30)
    ),
),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: favoriteButton
                        ? IconButton(
                        onPressed: () {
                          setState(() {
                            favoriteButton = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Color(0xff0d1b2a),
                              content: Text("${widget.yemek
                                  .yemek_adi} favorilere eklendi")));
                        },
                        icon: Icon(Icons.favorite_border_outlined))
                        : IconButton(
                        onPressed: () {
                          setState(() {
                            favoriteButton = true;
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Color(0xff0d1b2a),
                                content: Text("${widget.yemek
                                    .yemek_adi} favorilerden kaldırıldı")));
                          });
                        },
                        icon: Icon(Icons.favorite,color: Colors.red))),
              ],
            ),
            Container(
              width:170,
              height: 100,
              decoration: BoxDecoration(
                color: Color(0xff8d99ae),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),topRight: Radius.circular(50)
                )
              ),
              child: Image.network(
                  "http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),
            ),
            Text(
              '${widget.yemek.yemek_fiyat} ₺',
              style: TextStyle(fontSize: 25,color: Color(0xffedf2f4),fontFamily: ""),
            ),
            Text("${widget.yemek.yemek_adi}",style: TextStyle(fontSize: 20,color: Color(0xffedf2f4),fontFamily: "ZillaSlab"),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(backgroundColor: Color(0xff03071e),
                  child: IconButton(onPressed: (){
                  
                  
                      setState(() {
                        yemek_siparis_adet !=1 ? yemek_siparis_adet -=1 : yemek_siparis_adet;
                      });
                  
                  
                  
                  }, icon: Icon(Icons.remove),color: Color(0xff8d99ae)),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("$yemek_siparis_adet",style: TextStyle(color:Color(0xffedf2f4) ,fontFamily: "ZillaSlab",fontSize: 17),),
                ),CircleAvatar(
                  backgroundColor: Color(0xff03071e),
                  child: IconButton(onPressed: (){
                  
                  
                    setState(() {
                      yemek_siparis_adet += 1;
                    });
                  
                  
                  
                  }, icon: Icon(Icons.add),color: Color(0xff8d99ae),),
                ),
                
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Color(0xff8d99ae),
                      child: Text('25-30 dk',style: TextStyle(fontFamily: "ZillaSlab"),),
                    ),
                  ),
                  Card( color: Color(0xff8d99ae),
                    child: Text("Ücretiz Teslimat",style: TextStyle(fontFamily: "ZillaSlab")),
                  ),
                  Card( color: Color(0xff8d99ae),
                    child: Text("İndirim %15",style: TextStyle(fontFamily: "ZillaSlab")),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17.0,right: 9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.yemek.yemek_fiyat} ₺",
                    style: TextStyle(fontSize: 30,color: Color(0xffedf2f4),fontFamily: "ZillaSlab"),
                  ),
                  ElevatedButton(style: ElevatedButton.styleFrom(

                    backgroundColor: Color(0xff03071e),
                  ),
                      onPressed: () {
                        urepo.getUserId().then((userId) {
                          urepo.getUser(userId).then((user) {
                            context
                                .read<SepetSayfaCubit>()
                                .sepeteYemekEkle(widget.yemek, user.userName, yemek_siparis_adet).then((
                                value) {

                            });
                          });
                        });

                      },
                      child: Text(
                        'Sepete Ekle',
                        style: TextStyle(fontSize: 30,color:Color(0xff8d99ae),fontFamily: "BlackOpsOne" ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 9,
            )
          ],
        ),
      ),
    );
  }
}

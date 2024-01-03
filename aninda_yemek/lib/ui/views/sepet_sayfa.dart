import 'package:aninda_yemek/data/entitiy/sepet_yemekler.dart';
import 'package:aninda_yemek/data/entitiy/yemekler.dart';
import 'package:aninda_yemek/data/repo/usersdao_repository.dart';

import 'package:aninda_yemek/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:aninda_yemek/ui/views/anasayfa.dart';
import 'package:aninda_yemek/ui/views/detay_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfa extends StatefulWidget {


  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}

class _SepetSayfaState extends State<SepetSayfa> {
  var totalBasket=0;
  var currentUserId;
  var urepo = UserRepository();
  @override
  void initState() {
    super.initState();

    urepo.getUserId().then((userId) {
      currentUserId = userId;
      urepo.getUser(currentUserId).then((user) {
        user = user;
        context.read<SepetSayfaCubit>().sepetYemeklerGetir(user.userName);
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Color(0xff8d99ae),

        appBar: AppBar(
          backgroundColor:Color(0XFF1b263b) ,
centerTitle: true,
          title: Text('Sepetim',style: TextStyle(color: Color(0xffd9d9d9),fontFamily: "RubikBubbles"),),
        ),
        body: BlocBuilder<SepetSayfaCubit, List<SepetYemekler>>(
            builder: (context, sepetListesi) {
              totalBasket=0;
              for(var i = 0 ; i<sepetListesi.length;i++){
                totalBasket += int.parse(sepetListesi[i].yemek_fiyat) * int.parse(sepetListesi[i].yemek_siparis_adet);
              }
          if (sepetListesi.isNotEmpty) {
            return ListView.builder(
                itemCount: sepetListesi.length,
                itemBuilder: (context, indeks) {
                  var sepetYemek = sepetListesi[indeks];
                  return GestureDetector(
                    onTap: (){
                      var ye= Yemekler(yemek_id: '', yemek_adi: sepetYemek.yemek_adi, yemek_resim_adi: sepetYemek.yemek_resim_adi, yemek_fiyat: sepetYemek.yemek_fiyat);
                      showModalBottomSheet(


                          context: context,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30),)),

                          builder: (context)=>DetaySayfa(yemek: ye) );


                    },
                    child: Card(
                      color: Color(0xff0d1b2a).withOpacity(0.9),
                      elevation: 9,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xff8d99ae),
                          backgroundImage: NetworkImage("http://kasimadalan.pe.hu/yemekler/resimler/${sepetYemek.yemek_resim_adi}"),
                        ),
                        title: Padding(padding: EdgeInsets.all(8.0),
                        child: Text("${sepetYemek.yemek_siparis_adet} Adet ${sepetYemek.yemek_adi}",style: TextStyle(fontSize: 20,color: Color(0xffd9d9d9),fontFamily: "ZillaSlab"),),

                        ),
                        subtitle: Padding(padding: EdgeInsets.all(9.0),
                        child: Text("${int.parse(sepetYemek.yemek_fiyat)*int.parse(sepetYemek.yemek_siparis_adet)} ₺",style: TextStyle(fontSize:15,color: Color(0xffd9d9d9)),),),
                        trailing: IconButton(onPressed: (){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                              Text("${sepetYemek.yemek_adi} silinsin mi?"),
                              action: SnackBarAction(
                                label: "Evet",
                                onPressed: () {
                                  context.read<SepetSayfaCubit>().delete(
                                      sepetYemek.sepet_yemek_id,
                                      sepetYemek.kullanici_adi);
                                  if(sepetListesi.length  == 1){
                                    setState((){
                                      sepetListesi.clear();
                                      totalBasket=0;
                                    });
                                  }
                                },
                              ),
                            ),
                          );

                        }, icon: Icon(Icons.delete,color:Color(0xffd9d9d9) ,)),

                      ),
                    ),
                  );
                });
          } else {
            return Center();
          }
        }));
  }
}

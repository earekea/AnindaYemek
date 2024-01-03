import 'package:aninda_yemek/data/entitiy/yemekler.dart';
import 'package:aninda_yemek/data/repo/usersdao_repository.dart';
import 'package:aninda_yemek/ui/cubit/anasayfa_cubit.dart';
import 'package:aninda_yemek/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:aninda_yemek/ui/views/detay_sayfa.dart';
import 'package:aninda_yemek/ui/views/lokasyon_sayfa.dart';
import 'package:aninda_yemek/ui/views/sepet_sayfa.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Anasayfa extends StatefulWidget {
  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  var sayfaListesi = [Anasayfa(), LokasyonSayfa(), SepetSayfa()];
  int secilenSayfa = 0;
  int currentIndex = 0;
  bool aramaYapiliyorMu = false;
  int yemek_siparis_adet = 1;
  bool favoriteButton = true;
  var urepo = UserRepository();
  @override
  void initState() {
    super.initState();
    context.read<AnaSayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff8d99ae),
      appBar: AppBar(
        backgroundColor: Color(0xff0d1b2a),
        centerTitle: true,
        title: aramaYapiliyorMu
            ? TextField(
                decoration: InputDecoration(
                  hintText: 'Ara',
                  hintStyle: TextStyle(color: Color(0xffedf2f4)),
                  filled: true,
                  fillColor: Color(0xff8d99ae),
                ),
                onChanged: (aramaSonucu) {
                  context.read<AnaSayfaCubit>().searchFoods(aramaSonucu);
                },
              )
            : Text(
                'Anında Yemek',
                style: TextStyle(color: Color(0xffd9d9d9),fontFamily: 'RubikBubbles'),
              ),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                    });
                    context.read<AnaSayfaCubit>().yemekleriYukle();
                  },
                  icon: Icon(
                    Icons.clear,
                    color: Color(0xffd9d9d9),
                  ))
              : IconButton(
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                  icon: Icon(
                    Icons.search,
                    color: Color(0xffd9d9d9),
                  ))
        ],
      ),
      body: BlocBuilder<AnaSayfaCubit, List<Yemekler>>(
        builder: (context, yemeklerListesi) {
          if (yemeklerListesi.isNotEmpty) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: GridView.builder(
                  itemCount: yemeklerListesi.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                  itemBuilder: (context, indeks) {
                    var yemek = yemeklerListesi[indeks];

                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            )),
                            builder: (context) => DetaySayfa(yemek: yemek));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        width: 185,
                        height: 200,
                        child: Card(
                          color: Color(0xff0d1b2a).withOpacity(0.9),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(27)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              CircleAvatar(
                                backgroundImage: NetworkImage(
                                    "http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                                maxRadius: 60,
                                backgroundColor: Color(0xff8d99ae),
                              ),
                              SizedBox(
                                height: 30,
                                child: Text(
                                  "${yemek.yemek_adi}",
                                  style: TextStyle(
                                      fontSize: 19, color: Color(0xffd9d9d9),fontFamily: "ZillaSlab"),
                                ),
                              ),
                              SizedBox(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '₺ ${yemek.yemek_fiyat} ',
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color(0xffd9d9d9)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: CircleAvatar(
                                          backgroundColor: Color(0xff8d99ae),
                                          child: IconButton(
                                            color: Colors.red,
                                            onPressed: () {
                                              urepo.getUserId().then((userId) {
                                                urepo
                                                    .getUser(userId)
                                                    .then((user) {
                                                  context
                                                      .read<SepetSayfaCubit>()
                                                      .sepeteYemekEkle(
                                                          yemek,
                                                          user.userName,
                                                          yemek_siparis_adet)
                                                      .then((value) {
                                                    print(
                                                        '${yemek.yemek_adi} Sepete eklendi');
                                                  });
                                                });
                                              });
                                              print(
                                                  '${yemek.yemek_adi} Sepete eklendi');
                                            },
                                            icon: Icon(
                                              Icons.add,
                                              color: Color(0xffd9d9d9),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          } else {
            return Center();
          }
        },
      ),
    );
  }
}

import 'dart:convert';

import 'package:aninda_yemek/data/entitiy/sepet_yemekler.dart';
import 'package:aninda_yemek/data/entitiy/sepet_yemekler_cevap.dart';
import 'package:aninda_yemek/data/entitiy/yemekler.dart';
import 'package:dio/dio.dart';

class SepetYemeklerDaoRepository {
  List<SepetYemekler> parseSepetYemekler(String cevap) {
    var jsonVeri = json.decode(cevap);
    var sepetYemekler = SepetYemeklerCevap.fromJson(jsonVeri);
    return sepetYemekler.sepet_yemekler;
  }


  Future<void> addToSepet(Yemekler yemek, String kullanici_adi,
      int yemek_siparis_adet) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {
      "kullanici_adi": kullanici_adi,
      "yemek_siparis_adet": yemek_siparis_adet,
      "yemek_fiyat": yemek.yemek_fiyat,
      "yemek_resim_adi": yemek.yemek_resim_adi,
      "yemek_adi": yemek.yemek_adi
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print('Sepete ürün kaydet:${cevap.data.toString()}');
  }


  Future<List<SepetYemekler>> sepetYemeklerGetir(String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi": kullanici_adi};
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    return parseSepetYemekler(cevap.data.toString());
  }

  Future<void> yemekSil(String sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {
      "sepet_yemek_id": sepet_yemek_id,
      "kullanici_adi": kullanici_adi
    };
    var cevap = await Dio().post(url, data: FormData.fromMap(veri));
    print('Yemek Sil : ${cevap.data.toString()}');
  }

  // Future<List<SepetYemekler>> sepetYemekAra(String aramaKelimesi) async {
  //   var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
  //   var cevap = await Dio().get(url);
  //   return parseSepetYemekler(cevap.data)
  //       .where((element) =>
  //       element.yemek_adi.toLowerCase().contains(aramaKelimesi.toLowerCase()))
  //       .toList();
  // }


}
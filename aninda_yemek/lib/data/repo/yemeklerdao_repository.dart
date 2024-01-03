import 'dart:convert';
import 'package:aninda_yemek/data/entitiy/yemekler.dart';
import 'package:aninda_yemek/data/entitiy/yemekler_cevap.dart';
import 'package:dio/dio.dart';

class YemeklerDaoRepository {
  List<Yemekler> parseYemekler(String cevap) {
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  Future<List<Yemekler>> yemekleriYukle() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data.toString());
  }

  Future<List<Yemekler>> searchFoods(String aramaKelimesi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap = await Dio().get(url);
    return parseYemekler(cevap.data)
        .where((element) => element.yemek_adi
            .toLowerCase()
            .contains(aramaKelimesi.toLowerCase()))
        .toList();
  }
}

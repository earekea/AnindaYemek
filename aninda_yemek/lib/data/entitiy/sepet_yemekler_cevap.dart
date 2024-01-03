import 'package:aninda_yemek/data/entitiy/sepet_yemekler.dart';
import 'package:aninda_yemek/data/entitiy/yemekler_cevap.dart';


class SepetYemeklerCevap{


  List<SepetYemekler> sepet_yemekler;
  int success;

  SepetYemeklerCevap({required this.sepet_yemekler, required this.success});
  factory SepetYemeklerCevap.fromJson(Map<dynamic,dynamic>json){
    var jsonArray=json["sepet_yemekler"] as List;
    int success = json["success"] as int;

    var sepet_yemekler=jsonArray.map((jsonArrayNesnesi) => SepetYemekler.fromJson(jsonArrayNesnesi)).toList();

    return SepetYemeklerCevap(sepet_yemekler: sepet_yemekler, success: success);
  }
}
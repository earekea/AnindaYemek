import 'package:aninda_yemek/data/entitiy/sepet_yemekler.dart';
import 'package:aninda_yemek/data/entitiy/yemekler.dart';
import 'package:aninda_yemek/data/repo/sepet_yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SepetSayfaCubit extends Cubit<List<SepetYemekler>>{
SepetSayfaCubit(): super([]);
  var syrepo=SepetYemeklerDaoRepository();


  Future<void> sepetYemeklerGetir(String kullanici_adi)async{
    var liste = await syrepo.sepetYemeklerGetir(kullanici_adi);
    emit(liste);
  }

Future<void> sepeteYemekEkle(
      Yemekler yemek,String kullanici_adi, int yemek_siparis_adet) async {
  await syrepo.addToSepet(yemek,kullanici_adi, yemek_siparis_adet);
}






Future<void> delete(String sepet_yemek_id,String kullanici_adi) async{
  await syrepo.yemekSil(sepet_yemek_id, kullanici_adi);
  await sepetYemeklerGetir(kullanici_adi);

}


// Future<void> sepetYemekAra(String aramaHarf) async {
//   var liste = await syrepo.sepetYemekAra(aramaHarf);
//   emit(liste);
// }
}
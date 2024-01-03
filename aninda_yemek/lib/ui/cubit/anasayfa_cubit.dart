import 'package:aninda_yemek/data/entitiy/yemekler.dart';
import 'package:aninda_yemek/data/repo/yemeklerdao_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnaSayfaCubit extends Cubit<List<Yemekler>>{
  AnaSayfaCubit():super(<Yemekler>[]);

  var yrepo=YemeklerDaoRepository();


  Future<void> yemekleriYukle()async{
    var liste= await yrepo.yemekleriYukle();
    emit(liste);
  }

  Future<void> searchFoods(String aramaKelimesi) async {
    var liste = await yrepo.searchFoods(aramaKelimesi);
    emit(liste);
  }
}


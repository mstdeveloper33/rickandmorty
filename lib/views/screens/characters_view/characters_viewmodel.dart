//! Bu dosya, karakterler sayfasının viewmodel'ini oluşturduğumuz dosyadır.Burada karakterler sayfası için gerekli olan state management işlemleri yapılır ve api servisleri çağrılır. Bu sayede view dosyası sadece tasarım işlemleri ile uğraşır ve kodun okunabilirliği artar.Buradaki state ve api işlemlerinin sonucu view dosyasına gönderilir ve view dosyasında bu sonuçlar gösterilir.

import 'package:flutter/material.dart';
import 'package:rickyandmorty/app/locator.dart';
import 'package:rickyandmorty/models/characters_model.dart';

import '../../../services/api_service.dart';

class CharactersViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  CharactersModel? _charactersModel;
  CharactersModel? get charactersModel => _charactersModel;

  void clearCharacters() {
    _charactersModel = null;
    currentPageIndex = 1;
    notifyListeners();
  }

//todo Bu fonksiyon karakterlerin listesini getirir.

  void getCharacters() async {
    _charactersModel = await _apiService.getCharacters();
    notifyListeners();
  }

//Todo Bu fonksiyon mevcut karakterlerin listesine yeni karakterler ekler.Burada kullanılan info.next url adresi içeriyor. Bu adresi kullanarak yeni karakterlerin listesini getiririz.

  bool loadMore = false;
  int currentPageIndex = 1;
  void setLoadMore(bool value) {
    loadMore = value;
    notifyListeners();
  }

  void getCharactersMore() async {
    //! Eğer zaten bir yükleme işlemi varsa tekrar yükleme işlemi yapmamak için bu kontrolü yaparız.
    if (loadMore) return;
    //! eğer son sayfa ise yeniden yükleme işlemi yapmak için.
    if (_charactersModel!.info.pages == currentPageIndex) return;
    setLoadMore(true);
    final data =
        await _apiService.getCharacters(url: _charactersModel?.info.next);
    setLoadMore(false);
    _charactersModel!.info = data.info;
    _charactersModel!.characters.addAll(data.characters);
    notifyListeners();
  }

  void getCharactersByName(String name) async {
    clearCharacters();
    _charactersModel = await _apiService.getCharacters(args: {'name': name});
    notifyListeners();
  }
}

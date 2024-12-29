import 'package:flutter/material.dart';
import 'package:rickyandmorty/app/locator.dart';
import 'package:rickyandmorty/models/characters_model.dart';
import 'package:rickyandmorty/services/api_service.dart';

class ResidentViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  List<CharacterModel> _residents = [];
  List<CharacterModel> get residents => _residents;

  void getResidents(List residentsUrlList) async {
    _residents = await _apiService
        .getCharactersFromUrlList(residentsUrlList.map((e) => e.toString()).toList());
    notifyListeners();
  }
}

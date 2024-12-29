import 'package:flutter/material.dart';
import 'package:rickyandmorty/app/locator.dart';
import 'package:rickyandmorty/models/characters_model.dart';
import 'package:rickyandmorty/services/api_service.dart';
import 'package:rickyandmorty/services/preferences_service.dart';

class FavouritesViewmodel extends ChangeNotifier { 
  final _preferencesApi = locator<PreferencesService>();
  final _apiService = locator<ApiService>();
  List<int> _favourites = [];


  List<CharacterModel> _charactersModel = [];
  List<CharacterModel> get characters => _charactersModel;




  void getFavourites() {
    _favourites = _preferencesApi.getSavedCharacters();
    notifyListeners();
  }


  void _getCharacters() async{
    _charactersModel = await _apiService.getMultipleCharacters(_favourites);
    notifyListeners();
  }




 }
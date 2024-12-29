import 'package:flutter/material.dart';
import 'package:rickyandmorty/app/locator.dart';
import 'package:rickyandmorty/models/episode_model.dart';

import '../../../services/api_service.dart';

class CharacterProfileViewmodel extends ChangeNotifier {
  final _apiService = locator<ApiService>();

  List<EpisodeModel> _episodes = [];
  List<EpisodeModel> get episodes => _episodes;

  void getEpisodes(List<String> urlList) async {
    _episodes = await _apiService.getMultipleEpisodes(urlList);
    notifyListeners();
  }
}

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  SharedPreferences prefs;
  PreferencesService({required this.prefs});


  final String _characterKey = 'characters';

  void saveCharacter(int id) async {
    final charactersList = prefs.getStringList(_characterKey) ?? [];
    charactersList.add(id.toString());
    await prefs.setStringList(_characterKey, charactersList);
  }


  void removeCharacter(int id) async {
    final charactersList = prefs.getStringList(_characterKey) ?? [];
    charactersList.remove(id.toString());
    await prefs.setStringList(_characterKey, charactersList);
  }



  List<int> getSavedCharacters() {
    final charactersList = prefs.getStringList(_characterKey) ?? [];
    return charactersList.map((e) => int.parse(e)).toList();
  }



}
import 'package:flutter/material.dart';
import 'package:rickyandmorty/app/locator.dart';
import '../../models/characters_model.dart';
import '../../services/preferences_service.dart';
import 'character_cardview.dart';

class CharacterCardListView extends StatefulWidget {
  final List<CharacterModel> characters;
  final VoidCallback? onLoadMore;
  final bool loadMore;
  const CharacterCardListView(
      {super.key,
      required this.characters,
      this.onLoadMore,
      this.loadMore = false});

  @override
  State<CharacterCardListView> createState() => _CharacterCardListViewState();
}

class _CharacterCardListViewState extends State<CharacterCardListView> {
  final _scrollController = ScrollController();
  bool _isLoading = true;
  List <int> _favoritedList = [];

  @override
  void initState() {
    super.initState();
  }

  void _setIsLoading(bool value) {
    _isLoading = value;
    setState(() {});
  }

  void _getFavorites(){
    _favoritedList = locator<PreferencesService>().getSavedCharacters();
    _setIsLoading(false);
    setState(() {
      
    });
  }

  void _detectScrollBottom() {
   if(widget.onLoadMore != null){
    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentPositon = _scrollController.position.pixels;
      const int delta = 200;

      if (maxScroll - currentPositon <= delta) {
        widget.onLoadMore!();
      }
    });
   }
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading){
      return const CircularProgressIndicator.adaptive();
    }else {
         return Flexible(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.characters.length,
        itemBuilder: (context, index) {
          final characterModel = widget.characters[index];
            final bool isFavorited = _favoritedList.contains(characterModel.id);
          return Column(
            children: [
              CharacterCardview(
                characterModel: characterModel, isFavorited: isFavorited,
              
              ),
              if (widget.loadMore && index == widget.characters.length - 1)
                const CircularProgressIndicator.adaptive()
            ],
          );
        },
      ),
    );
    }
   
  }
}

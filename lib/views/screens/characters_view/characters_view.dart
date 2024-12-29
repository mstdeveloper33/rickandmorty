//! Bu dosya karakterlerin listelendiği ekranın tasarımını içerir.Burada kesinlikle api servisleri çağrılmaz sadece tasarım yapılır. Api servislerini çağırmak için viewmodel dosyaları kullanılır. Bu viewmodel dosyalarında ayrıca state management işlemleri de yapılır.Bu sayede viewmodel ve view dosyaları birbirinden ayrılmış olur ve kodun okunabilirliği artar.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickyandmorty/views/widgets/appbar_widget.dart';
import 'package:rickyandmorty/views/widgets/character_card_listview.dart';
import 'characters_viewmodel.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  @override
  void initState() {
    super.initState();
    context.read<CharactersViewmodel>().getCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<CharactersViewmodel>();
    return Scaffold(
      appBar: const AppbarWidget(title: "Rick and Morty"),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: Column(
            children: [
              _searchInputWidget(context, viewModel: viewModel),
              viewModel.charactersModel == null
                  ? const CircularProgressIndicator.adaptive()
                  : CharacterCardListView(
                      characters: viewModel.charactersModel!.characters,
                      onLoadMore: () => viewModel.getCharactersMore(),
                      loadMore: viewModel.loadMore,
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchInputWidget(BuildContext context,
      {required CharactersViewmodel viewModel}) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 16),
      child: TextFormField(
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) => viewModel.getCharactersByName,
        decoration: InputDecoration(
          hintText: "Karakterlerde Ara",
          hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
          suffixIcon:
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          prefixIcon: const Icon(Icons.search),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

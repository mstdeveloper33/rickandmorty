import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rickyandmorty/app/locator.dart';
import 'package:rickyandmorty/app/router.dart';
import 'package:rickyandmorty/models/characters_model.dart';

import '../../services/preferences_service.dart';

class CharacterCardview extends StatefulWidget {
  final CharacterModel characterModel;
  bool isFavorited;
  CharacterCardview(
      {super.key, required this.characterModel, this.isFavorited = false});

  @override
  State<CharacterCardview> createState() => _CharacterCardviewState();
}

class _CharacterCardviewState extends State<CharacterCardview> {
  void _favoriteCharacter() {
    if (widget.isFavorited) {
      locator<PreferencesService>().removeCharacter(widget.characterModel.id);
      widget.isFavorited = false;
    } else {
      locator<PreferencesService>().saveCharacter(widget.characterModel.id);
      widget.isFavorited = true;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(
          AppRoutes.characterProfile, extra: widget.characterModel,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 7),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Hero(
                      tag: widget.characterModel.image,
                      child: Image.network(
                        widget.characterModel.image,
                        height: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 17, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.characterModel.name,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 7),
                        _infoWidget(
                            type: "Köken",
                            value: widget.characterModel.origin.name),
                        _infoWidget(
                            type: "Durum",
                            value:
                                "${widget.characterModel.status} - ${widget.characterModel.species}"),
                      ],
                    ),
                  )
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                _favoriteCharacter();
              },
              icon: Icon(
                  widget.isFavorited ? Icons.bookmark : Icons.bookmark_border),
            )
          ],
        ),
      ),
    );
  }

  Column _infoWidget({required String type, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w300),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

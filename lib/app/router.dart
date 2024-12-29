import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rickyandmorty/models/characters_model.dart';
import 'package:rickyandmorty/models/episode_model.dart';
import 'package:rickyandmorty/views/screens/favourites_view/favourites_view.dart';
import 'package:rickyandmorty/views/screens/locations_view/locations_view.dart';
import 'package:rickyandmorty/views/screens/resident_view/resident_viewmodel.dart';
import 'package:rickyandmorty/views/screens/section_characters_view/section_characters_view.dart';
import 'package:rickyandmorty/views/screens/section_characters_view/section_characters_viewmodel.dart';
import 'package:rickyandmorty/views/screens/sections_view/sections_view.dart';
import '../models/location_model.dart';
import '../views/app_view.dart';
import '../views/screens/character_profile_view/character_profile_view.dart';
import '../views/screens/characters_view/characters_view.dart';
import '../views/screens/characters_view/characters_viewmodel.dart';
import '../views/screens/favourites_view/favourites_viewmodel.dart';
import '../views/screens/locations_view/location_viewmodel.dart';
import '../views/screens/resident_view/resident_view.dart';
import '../views/screens/sections_view/sections_viewmodel.dart';

final _routerKey = GlobalKey<NavigatorState>();

class AppRoutes {
  AppRoutes._();

  static const String characters = '/';
  static const String favourites = '/favourites';
  static const String locations = '/locations';
  static const String sections = '/sections';

  static const String profileRoute = 'characterProfile';
  static const String characterProfile = '/characterProfile';

  static const String residentsRoute = 'residents';
  static const String residents = '/locations/residents';

  static const String sectionCharactersRoute = "characters";
  static const String sectionCharacters = "/sections/characters";
}

final router = GoRouter(
  initialLocation: AppRoutes.characters,
  navigatorKey: _routerKey,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppView(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
                path: AppRoutes.characters,

                //? Burada ChangeNotifierProvider ile CharactersViewmodel sınıfını oluşturuyoruz ve bu sınıfı CharactersView sınıfına provider olarak veriyoruz. Böylece CharactersViewmodel sınıfındaki değişiklikler CharactersView sınıfına yansıtılmış olur.
                builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => CharactersViewmodel(),
                    child: const CharactersView()),
                routes: [
                  GoRoute(
                    path: AppRoutes.profileRoute,
                    builder: (context, state) => CharacterProfileView(
                        characterModel: state.extra as CharacterModel),
                  )
                ])
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.favourites,
              builder: (context, state) => ChangeNotifierProvider(
                  create: (context) => FavouritesViewmodel(),
                  child: const FavouritesView()),
            )
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.locations,
              builder: (context, state) => ChangeNotifierProvider(
                  create: (context) => LocationViewmodel(),
                  child: const LocationsView()),
              routes: [
                GoRoute(
                  path: AppRoutes.residentsRoute,
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => ResidentViewmodel(),
                    child:
                        ResidentView(locationItem: state.extra as LocationItem),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: AppRoutes.sections,
              builder: (context, state) => ChangeNotifierProvider(
                create: (context) => SectionsViewmodel(),
                child: const SectionsView(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.sectionCharactersRoute,
                  builder: (context, state) => ChangeNotifierProvider(
                    create: (context) => SectionCharactersViewmodel(),
                    child: SectionCharactersView(
                        episodeModel: state.extra as EpisodeModel),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

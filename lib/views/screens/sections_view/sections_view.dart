import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickyandmorty/views/screens/sections_view/sections_viewmodel.dart';
import 'package:rickyandmorty/views/widgets/appbar_widget.dart';
import 'package:rickyandmorty/views/widgets/decorated_container.dart';
import 'package:rickyandmorty/views/widgets/episodes_listview.dart';

class SectionsView extends StatefulWidget {
  const SectionsView({super.key});

  @override
  State<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends State<SectionsView> {
  @override
  void initState() {
    super.initState();
    context.read<SectionsViewmodel>().getEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const AppbarWidget(
          title: "Bölümler",
          transparentBackground: true,
        ),
        body: DecoratedContainer(
            topChild: const SizedBox(),
            child: Consumer<SectionsViewmodel>(
              builder: (context, viewModel, child) {
                if (viewModel.episodesModel == null) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: EpisodesListView(
                        loadMore: viewModel.loadMore,
                        onLoadMore: viewModel.onLoadMore,
                        episodes: viewModel.episodesModel!.episodes),
                  );
                }
              },
            )),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/ui/pages/home/library/geners/bloc/geners_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class GenersScreen extends StatefulWidget {
  const GenersScreen({super.key});

  @override
  State<GenersScreen> createState() => _GenersScreenState();
}

class _GenersScreenState extends State<GenersScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late List<GenreModel> genres;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<GenersBloc, GenersState>(
      builder: (context, state) {
        if (state is GenersLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        genres = GenersBloc.genres;
        return GridView.builder(
          padding: const EdgeInsets.all(24),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: 1 / 1),
          itemCount: genres.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            GenreModel genre = genres[index];
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.primary),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(CupertinoIcons.guitars),
                  Text(
                    genre.genre,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

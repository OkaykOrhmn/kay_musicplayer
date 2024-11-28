import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/core/routes/route_generator.dart';
import 'package:kay_musicplayer/main.dart';
import 'package:kay_musicplayer/ui/pages/home/library/tracks/bloc/tracks_bloc.dart';
import 'package:kay_musicplayer/ui/widgets/components/player/song_container.dart';

class TracksScreen extends StatefulWidget {
  const TracksScreen({
    super.key,
  });

  @override
  State<TracksScreen> createState() => _TracksScreenState();
}

class _TracksScreenState extends State<TracksScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final ScrollController scrollController = ScrollController();
  List<MediaItem> tracks = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TracksBloc, TracksState>(
      builder: (context, state) {
        if (state is TracksLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        tracks = TracksBloc.tracks;
        return Scrollbar(
          controller: scrollController,
          radius: const Radius.circular(16),
          thumbVisibility: true, // Always show the scrollbar thumb
          child: ListView.builder(
            controller: scrollController,
            itemCount: tracks.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              MediaItem song = tracks[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.player);
                },
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: song.extras!['activate']
                          ? Theme.of(context).colorScheme.primary
                          : null),
                  child: SongContainer(
                    song: song,
                    onClick: () {
                      audioHandler.changeQueue(songs: tracks);
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

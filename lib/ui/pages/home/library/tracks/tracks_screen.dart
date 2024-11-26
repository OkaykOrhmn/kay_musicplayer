import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/core/routes/route_generator.dart';
import 'package:kay_musicplayer/ui/pages/home/library/tracks/bloc/tracks_bloc.dart';
import 'package:kay_musicplayer/ui/widgets/components/player/song_container.dart';
import 'package:on_audio_query/on_audio_query.dart';

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

  late final ScrollController _scrollController = ScrollController();
  List<SongModel> tracks = [];

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
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
          radius: const Radius.circular(16),
          thumbVisibility: true, // Always show the scrollbar thumb
          child: ListView.builder(
            itemCount: tracks.length,
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              SongModel song = tracks[index];
              return InkWell(
                  onTap: () => Navigator.pushNamed(context, Routes.player,
                      arguments: song),
                  child: SongContainer(song: song));
            },
          ),
        );
      },
    );
  }
}

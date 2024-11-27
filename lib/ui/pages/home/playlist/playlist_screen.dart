import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/ui/pages/home/playlist/bloc/play_list_bloc.dart';
import 'package:kay_musicplayer/ui/widgets/components/player/playlist_container.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({super.key});

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  late List<PlaylistModel> playLists;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayListBloc, PlayListState>(
      builder: (context, state) {
        if (state is PlayListLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        playLists = PlayListBloc.playLists;
        return Scrollbar(
          controller: scrollController,
          radius: const Radius.circular(16),
          thumbVisibility: true, // Always show the scrollbar thumb
          child: ListView.builder(
            controller: scrollController,
            itemCount: playLists.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              PlaylistModel playlist = playLists[index];
              return PlaylistContainer(playlist: playlist);
            },
          ),
        );
      },
    );
  }
}

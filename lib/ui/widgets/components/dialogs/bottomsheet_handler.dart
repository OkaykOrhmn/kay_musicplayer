// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/core/services/fetch_songs.dart';
import 'package:kay_musicplayer/main.dart';
import 'package:kay_musicplayer/ui/pages/home/playlist/bloc/play_list_bloc.dart';
import 'package:kay_musicplayer/ui/widgets/components/player/playlist_container.dart';
import 'package:kay_musicplayer/ui/widgets/components/player/song_container.dart';

class BottomsheetHandler {
  final BuildContext context;

  BottomsheetHandler(this.context);

  Future showPlaylist() async {
    showBottomSheet(
      context: context,
      enableDrag: true,
      showDragHandle: true,
      builder: (context) {
        final tracks = audioHandler.queue.value;
        return ListView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: tracks.length,
          itemBuilder: (context, index) {
            final song = tracks[index];
            return SongContainer(
              song: song,
              navigate: false,
              onClick: () {
                Navigator.pop(context);
              },
            );
          },
        );
      },
    );
  }

  Future showAddToPlaylists({required final int audioId}) async {
    final pl = await FetchPlayList().getPlaylists();
    await showModalBottomSheet(
      context: context,
      enableDrag: true,
      showDragHandle: true,
      builder: (context) {
        return ListView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          itemCount: pl.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final playlist = pl[index];
            return InkWell(
                onTap: () async {
                  final success = await FetchPlayList()
                      .addToPlayList(playlistId: playlist.id, audioId: audioId);
                  if (success) {
                    context.read<PlayListBloc>().add(GetAllPlayLists());
                    Navigator.pop(context);
                  } else {
                    //TODO snackbar
                  }
                },
                child: PlaylistContainer(playlist: playlist));
          },
        );
      },
    );
  }
}

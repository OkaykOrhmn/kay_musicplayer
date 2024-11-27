import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistContainer extends StatelessWidget {
  final PlaylistModel playlist;
  const PlaylistContainer({super.key, required this.playlist});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        playlist.playlist,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        '${playlist.numOfSongs} Tracks',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: const Icon(
        CupertinoIcons.music_note_list,
        size: 50,
      ),
      // trailing: leading,
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerContainer extends StatelessWidget {
  final SongModel song;
  const PlayerContainer({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(
          song.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          song.artist ?? 'Unknown',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: QueryArtworkWidget(
          id: song.id,
          type: ArtworkType.AUDIO,
          artworkBorder: BorderRadius.circular(16),
          artworkFit: BoxFit.cover,
          format: ArtworkFormat.JPEG,
          keepOldArtwork: true,
          nullArtworkWidget: Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.primary),
              child: const Icon(CupertinoIcons.music_note)),
        ));
  }
}

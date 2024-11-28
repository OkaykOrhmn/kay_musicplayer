import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/core/utils.dart';
import 'package:kay_musicplayer/data/model/playlist_menu_args.dart';
import 'package:kay_musicplayer/main.dart';
import 'package:kay_musicplayer/ui/pages/player/bloc/playlist_menu_bloc.dart';
import 'package:kay_musicplayer/ui/widgets/components/player/song_container.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistMenuPage extends StatefulWidget {
  final PlaylistMenuArgs args;
  const PlaylistMenuPage({super.key, required this.args});

  @override
  State<PlaylistMenuPage> createState() => _PlaylistMenuPageState();
}

class _PlaylistMenuPageState extends State<PlaylistMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: QueryArtworkWidget(
                  artworkWidth: double.infinity,
                  artworkHeight: double.infinity,
                  id: widget.args.id,
                  quality: 100,
                  artworkQuality: FilterQuality.high,
                  size: 1000,
                  type:
                      getArtworkTypeFromAudiosFromType(type: widget.args.where),
                  artworkBorder: BorderRadius.circular(16),
                  artworkFit: BoxFit.cover,
                  format: ArtworkFormat.PNG,
                  keepOldArtwork: true,
                  nullArtworkWidget: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context).colorScheme.primary),
                      child: Icon(
                        CupertinoIcons.music_note_2,
                        size: MediaQuery.sizeOf(context).width / 4,
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              widget.args.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            if (widget.args.desc != null)
              Column(
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    widget.args.desc!,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Play All'))),
                  const SizedBox(
                    width: 32,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {}, child: const Text('Shuffle')))
                ],
              ),
            ),
            ListTile(
              title: Text(
                'Tracks',
                style: Theme.of(context).textTheme.labelLarge,
              ),
              trailing: widget.args.count == 0
                  ? null
                  : Text(
                      '${widget.args.count}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
            ),
            BlocBuilder<PlaylistMenuBloc, PlaylistMenuState>(
              builder: (context, state) {
                if (state is PlaylistMenuLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PlaylistMenuSuccess) {
                  final tracks = state.tracks;
                  if (tracks.isEmpty) {
                    return const Text('Empty');
                  } else {
                    return ListView.builder(
                      itemCount: tracks.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final track = tracks[index];
                        return SongContainer(
                          song: track,
                          onClick: () {
                            audioHandler.changeQueue(songs: tracks);
                          },
                        );
                      },
                    );
                  }
                } else {
                  return const Center(
                    child: Text('Error'),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

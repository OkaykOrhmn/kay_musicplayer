import 'package:audio_service/audio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:kay_musicplayer/core/routes/route_generator.dart';
import 'package:kay_musicplayer/main.dart';
import 'package:kay_musicplayer/ui/pages/home/cubit/active_media_item_cubit.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongContainer extends StatefulWidget {
  final MediaItem song;
  final Widget? leading;
  final bool progressWork;
  final bool navigate;
  final Function()? onClick;
  const SongContainer(
      {super.key,
      required this.song,
      this.leading,
      this.progressWork = true,
      this.navigate = true,
      this.onClick});

  @override
  State<SongContainer> createState() => _SongContainerState();
}

class _SongContainerState extends State<SongContainer> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveMediaItemCubit, MediaItem?>(
      builder: (context, state) {
        if (state != null) {
          active = state == widget.song && widget.progressWork;
        }
        return InkWell(
          onTap: () {
            widget.onClick?.call();

            if (!active) {
              audioHandler.skipToQueueItem(widget.song.extras!['index']);
            }
            if (widget.navigate) {
              Navigator.pushNamed(context, Routes.player);
            }
          },
          child: ListTile(
            title: Text(
              widget.song.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: active ? Theme.of(context).colorScheme.primary : null),
            ),
            subtitle: Text(
              widget.song.artist ?? 'Unknown',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: active ? Theme.of(context).colorScheme.primary : null),
            ),
            leading: Stack(
              children: [
                QueryArtworkWidget(
                  id: widget.song.extras!['songId'],
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
                ),
                if (active)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(16)),
                      child: StreamBuilder<PlaybackState>(
                          stream: audioHandler.playbackState.stream,
                          builder: (context, playbackState) {
                            if (playbackState.data == null) {
                              return const SizedBox.shrink();
                            }
                            bool playing = playbackState.data!.playing;

                            return Center(
                                child: playing
                                    ? SpinKitWave(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        size: 25,
                                      )
                                    : SizedBox(
                                        width: 32,
                                        height: 2,
                                        child: Row(
                                          children: List.generate(
                                            5,
                                            (index) => Expanded(
                                              child: Container(
                                                width: 5,
                                                height: 2,
                                                decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ));
                          }),
                    ),
                  )
              ],
            ),
            trailing: widget.leading,
          ),
        );
      },
    );
  }
}

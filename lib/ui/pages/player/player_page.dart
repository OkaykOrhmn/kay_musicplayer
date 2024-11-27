import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kay_musicplayer/main.dart';
import 'package:kay_musicplayer/ui/pages/home/library/tracks/bloc/tracks_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerPage extends StatefulWidget {
  const PlayerPage({super.key});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late MediaItem song;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          more(),
        ],
      ),
      body: StreamBuilder<MediaItem?>(
          stream: audioHandler.mediaItem,
          builder: (context, item) {
            if (item.data == null) return const SizedBox.shrink();
            song = item.data!;
            context.read<TracksBloc>().add(SetActivateTrack(song: song));
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                songImage(),
                Text(
                  song.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  song.artist ?? 'Unkown',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 24,
                ),
                playerSlider(),
                const SizedBox(
                  height: 24,
                ),
                mainButtons(),
                const SizedBox(
                  height: 24,
                ),
                subButtons(context),
                const SizedBox(
                  height: 32,
                ),
              ],
            );
          }),
    );
  }

  PopupMenuButton<String> more() {
    return PopupMenuButton<String>(
      onSelected: (value) {},
      itemBuilder: (BuildContext context) {
        return {
          'Go to Album',
          'Go to Artist',
          'set as Ringstone',
          'Edit Music',
          'Share',
          'Delete from Device',
          'Details'
        }.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  Container subButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primary),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.add)),
          IconButton(
              onPressed: () {
                final position = audioHandler.audioPlayer.position;
                if (position.inSeconds <= 10) return;
                final seekBackward = Duration(seconds: position.inSeconds - 10);
                audioHandler.seek(seekBackward);
              },
              icon: const Icon(Icons.replay_10_rounded)),
          StreamBuilder<LoopMode>(
              stream: audioHandler.audioPlayer.loopModeStream,
              builder: (context, loopMode) {
                if (loopMode.data == null) {
                  return const SizedBox.shrink();
                }
                return IconButton(
                    onPressed: () {
                      final shuffleModeEnabled =
                          audioHandler.audioPlayer.shuffleModeEnabled;
                      if (loopMode.data == LoopMode.off) {
                        audioHandler.setRepeatMode(AudioServiceRepeatMode.one);
                      } else if (loopMode.data == LoopMode.one) {
                        audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
                      } else if (loopMode.data == LoopMode.all &&
                          !shuffleModeEnabled) {
                        audioHandler
                            .setShuffleMode(AudioServiceShuffleMode.all);
                        audioHandler.setRepeatMode(AudioServiceRepeatMode.all);
                      } else {
                        audioHandler
                            .setShuffleMode(AudioServiceShuffleMode.none);
                        audioHandler.setRepeatMode(AudioServiceRepeatMode.none);
                      }
                    },
                    icon: Icon(
                      loopMode.data == LoopMode.one
                          ? CupertinoIcons.repeat_1
                          : loopMode.data == LoopMode.all &&
                                  audioHandler.audioPlayer.shuffleModeEnabled
                              ? CupertinoIcons.shuffle
                              : CupertinoIcons.repeat,
                      color: loopMode.data == LoopMode.off
                          ? IconTheme.of(context).color?.withOpacity(0.4)
                          : null,
                    ));
              }),
          IconButton(
              onPressed: () {
                final position = audioHandler.audioPlayer.position;
                final duration = song.duration!;
                if (position.inSeconds >= duration.inSeconds - 10) return;
                final seekForward = Duration(seconds: position.inSeconds + 10);
                audioHandler.seek(seekForward);
              },
              icon: const Icon(Icons.forward_10_rounded)),
          IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.music_note_list)),
        ],
      ),
    );
  }

  Widget mainButtons() {
    return StreamBuilder<PlaybackState>(
        stream: audioHandler.playbackState.stream,
        builder: (context, playbackState) {
          if (playbackState.data == null) return const SizedBox.shrink();
          bool playing = playbackState.data!.playing;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder<double>(
                    stream: audioHandler.audioPlayer.speedStream,
                    builder: (context, speed) {
                      if (speed.data == null) return const SizedBox.shrink();
                      return IconButton(
                          onPressed: () {
                            if (speed.data == 2) {
                              audioHandler.setSpeed(0.5);
                              return;
                            }
                            audioHandler.setSpeed(speed.data! + 0.25);
                          },
                          icon: Text(
                            'X${speed.data!}',
                            style: Theme.of(context).textTheme.labelLarge,
                          ));
                    }),
                IconButton(
                    onPressed: () {
                      audioHandler.skipToPrevious();
                    },
                    icon: const Icon(CupertinoIcons.backward_end_fill)),
                IconButton(
                    onPressed: () {
                      if (playing) {
                        audioHandler.pause();
                      } else {
                        audioHandler.play();
                      }
                    },
                    icon: Icon(
                      playing ? Icons.pause_outlined : Icons.play_arrow_rounded,
                      size: 64,
                    )),
                IconButton(
                    onPressed: () {
                      audioHandler.skipToNext();
                    },
                    icon: const Icon(CupertinoIcons.forward_end_fill)),
                IconButton(
                    onPressed: () {}, icon: const Icon(CupertinoIcons.heart)),
              ],
            ),
          );
        });
  }

  Widget playerSlider() {
    return StreamBuilder<Duration>(
        stream: audioHandler.audioPlayer.positionStream,
        builder: (context, position) {
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: ProgressBar(
                progress: position.data ?? Duration.zero,
                total: song.duration!,
                onSeek: (value) {
                  audioHandler.seek(value);
                },
              ));
        });
  }

  Widget songImage() {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: QueryArtworkWidget(
                artworkWidth: double.infinity,
                artworkHeight: double.infinity,
                id: song.extras!['songId'],
                quality: 100,
                artworkQuality: FilterQuality.high,
                size: 1000,
                type: ArtworkType.AUDIO,
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
            height: 32,
          ),
        ],
      ),
    );
  }
}

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  AudioPlayer audioPlayer = AudioPlayer();

  UriAudioSource _createAudioSource(MediaItem item) {
    return ProgressiveAudioSource(Uri.parse(item.id));
  }

  void _listenForCurrentSongIndexChanges() {
    audioPlayer.currentIndexStream.listen(
      (index) {
        final playList = queue.value;
        if (index == null || playList.isEmpty) return;
        mediaItem.add(playList[index]);
      },
    );
  }

  void _broadcastState(PlaybackEvent event) {
    playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (audioPlayer.playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
          MediaAction.setShuffleMode,
          MediaAction.setRepeatMode,
        },
        processingState: {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[audioPlayer.processingState]!,
        playing: audioPlayer.playing,
        updatePosition: audioPlayer.position,
        bufferedPosition: audioPlayer.bufferedPosition,
        speed: audioPlayer.speed,
        queueIndex: event.currentIndex));
  }

  Future initSongs({required List<MediaItem> songs}) async {
    audioPlayer.playbackEventStream.listen(_broadcastState);

    final audioSource = songs.map(_createAudioSource);

    await audioPlayer.setAudioSource(
        ConcatenatingAudioSource(children: audioSource.toList()));

    final newQueue = queue.value..addAll(songs);
    queue.add(newQueue);

    _listenForCurrentSongIndexChanges();

    audioPlayer.processingStateStream.listen(
      (state) {
        if (state == ProcessingState.completed) skipToNext();
      },
    );
  }

  @override
  Future play() async => audioPlayer.play();

  @override
  Future pause() async => audioPlayer.pause();

  @override
  Future seek(Duration position) async => audioPlayer.seek(position);

  @override
  Future setSpeed(double speed) async => audioPlayer.setSpeed(speed);

  @override
  Future skipToQueueItem(int index) async {
    await audioPlayer.seek(Duration.zero, index: index);
    play();
  }

  @override
  Future skipToNext() async => audioPlayer.seekToNext();

  @override
  Future skipToPrevious() async => audioPlayer.seekToPrevious();

  @override
  Future setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    if (shuffleMode == AudioServiceShuffleMode.none) {
      audioPlayer.setShuffleModeEnabled(false);
    } else {
      audioPlayer.setShuffleModeEnabled(true);
    }
  }

  @override
  Future setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    switch (repeatMode) {
      case AudioServiceRepeatMode.none:
        audioPlayer.setLoopMode(LoopMode.off);

        break;
      case AudioServiceRepeatMode.one:
        audioPlayer.setLoopMode(LoopMode.one);

        break;
      default:
        audioPlayer.setLoopMode(LoopMode.all);
    }
  }

  Future shuffleIt(bool active) async =>
      audioPlayer.setShuffleModeEnabled(active);
}

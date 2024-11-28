import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

ArtworkType getArtworkTypeFromAudiosFromType(
    {required final AudiosFromType type}) {
  switch (type) {
    case AudiosFromType.ALBUM || AudiosFromType.ALBUM_ID:
      return ArtworkType.ALBUM;
    case AudiosFromType.ARTIST || AudiosFromType.ARTIST_ID:
      return ArtworkType.ARTIST;
    case AudiosFromType.GENRE || AudiosFromType.GENRE_ID:
      return ArtworkType.GENRE;
    case AudiosFromType.PLAYLIST:
      return ArtworkType.PLAYLIST;
    default:
      return ArtworkType.AUDIO;
  }
}

AudioServiceRepeatMode getAudioServiceRepeatModeFromLoopMode(
    {required final LoopMode loop}) {
  switch (loop) {
    case LoopMode.all:
      return AudioServiceRepeatMode.all;
    case LoopMode.one:
      return AudioServiceRepeatMode.one;
    case LoopMode.off:
      return AudioServiceRepeatMode.none;
    default:
      return AudioServiceRepeatMode.none;
  }
}

AudioServiceShuffleMode getAudioServiceShuffleModeFromShuffleEnabled(
    {required final bool shuffle}) {
  if (shuffle) {
    return AudioServiceShuffleMode.all;
  } else {
    return AudioServiceShuffleMode.none;
  }
}

MediaItem getMediaItemFromSongModel(
    {required final SongModel song,
    required final int count,
    final Uint8List? unit8list,
    required final List<int> bytes}) {
  return MediaItem(
      id: song.uri!,
      title: song.title,
      artist: song.artist,
      album: song.album,
      genre: song.genre,
      duration: Duration(milliseconds: song.duration!),
      displayTitle: song.displayName,
      artUri: unit8list == null ? null : Uri.dataFromBytes(bytes),
      extras: {'songId': song.id, 'index': count, 'activate': false});
}

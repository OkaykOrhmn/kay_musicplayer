import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/core/services/fetch_songs.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'like_music_state.dart';

class LikeMusicCubit extends Cubit<LikeMusicState> {
  LikeMusicCubit() : super(LikeMusicInitial());

  Future<int> _getId() async {
    final pls = await FetchPlayList().getPlaylists();
    int id = 0;
    for (var p in pls) {
      if (p.playlist == 'Favorites') {
        id = p.id;
      }
    }
    return id;
  }

  void setLiked({required final int audioId}) async {
    emit(LikeMusicLoading());
    final id = await _getId();
    final success =
        await FetchPlayList().addToPlayList(playlistId: id, audioId: audioId);
    emit(success ? LikeMusicLiked() : LikeMusicNotLiked());
  }

  void setNotLiked({required final int audioId}) async {
    emit(LikeMusicLoading());
    final id = await _getId();

    final success = await FetchPlayList()
        .removeFromPlaylist(playlistId: id, audioId: audioId);
    emit(success ? LikeMusicNotLiked() : LikeMusicLiked());
  }

  void getLike(MediaItem song) async {
    emit(LikeMusicLoading());
    final id = await _getId();

    final trks =
        await FetchSongs().getSongsFrom(where: AudiosFromType.PLAYLIST, id: id);
    emit(trks.contains(song) ? LikeMusicLiked() : LikeMusicNotLiked());
  }
}

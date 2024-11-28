import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kay_musicplayer/core/services/fetch_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'playlist_menu_event.dart';
part 'playlist_menu_state.dart';

class PlaylistMenuBloc extends Bloc<PlaylistMenuEvent, PlaylistMenuState> {
  PlaylistMenuBloc() : super(PlaylistMenuInitial()) {
    on<PlaylistMenuEvent>((event, emit) async {
      if (event is GetTracksFrom) {
        try {
          emit(PlaylistMenuLoading());
          final trks =
              await FetchSongs().getSongsFrom(id: event.id, where: event.where);
          emit(PlaylistMenuSuccess(tracks: trks));
        } catch (e) {
          emit(PlaylistMenuFail());

          if (kDebugMode) {
            print('error is $e');
          }
        }
      }
    });
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kay_musicplayer/core/services/fetch_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'play_list_event.dart';
part 'play_list_state.dart';

class PlayListBloc extends Bloc<PlayListEvent, PlayListState> {
  static List<PlaylistModel> playLists = [];
  PlayListBloc() : super(PlayListInitial()) {
    on<PlayListEvent>((event, emit) async {
      if (event is GetAllPlayLists) {
        emit(PlayListLoading());
        try {
          playLists.clear();
          final pLists = await FetchPlayList().getPlaylists();
          playLists.addAll(pLists);
          emit(PlayListSuccess());
        } catch (e) {
          if (kDebugMode) {
            print('error is :$e');
          }
          emit(PlayListFail());
        }
      }
    });
  }
}

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:kay_musicplayer/core/services/fetch_songs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/main.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'tracks_event.dart';
part 'tracks_state.dart';

class TracksBloc extends Bloc<TracksEvent, TracksState> {
  static final List<MediaItem> tracks = [];

  TracksBloc() : super(TracksInitial()) {
    on<TracksEvent>((event, emit) async {
      if (event is GetAllTracks) {
        emit(TracksLoading());
        try {
          tracks.clear();
          final songs =
              await FetchSongs().execute(orderType: OrderType.ASC_OR_SMALLER);
          tracks.addAll(songs);
          audioHandler.initSongs(songs: songs);
          emit(TracksSuccess());
        } catch (e) {
          if (kDebugMode) {
            print('error is :$e');
          }
          emit(TracksFail());
        }
      }

      if (event is SetActivateTrack) {
        try {
          int index = tracks.indexOf(event.song);
          for (var track in tracks) {
            track.extras!['activate'] = false;
          }
          tracks[index].extras!['activate'] = true;
          if (tracks[index] != audioHandler.mediaItem.value) {
            audioHandler.skipToQueueItem(index);
          }

          emit(TracksSuccess());
        } catch (e) {
          if (kDebugMode) {
            print('error is :$e');
          }
          emit(TracksFail());
        }
      }
    });
  }
}

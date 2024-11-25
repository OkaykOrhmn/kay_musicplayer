import 'package:flutter/foundation.dart';
import 'package:kay_musicplayer/core/services/audio_library_manager.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tracks_event.dart';
part 'tracks_state.dart';

class TracksBloc extends Bloc<TracksEvent, TracksState> {
  static final List<SongModel> tracks = [];

  TracksBloc() : super(TracksInitial()) {
    on<TracksEvent>((event, emit) async {
      if (event is GetAllTracks) {
        emit(TracksLoading());
        try {
          AudioLibraryManager audioLibraryManager = AudioLibraryManager();
          await audioLibraryManager.initial();
          tracks.addAll(audioLibraryManager.playList);
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

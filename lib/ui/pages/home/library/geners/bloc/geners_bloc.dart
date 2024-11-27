import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kay_musicplayer/core/services/fetch_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'geners_event.dart';
part 'geners_state.dart';

class GenersBloc extends Bloc<GenersEvent, GenersState> {
  static List<GenreModel> genres = [];

  GenersBloc() : super(GenersInitial()) {
    on<GenersEvent>((event, emit) async {
      if (event is GetAllGeners) {
        try {
          emit(GenersLoading());
          genres.clear();
          genres = await FetchSongs().getGenres();
          emit(GenersSuccess());
        } catch (e) {
          emit(GenersFail());

          if (kDebugMode) {
            print('error is $e');
          }
        }
      }
    });
  }
}

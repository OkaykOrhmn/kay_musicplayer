import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kay_musicplayer/core/services/fetch_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'atrists_event.dart';
part 'atrists_state.dart';

class AtristsBloc extends Bloc<AtristsEvent, AtristsState> {
  static List<ArtistModel> artists = [];

  AtristsBloc() : super(AtristsInitial()) {
    on<AtristsEvent>((event, emit) async {
      if (event is GetAllArtists) {
        try {
          emit(AtristsLoading());
          artists.clear();
          artists = await FetchSongs().getArtists();
          emit(AtristsSuccess());
        } catch (e) {
          emit(AtristsFail());

          if (kDebugMode) {
            print('error is $e');
          }
        }
      }
    });
  }
}

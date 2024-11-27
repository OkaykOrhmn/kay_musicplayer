import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:kay_musicplayer/core/services/fetch_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  static List<AlbumModel> albums = [];
  AlbumsBloc() : super(AlbumsInitial()) {
    on<AlbumsEvent>((event, emit) async {
      if (event is GetAllAlbums) {
        try {
          emit(AlbumsLoading());
          albums.clear();
          albums = await FetchSongs().getAllbums();
          emit(AlbumsSuccess());
        } catch (e) {
          emit(AlbumsFail());

          if (kDebugMode) {
            print('error is $e');
          }
        }
      }
    });
  }
}

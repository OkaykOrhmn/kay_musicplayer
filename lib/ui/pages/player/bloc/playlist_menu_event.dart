part of 'playlist_menu_bloc.dart';

@immutable
sealed class PlaylistMenuEvent {}

class GetTracksFrom extends PlaylistMenuEvent {
  final AudiosFromType where;
  final dynamic id;

  GetTracksFrom({required this.where, required this.id});
}

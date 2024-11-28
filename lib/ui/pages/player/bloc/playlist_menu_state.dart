part of 'playlist_menu_bloc.dart';

@immutable
sealed class PlaylistMenuState {}

final class PlaylistMenuInitial extends PlaylistMenuState {}

final class PlaylistMenuLoading extends PlaylistMenuState {}

final class PlaylistMenuSuccess extends PlaylistMenuState {
  final List<MediaItem> tracks;

  PlaylistMenuSuccess({required this.tracks});
}

final class PlaylistMenuFail extends PlaylistMenuState {}

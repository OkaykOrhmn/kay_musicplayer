part of 'tracks_bloc.dart';

@immutable
sealed class TracksEvent {}

class GetAllTracks extends TracksEvent {}

class SetActivateTrack extends TracksEvent {
  final MediaItem song;

  SetActivateTrack({required this.song});
}

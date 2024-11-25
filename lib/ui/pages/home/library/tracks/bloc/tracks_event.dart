part of 'tracks_bloc.dart';

@immutable
sealed class TracksEvent {}

class GetAllTracks extends TracksEvent {}

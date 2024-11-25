part of 'tracks_bloc.dart';

@immutable
sealed class TracksState {}

final class TracksInitial extends TracksState {}

final class TracksLoading extends TracksState {}

final class TracksSuccess extends TracksState {}

final class TracksFail extends TracksState {}

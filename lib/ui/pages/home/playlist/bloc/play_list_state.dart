part of 'play_list_bloc.dart';

@immutable
sealed class PlayListState {}

final class PlayListInitial extends PlayListState {}

final class PlayListLoading extends PlayListState {}

final class PlayListSuccess extends PlayListState {}

final class PlayListFail extends PlayListState {}

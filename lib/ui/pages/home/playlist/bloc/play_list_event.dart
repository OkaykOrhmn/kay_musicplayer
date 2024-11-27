part of 'play_list_bloc.dart';

@immutable
sealed class PlayListEvent {}

class GetAllPlayLists extends PlayListEvent {}

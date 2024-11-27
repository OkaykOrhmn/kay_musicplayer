part of 'geners_bloc.dart';

@immutable
sealed class GenersState {}

final class GenersInitial extends GenersState {}

final class GenersLoading extends GenersState {}

final class GenersSuccess extends GenersState {}

final class GenersFail extends GenersState {}

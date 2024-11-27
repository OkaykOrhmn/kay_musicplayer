part of 'atrists_bloc.dart';

@immutable
sealed class AtristsState {}

final class AtristsInitial extends AtristsState {}

final class AtristsLoading extends AtristsState {}

final class AtristsSuccess extends AtristsState {}

final class AtristsFail extends AtristsState {}

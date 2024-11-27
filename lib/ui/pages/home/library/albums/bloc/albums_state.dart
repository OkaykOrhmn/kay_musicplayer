part of 'albums_bloc.dart';

@immutable
sealed class AlbumsState {}

final class AlbumsInitial extends AlbumsState {}

final class AlbumsLoading extends AlbumsState {}

final class AlbumsSuccess extends AlbumsState {}

final class AlbumsFail extends AlbumsState {}

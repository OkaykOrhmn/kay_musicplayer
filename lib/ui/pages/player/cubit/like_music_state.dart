part of 'like_music_cubit.dart';

@immutable
sealed class LikeMusicState {}

final class LikeMusicInitial extends LikeMusicState {}

final class LikeMusicLoading extends LikeMusicState {}

final class LikeMusicLiked extends LikeMusicState {}

final class LikeMusicNotLiked extends LikeMusicState {}

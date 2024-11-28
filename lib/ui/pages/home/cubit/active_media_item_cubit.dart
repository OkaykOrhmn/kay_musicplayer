import 'package:audio_service/audio_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActiveMediaItemCubit extends Cubit<MediaItem?> {
  ActiveMediaItemCubit() : super(null);

  void setMediaItem(MediaItem mediaItem) {
    emit(mediaItem);
  }
}

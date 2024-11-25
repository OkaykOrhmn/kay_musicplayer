import 'package:flutter/foundation.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioLibraryManager {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool _hasPermission = false;

  final List<SongModel> _playList = [];

  // int? _currentSongIndex;

  List<SongModel> get playList => _playList;
  // int? get currentSongIndex => _currentSongIndex;

  AudioLibraryManager() {
    initial();
  }

  Future initial() async {
    if (kDebugMode) {
      LogConfig logConfig = LogConfig(logType: LogType.DEBUG);
      _audioQuery.setLogConfig(logConfig);
    }
    _hasPermission = await _audioQuery.checkAndRequest(
        // retryRequest: retry,
        );
    if (_hasPermission) {
      final p = await _audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );
      _playList.addAll(p);
    } else {
      return 'Error Permission';
    }
  }
}

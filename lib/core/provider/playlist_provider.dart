import 'package:flutter/foundation.dart';
import 'package:kay_musicplayer/data/model/song.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playList = [];

  int? _currentSongIndex;

  List<Song> get playList => _playList;
  int? get currentSongIndex => _currentSongIndex;
}

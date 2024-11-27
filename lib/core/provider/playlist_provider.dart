import 'package:kay_musicplayer/core/services/fetch_songs.dart';

class PlaylistProvider {
  static Future initialize() async {
    await FetchPlayList().createPlaylis(name: 'Favorites', author: 'god');
    await FetchPlayList().createPlaylis(name: 'Recently added', author: 'god');
    await FetchPlayList().createPlaylis(name: 'Recently Played', author: 'god');
    // await FetchPlayList().createPlaylis(name: 'Most Played', author: 'god');
  }
}

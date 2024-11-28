import 'dart:convert';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:kay_musicplayer/core/utils.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

OnAudioQuery onAudioQuery = OnAudioQuery();

Future accessStorage() async => await Permission.storage.status.isGranted.then(
      (granted) async {
        if (!granted) {
          PermissionStatus permissionStatus =
              await Permission.storage.request();
          if (permissionStatus == PermissionStatus.permanentlyDenied) {
            await openAppSettings();
          }
        }
      },
    );

Future<Uint8List?> art({required int id}) async {
  return await onAudioQuery.queryArtwork(id, ArtworkType.AUDIO, quality: 100);
}

Future<Uint8List?> toImage({required Uri uri}) async {
  return base64.decode(uri.data!.toString().split(',').last);
}

class FetchSongs {
  Future<List<MediaItem>> execute(
      {final SongSortType? sortType, final OrderType? orderType}) async {
    List<MediaItem> items = [];

    await accessStorage().then(
      (_) async {
        List<SongModel> songs = await onAudioQuery.querySongs(
          sortType: sortType,
          orderType: orderType,
        );
        int count = 0;
        for (SongModel song in songs) {
          if (song.isMusic == true) {
            Uint8List? unit8list = await art(id: song.id);
            List<int> bytes = [];
            if (unit8list != null) bytes = unit8list.toList();
            items.add(getMediaItemFromSongModel(
                song: song, count: count, bytes: bytes));

            count++;
          }
        }
      },
    );
    return items;
  }

  Future<List<MediaItem>> getSongsFrom(
      {required final AudiosFromType where, required final dynamic id}) async {
    List<MediaItem> items = [];

    await accessStorage().then(
      (_) async {
        List<SongModel> songs = await onAudioQuery.queryAudiosFrom(where, id);
        int count = 0;
        for (SongModel song in songs) {
          if (song.isMusic == true) {
            Uint8List? unit8list = await art(id: song.id);
            List<int> bytes = [];
            if (unit8list != null) bytes = unit8list.toList();

            items.add(getMediaItemFromSongModel(
                song: song, count: count, bytes: bytes));
            count++;
          }
        }
      },
    );
    return items;
  }

  Future<List<AlbumModel>> getAllbums(
      {final AlbumSortType? sortType, final OrderType? orderType}) async {
    List<AlbumModel> items = [];

    await accessStorage().then(
      (_) async {
        items = await onAudioQuery.queryAlbums(
          sortType: sortType,
          orderType: orderType,
        );
      },
    );
    return items;
  }

  Future<List<GenreModel>> getGenres(
      {final GenreSortType? sortType, final OrderType? orderType}) async {
    List<GenreModel> items = [];

    await accessStorage().then(
      (_) async {
        items = await onAudioQuery.queryGenres(
          sortType: sortType,
          orderType: orderType,
        );
      },
    );
    return items;
  }

  Future<List<ArtistModel>> getArtists(
      {final ArtistSortType? sortType, final OrderType? orderType}) async {
    List<ArtistModel> items = [];

    await accessStorage().then(
      (_) async {
        items = await onAudioQuery.queryArtists(
          sortType: sortType,
          orderType: orderType,
        );
      },
    );
    return items;
  }

  Future<List<String>> getAudiosPaths() async {
    List<String> items = [];

    await accessStorage().then(
      (_) async {
        items = await onAudioQuery.queryAllPath();
      },
    );
    return items;
  }

  Future<List<MediaItem>> getFolders(
      {required final String path,
      final SongSortType? sortType,
      final OrderType? orderType}) async {
    List<MediaItem> items = [];

    await accessStorage().then(
      (_) async {
        List<SongModel> songs = await onAudioQuery.queryFromFolder(
          path,
          sortType: sortType,
          orderType: orderType,
        );
        int count = 0;

        for (SongModel song in songs) {
          if (song.isMusic == true) {
            Uint8List? unit8list = await art(id: song.id);
            List<int> bytes = [];
            if (unit8list != null) bytes = unit8list.toList();

            items.add(getMediaItemFromSongModel(
                song: song, count: count, bytes: bytes));
            count++;
          }
        }
      },
    );
    return items;
  }
}

class FetchPlayList {
  Future<List<PlaylistModel>> getPlaylists(
      {final PlaylistSortType? sortType, final OrderType? orderType}) async {
    List<PlaylistModel> items = [];

    await accessStorage().then(
      (_) async {
        items = await onAudioQuery.queryPlaylists(
          sortType: sortType,
          orderType: orderType,
        );
      },
    );
    return items;
  }

  Future<bool> createPlaylis({
    required final String name,
    final String? author,
    final String? desc,
  }) async {
    bool result = false;
    await accessStorage().then(
      (_) async {
        result = await onAudioQuery.createPlaylist(name);
      },
    );

    return result;
  }

  Future<bool> addToPlayList(
      {required final int playlistId, required final int audioId}) async {
    bool result = false;
    await accessStorage().then(
      (_) async {
        result = await onAudioQuery.addToPlaylist(playlistId, audioId);
      },
    );

    return result;
  }

  Future<bool> removePlayList({required final int playlistId}) async {
    bool result = false;
    await accessStorage().then(
      (_) async {
        result = await onAudioQuery.removePlaylist(playlistId);
      },
    );

    return result;
  }

  Future<bool> renamePlayList(
      {required final int playlistId, required final String name}) async {
    bool result = false;
    await accessStorage().then(
      (_) async {
        result = await onAudioQuery.renamePlaylist(playlistId, name);
      },
    );

    return result;
  }

  Future<bool> removeFromPlaylist(
      {required final int playlistId, required final int audioId}) async {
    bool result = false;
    await accessStorage().then(
      (_) async {
        result = await onAudioQuery.removeFromPlaylist(playlistId, audioId);
      },
    );

    return result;
  }
}

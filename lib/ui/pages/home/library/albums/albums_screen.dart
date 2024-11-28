import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/core/routes/route_generator.dart';
import 'package:kay_musicplayer/data/model/playlist_menu_args.dart';
import 'package:kay_musicplayer/ui/pages/home/library/albums/bloc/albums_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  State<AlbumsScreen> createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late List<AlbumModel> albums;
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<AlbumsBloc, AlbumsState>(
      builder: (context, state) {
        if (state is AlbumsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        albums = AlbumsBloc.albums;
        return Scrollbar(
          controller: scrollController,
          radius: const Radius.circular(16),
          thumbVisibility: true, // Always show the scrollbar thumb
          child: GridView.builder(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 24,
                crossAxisSpacing: 24,
                childAspectRatio: 1 / 1),
            itemCount: albums.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              AlbumModel album = albums[index];

              return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.playlistMenu,
                        arguments: PlaylistMenuArgs(
                          where: AudiosFromType.ALBUM_ID,
                          id: album.id,
                          name: album.album,
                          count: album.numOfSongs,
                          desc: album.artist,
                        ));
                  },
                  child: albumContainer(album));
            },
          ),
        );
      },
    );
  }

  Stack albumContainer(AlbumModel album) {
    return Stack(
      children: [
        QueryArtworkWidget(
          id: album.id,
          artworkWidth: MediaQuery.sizeOf(context).width,
          artworkHeight: MediaQuery.sizeOf(context).width,
          type: ArtworkType.ALBUM,
          artworkBorder: BorderRadius.circular(16),
          artworkFit: BoxFit.cover,
          format: ArtworkFormat.JPEG,
          keepOldArtwork: true,
          nullArtworkWidget: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.primary),
              child: const Icon(
                CupertinoIcons.music_note,
                size: 50,
              )),
        ),
        Positioned.fill(
            child: Container(
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black12,
                    Colors.black26,
                    Colors.black38,
                    Colors.black,
                  ]),
              borderRadius: BorderRadius.circular(16)),
          alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                album.album,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                album.artist ?? 'Unkown',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ))
      ],
    );
  }
}

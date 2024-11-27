import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/ui/pages/home/library/atrists/bloc/atrists_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistsScreen extends StatefulWidget {
  const ArtistsScreen({super.key});

  @override
  State<ArtistsScreen> createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  late List<ArtistModel> artists;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<AtristsBloc, AtristsState>(
      builder: (context, state) {
        if (state is AtristsLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        artists = AtristsBloc.artists;
        return GridView.builder(
          padding: const EdgeInsets.all(24),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1 / 1),
          itemCount: artists.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            ArtistModel artist = artists[index];

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                QueryArtworkWidget(
                  id: artist.id,
                  type: ArtworkType.ARTIST,
                  artworkBorder: BorderRadius.circular(360),
                  artworkFit: BoxFit.cover,
                  format: ArtworkFormat.JPEG,
                  keepOldArtwork: true,
                  nullArtworkWidget: const Icon(
                    CupertinoIcons.profile_circled,
                    size: 50,
                  ),
                ),
                Expanded(
                  child: Text(
                    artist.artist,
                    style: Theme.of(context).textTheme.labelLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Row(
                //   children: [
                //     Expanded(
                //       child: Text(
                //         'Albums: ${artist.numberOfAlbums}',
                //         style: Theme.of(context).textTheme.bodyMedium,
                //         maxLines: 1,
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ),
                //     Expanded(
                //       child: Text(
                //         'Tracks: ${artist.numberOfTracks}',
                //         style: Theme.of(context).textTheme.bodyMedium,
                //         maxLines: 1,
                //         overflow: TextOverflow.ellipsis,
                //       ),
                //     ),
                //   ],
                // ),
              ],
            );
          },
        );
      },
    );
  }
}

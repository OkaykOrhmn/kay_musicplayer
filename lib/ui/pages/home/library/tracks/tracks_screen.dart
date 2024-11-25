import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/ui/pages/home/library/tracks/bloc/tracks_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class TracksScreen extends StatefulWidget {
  const TracksScreen({
    super.key,
  });

  @override
  State<TracksScreen> createState() => _TracksScreenState();
}

class _TracksScreenState extends State<TracksScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late final ScrollController _scrollController = ScrollController();
  List<SongModel> tracks = [];
  List<String> alphabet =
      List.generate(26, (index) => String.fromCharCode(97 + index));
  double _sliderValue = 0;

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  void scrollToIndex(String letter) {
    if (_scrollController.hasClients) {
      int? index;
      for (var song in tracks) {
        if (song.displayName.startsWith(letter)) {
          index = song.id;
          break;
        }
      }
      if (index == null) return;
      double offset = index * 72.0; // Assuming each item has a height of 72
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TracksBloc, TracksState>(
      builder: (context, state) {
        if (state is TracksLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        tracks = TracksBloc.tracks;
        return Scrollbar(
          radius: const Radius.circular(16),
          thumbVisibility: true, // Always show the scrollbar thumb
          child: Row(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: tracks.length,
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    SongModel song = tracks[index];
                    return ListTile(
                        title: Text(song.displayName),
                        subtitle: Text(song.artist ?? 'Unknown'),
                        leading: QueryArtworkWidget(
                          id: song.id,
                          type: ArtworkType.AUDIO,
                          artworkBorder: BorderRadius.circular(16),
                          artworkFit: BoxFit.cover,
                          format: ArtworkFormat.JPEG,
                          keepOldArtwork: true,
                          nullArtworkWidget: Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: Theme.of(context).colorScheme.primary),
                              child: const Icon(CupertinoIcons.music_note)),
                        ));
                  },
                ),
              ),
              SizedBox(
                width: 32,
                height: double.infinity,
                child: Stack(
                  children: [
                    Column(
                      children: List.generate(
                        alphabet.length,
                        (index) {
                          return Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                alphabet[index],
                                style: const TextStyle(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned.fill(
                      child: RotatedBox(
                        quarterTurns: 5, // Rotate slider vertically
                        child: Slider(
                          value: _sliderValue,
                          min: 0,
                          max: alphabet.length.toDouble(),
                          divisions:
                              alphabet.length, // Optional: adds tick marks
                          label: _sliderValue.toStringAsFixed(0),
                          onChangeStart: (value) {},
                          onChanged: (value) {
                            setState(() {
                              _sliderValue = value;
                              print('val$value');
                            });
                            scrollToIndex(alphabet[value.round()]);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

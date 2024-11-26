import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerPage extends StatefulWidget {
  final SongModel song;
  const PlayerPage({super.key, required this.song});

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late final song = widget.song;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          more(),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          songImage(),
          Text(
            song.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            song.artist ?? 'Unkown',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(
            height: 24,
          ),
          playerSlider(),
          const SizedBox(
            height: 24,
          ),
          mainButtons(),
          const SizedBox(
            height: 24,
          ),
          subButtons(context),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }

  PopupMenuButton<String> more() {
    return PopupMenuButton<String>(
      onSelected: (value) {},
      itemBuilder: (BuildContext context) {
        return {
          'Go to Album',
          'Go to Artist',
          'set as Ringstone',
          'Edit Music',
          'Share',
          'Delete from Device',
          'Details'
        }.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }

  Container subButtons(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).colorScheme.primary),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.add)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.replay_10_rounded)),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                CupertinoIcons.shuffle,
              )),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.forward_10_rounded)),
          IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.music_note_list)),
        ],
      ),
    );
  }

  Padding mainButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {}, icon: const Icon(CupertinoIcons.speedometer)),
          IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.backward_end_fill)),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.play_arrow_rounded,
                size: 64,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(CupertinoIcons.forward_end_fill)),
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.heart)),
        ],
      ),
    );
  }

  Column playerSlider() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Slider(
            value: 0,
            onChanged: (value) {},
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('00:00'),
              Text('02:31'),
            ],
          ),
        )
      ],
    );
  }

  Widget songImage() {
    return Expanded(
      child: Column(
        children: [
          const SizedBox(
            height: 32,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: QueryArtworkWidget(
                artworkWidth: double.infinity,
                artworkHeight: double.infinity,
                id: song.id,
                quality: 100,
                artworkQuality: FilterQuality.high,
                size: 1000,
                type: ArtworkType.AUDIO,
                artworkBorder: BorderRadius.circular(16),
                artworkFit: BoxFit.cover,
                format: ArtworkFormat.PNG,
                keepOldArtwork: true,
                nullArtworkWidget: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).colorScheme.primary),
                    child: Icon(
                      CupertinoIcons.music_note_2,
                      size: MediaQuery.sizeOf(context).width / 4,
                    )),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
        ],
      ),
    );
  }
}

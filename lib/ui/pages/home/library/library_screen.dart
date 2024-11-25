import 'package:flutter/material.dart';
import 'package:kay_musicplayer/ui/pages/home/library/tracks/tracks_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 5,
      child: Scaffold(
          // ),
          body: Column(
        children: [
          TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                // icon: Icon(Icons.music_note),
                text: 'Tracks',
              ),
              Tab(
                // icon: Icon(Icons.music_note),
                text: 'Albums',
              ),
              Tab(
                // icon: Icon(Icons.music_note),
                text: 'Artists',
              ),
              Tab(
                // icon: Icon(Icons.music_note),
                text: 'Geners',
              ),
              Tab(
                // icon: Icon(Icons.music_note),
                text: 'Folders',
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                TracksScreen(),
                Icon(Icons.music_video),
                Icon(Icons.camera_alt),
                Icon(Icons.grade),
                Icon(Icons.email),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

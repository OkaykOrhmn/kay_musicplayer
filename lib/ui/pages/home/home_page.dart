import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kay_musicplayer/core/routes/route_generator.dart';
import 'package:kay_musicplayer/ui/pages/home/library/library_screen.dart';
import 'package:kay_musicplayer/ui/pages/home/playlist/playlist_screen.dart';
import 'package:kay_musicplayer/ui/theme/theme_provider.dart';

import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kay Player'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.search)),
          IconButton(
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
              icon: Icon(Provider.of<ThemeProvider>(context).isDarkMode
                  ? CupertinoIcons.sun_min_fill
                  : CupertinoIcons.moon)),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
                child: Center(
              child: Icon(
                CupertinoIcons.music_note,
                size: 40,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            )),
            const ListTile(
              title: Text('Theme'),
              leading: Icon(CupertinoIcons.paintbrush),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(),
            ),
            const ListTile(
              title: Text('Equalizer'),
              leading: Icon(CupertinoIcons.chart_bar),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(),
            ),
            ListTile(
              title: const Text('Settings'),
              leading: const Icon(CupertinoIcons.settings),
              onTap: () {
                Navigator.pushNamed(context, Routes.settings);
              },
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: index,
        children: const [LibraryScreen(), PlaylistScreen()],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
            onTap: (value) => setState(() => index = value),
            currentIndex: index,
            showUnselectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.music_note_2), label: 'Library'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.music_note_list),
                  label: 'Playlist'),
            ]),
      ),
    );
  }
}

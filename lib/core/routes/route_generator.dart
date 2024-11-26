import 'package:flutter/cupertino.dart';
import 'package:kay_musicplayer/ui/pages/home/home_page.dart';
import 'package:kay_musicplayer/ui/pages/player/player_page.dart';
import 'package:kay_musicplayer/ui/pages/settings/settings_page.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Routes {
  static const String main = '/';
  static const String settings = '/settings-page';
  static const String player = '/player-page';

  static Route<dynamic> routeGenerator(RouteSettings routeSettings) {
    return CupertinoPageRoute(
      builder: (context) {
        switch (routeSettings.name.toString()) {
          case main:
            return const HomePage();
          case settings:
            return const SettingsPage();

          case player:
            return PlayerPage(
              song: routeSettings.arguments as SongModel,
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}

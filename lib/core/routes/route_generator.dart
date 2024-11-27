import 'package:flutter/cupertino.dart';
import 'package:kay_musicplayer/ui/pages/home/home_page.dart';
import 'package:kay_musicplayer/ui/pages/player/player_page.dart';
import 'package:kay_musicplayer/ui/pages/settings/settings_page.dart';

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
            return const PlayerPage();

          default:
            return const SizedBox();
        }
      },
    );
  }
}

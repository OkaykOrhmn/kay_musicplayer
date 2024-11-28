import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/data/model/playlist_menu_args.dart';
import 'package:kay_musicplayer/ui/pages/home/home_page.dart';
import 'package:kay_musicplayer/ui/pages/player/bloc/playlist_menu_bloc.dart';
import 'package:kay_musicplayer/ui/pages/player/player_page.dart';
import 'package:kay_musicplayer/ui/pages/player/playlist_menu_page.dart';
import 'package:kay_musicplayer/ui/pages/settings/settings_page.dart';

class Routes {
  static const String main = '/';
  static const String settings = '/settings-page';
  static const String player = '/player-page';
  static const String playlistMenu = '/playlist-menu-page';

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

          case playlistMenu:
            final args = routeSettings.arguments as PlaylistMenuArgs;

            return MultiBlocProvider(
              providers: [
                BlocProvider<PlaylistMenuBloc>(
                  create: (context) => PlaylistMenuBloc()
                    ..add(GetTracksFrom(where: args.where, id: args.id)),
                )
              ],
              child: PlaylistMenuPage(
                args: args,
              ),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}

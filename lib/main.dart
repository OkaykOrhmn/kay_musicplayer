import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/core/provider/playlist_provider.dart';
import 'package:kay_musicplayer/core/routes/route_generator.dart';
import 'package:kay_musicplayer/core/services/my_audio_handler.dart';
import 'package:kay_musicplayer/data/storage/shared_preferences_helper.dart';
import 'package:kay_musicplayer/ui/pages/home/cubit/active_media_item_cubit.dart';
import 'package:kay_musicplayer/ui/pages/home/library/albums/bloc/albums_bloc.dart';
import 'package:kay_musicplayer/ui/pages/home/library/atrists/bloc/atrists_bloc.dart';
import 'package:kay_musicplayer/ui/pages/home/library/geners/bloc/geners_bloc.dart';
import 'package:kay_musicplayer/ui/pages/home/library/tracks/bloc/tracks_bloc.dart';
import 'package:kay_musicplayer/ui/pages/home/playlist/bloc/play_list_bloc.dart';
import 'package:kay_musicplayer/ui/theme/theme_provider.dart';

import 'package:provider/provider.dart';

MyAudioHandler audioHandler = MyAudioHandler();
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await SharedPreferencesHelper.initial();
  } catch (e) {
    if (kDebugMode) {
      print('error during SharedPreferences initial: $e');
    }
  }
  try {
    audioHandler = await AudioService.init(
        builder: () => MyAudioHandler(),
        config: const AudioServiceConfig(
            androidNotificationChannelId: 'com.example.kay_musicplayer',
            androidNotificationChannelName: 'Audio Playback',
            androidNotificationOngoing: true,
            preloadArtwork: true));
  } catch (e) {
    if (kDebugMode) {
      print('error during build AudioService: $e');
    }
  }

  if (FirstTimeStorage.getStatus()) {
    await PlaylistProvider.initialize();
    FirstTimeStorage.setStatus(false);
  }

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TracksBloc>(
            create: (context) => TracksBloc()..add(GetAllTracks()),
          ),
          BlocProvider<AlbumsBloc>(
            create: (context) => AlbumsBloc()..add(GetAllAlbums()),
          ),
          BlocProvider<AtristsBloc>(
            create: (context) => AtristsBloc()..add(GetAllArtists()),
          ),
          BlocProvider<GenersBloc>(
            create: (context) => GenersBloc()..add(GetAllGeners()),
          ),
          BlocProvider<PlayListBloc>(
            create: (context) => PlayListBloc()..add(GetAllPlayLists()),
          ),
          BlocProvider<ActiveMediaItemCubit>(
            create: (context) => ActiveMediaItemCubit(),
          ),
        ],
        child: const MyApp(),
      )));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      initialRoute: Routes.main,
      onGenerateRoute: Routes.routeGenerator,
    );
  }
}

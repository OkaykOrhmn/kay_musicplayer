import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kay_musicplayer/core/provider/playlist_provider.dart';
import 'package:kay_musicplayer/core/routes/route_generator.dart';
import 'package:kay_musicplayer/ui/pages/home/library/tracks/bloc/tracks_bloc.dart';
import 'package:kay_musicplayer/ui/theme/theme_provider.dart';

import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider()),
        ChangeNotifierProvider<PlaylistProvider>(
            create: (context) => PlaylistProvider()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TracksBloc>(
            create: (context) => TracksBloc()..add(GetAllTracks()),
          ),
        ],
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      initialRoute: Routes.main,
      onGenerateRoute: Routes.routeGenerator,
    );
  }
}

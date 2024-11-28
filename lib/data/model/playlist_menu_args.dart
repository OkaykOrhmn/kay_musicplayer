import 'package:on_audio_query/on_audio_query.dart';

class PlaylistMenuArgs {
  final AudiosFromType where;
  final dynamic id;
  final String name;
  final int count;
  final String? desc;
  final String? date;

  PlaylistMenuArgs({
    required this.where,
    required this.id,
    required this.name,
    required this.count,
    this.desc,
    this.date,
  });
}

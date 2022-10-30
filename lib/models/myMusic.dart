import 'package:hive_flutter/hive_flutter.dart';
part 'myMusic.g.dart';

@HiveType(typeId: 0)
class MyMusic extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String artist;
  @HiveField(3)
  final String url;

  MyMusic(
      {required this.id,
      required this.title,
      required this.artist,
      required this.url});
}

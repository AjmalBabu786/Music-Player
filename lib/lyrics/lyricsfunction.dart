import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:music_player/lyrics/lyricsmodal/lyricsmodal.dart';

Future<Lyricsmodal> getSongLyrics(
    {required String title, required String artist}) async {
  log(title.toString());
  log(artist);

  //log('heeeeeee');
  log('Misab');

  var uri = Uri.https(
    'powerlyrics.p.rapidapi.com',
    'getlyricsfromtitleandartist',
    {'title': title, 'artist': artist},
  );
  log('URI completed');

  final response = await http.get(
    uri,
    headers: {
      'X-RapidAPI-Key': '3cd3fdab20msha3a9cb5805feae8p18ae3bjsn1b92dabbabee',
      'X-RapidAPI-Host': 'powerlyrics.p.rapidapi.com'
    },
  );
  log('Uri get completed');

  log(response.body.toString());

  final decodedBody = jsonDecode(response.body) as Map<String, dynamic>;
  final data = Lyricsmodal.fromJson(decodedBody);
  log(response.body.toString());
  return data;
}

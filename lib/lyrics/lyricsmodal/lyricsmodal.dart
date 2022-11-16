import 'package:json_annotation/json_annotation.dart';

part 'lyricsmodal.g.dart';

@JsonSerializable()
class Lyricsmodal {
  bool? success;
  String? requestedtitle;
  String? requestedartist;
  String? resolvedtitle;
  String? resolvedartist;
  String? lyrics;

  Lyricsmodal({
    this.success,
    this.requestedtitle,
    this.requestedartist,
    this.resolvedtitle,
    this.resolvedartist,
    this.lyrics,
  });

  factory Lyricsmodal.fromJson(Map<String, dynamic> json) {
    return _$LyricsmodalFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LyricsmodalToJson(this);
}

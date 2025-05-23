import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tv_ratting_app/app/domain/typedefs.dart';

part 'media.freezed.dart';
part 'media.g.dart';

enum MediaType {
  @JsonValue("movie")
  movie,
  @JsonValue("tv")
  tv,
}

@freezed
class Media with _$Media {
  factory Media({
    required int id,
    required String overview,

    ///
    @JsonKey(readValue: readTitleValue) required String title,
    @JsonKey(
      name: "original_title",
      readValue: readOriginalTitleValue,
    )
    required String originalTitle,
    @JsonKey(name: "poster_path") required String posterPath,
    @JsonKey(name: "backdrop_path") required String? backdropPath,
    @JsonKey(name: "vote_average") required double voteAverage,
    @JsonKey(name: "media_type") required MediaType type,
  }) = _Media;

  factory Media.fromJson(Json json) => _$MediaFromJson(json);
}

Object? readTitleValue(Map map, String _) {
  return map["title"] ?? map["name"];
}

Object? readOriginalTitleValue(Map map, String _) {
  return map["original_title"] ?? map["original_name"];
}

List<Media> getMediaList(List list) {
  return list
      .where(
        (i) => i["media_type"] != "person" && i["poster_path"] != null && i["backdrop_path"] != null,
      )
      .map(
        (e) => Media.fromJson(e),
      )
      .toList();
}

List<Media> getPerformerList(List list) {
  return list
      .where(
        (i) => i["known_for_department"] == "Acting" && i["profile_path"] != null,
      )
      .map(
        (e) => Media.fromJson(e),
      ).toList();
}

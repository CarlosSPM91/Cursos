import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tv_ratting_app/app/domain/typedefs.dart';

part 'media.freezed.dart';
part 'media.g.dart';

@freezed
class Media with _$Media {
  factory Media({
    required int id,
    required String name,
    required String overview,

    ///
    @JsonKey(name: "original_name") required String originalName,
    @JsonKey(name: "poster_path") required String posterPath,
    @JsonKey(name: "backdrop_path") required String backdropPath,
    @JsonKey(name: "vote_average") required double voteAverage,
    @JsonKey(name: "media_type") required String type,
    

  }) = _Media;

  factory Media.fromJson(Json json) => _$MediaFromJson(json);
}

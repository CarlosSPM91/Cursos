import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tv_ratting_app/app/domain/model/genre/genre.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/domain/typedefs.dart';

part 'movie.freezed.dart';
part 'movie.g.dart';

@freezed
class Movie with _$Movie {
  factory Movie({
    required int id,
    required List<Genre> genres,
    required String overview,
    required int runtime,
    //
    @JsonKey(name: "poster_path") required String posterPath,
    @JsonKey(name: "release_date") required DateTime releaseDate,
    @JsonKey(name: "vote_average") required double voteAverage,
    @JsonKey(name: "backdrop_path") required String backdropPath,
    @JsonKey(readValue: readTitleValue) required String title,
    @JsonKey(name: "original_title", readValue: readOriginalTitleValue) required String originalTitle,
  }) = _Movie;

  factory Movie.fromJson(Json json) => _$MovieFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tv_ratting_app/app/domain/model/genre/genre.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/domain/typedefs.dart';

part 'serie.freezed.dart';
part 'serie.g.dart';

@freezed
class Serie with _$Serie {
  const Serie._();

  const factory Serie({
    required int id,
    required List<Genre> genres,
    required String overview,
    //
    @JsonKey(name: "poster_path") required String posterPath,
    @JsonKey(name: "number_of_seasons") required int seasons,
    @JsonKey(name: "vote_average") required double voteAverage,
    @JsonKey(name: "backdrop_path") required String? backdropPath,
    @JsonKey(readValue: readTitleValue) required String name,
    @JsonKey(name: "original_name", readValue: readOriginalTitleValue) required String originalName,
  }) = _Serie;

  factory Serie.fromJson(Json json) => _$SerieFromJson(json);

  toMedia() {
    return Media(
      id: id,
      overview: overview,
      title: name,
      originalTitle: originalName,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      type: MediaType.movie,
    );
  }
}
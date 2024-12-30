import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tv_ratting_app/app/domain/model/media/media.dart';
import 'package:tv_ratting_app/app/domain/typedefs.dart';

part 'performer.freezed.dart';
part 'performer.g.dart';

@freezed
class Performer with _$Performer {
  factory Performer({
    required int id,
    required String name,
    required double popularity,

    ///
    @JsonKey(name: "original_name") required String originalName,
    @JsonKey(name: "profile_path") required String profilePath,
  }) = _Performer;

  factory Performer.fromJson(Json json) => _$PerformerFromJson(json);
}

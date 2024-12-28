import 'package:freezed_annotation/freezed_annotation.dart';

part "user.freezed.dart";
part "user.g.dart";

@freezed
class User with _$User {
  const User._();

  const factory User({
    required int id,
    required String username,

    ///
    @JsonKey(
      name: "avatar",
      fromJson: avatarPathFromJson,
    )
    String? avatar_path,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  String getFormatted() {
    return "$username $id";
  }

  // factory User.fromJson(Map<String, dynamic> json) {
  //   // String? avatarPath;
  //   // final avatar = json["avatar"] as Map;
  //   // if (avatar != null && avatar["tmdb"] is Map) {
  //   //   avatarPath = avatar["tmdb"]["avatar"];
  // //   // }

  //   final avatarPath = json["avatar"]["tmdb"]?["avatar_path"] as String?;
  //   return User(
  //     id: json['id'] as int,
  //     username: json['username'] as String,
  //     avatar_path: avatarPath,
  //   );
  // }
}

String? avatarPathFromJson(Map<String, dynamic> json) {
  return json["tmdb"]?["avatar_path"] as String?;
}

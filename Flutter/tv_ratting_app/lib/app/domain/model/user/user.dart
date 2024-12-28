import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part "user.g.dart";

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String username;
  @JsonKey(
    name: "avatar",
    fromJson: avatarPathFromJson,
  )
  final String? avatar_path;

  const User({
    required this.id,
    required this.username,
    required this.avatar_path,
  });

  @override
  List<Object?> get props => [
        id,
        username,
      ];

  Map<String, dynamic> toJson() => _$UserToJson(this);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

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

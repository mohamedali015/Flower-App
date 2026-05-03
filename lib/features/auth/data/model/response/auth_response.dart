import 'package:flower_app/features/auth/data/model/response/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class AuthResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "user")
  UserResponse? user;
  @JsonKey(name: "token")
  String? token;

  AuthResponse({this.message, this.user, this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:flower_app/features/change_password/domain/entities/change_password_response_entity.dart';

part 'change_password_response.g.dart';

@JsonSerializable()
class ChangePasswordResponse {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "token")
  final String? token;

  ChangePasswordResponse({this.message, this.token});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return _$ChangePasswordResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ChangePasswordResponseToJson(this);
  }

  ChangePasswordResponseEntity toEntity() =>
      ChangePasswordResponseEntity(message: message, token: token);
}

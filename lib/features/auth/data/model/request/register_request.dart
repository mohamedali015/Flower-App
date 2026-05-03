import 'package:json_annotation/json_annotation.dart';

part 'register_request.g.dart';

@JsonSerializable()
class RegisterRequest {
  @JsonKey(name: "firstName")
  String? firstName;
  @JsonKey(name: "lastName")
  String? lastName;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "password")
  String? password;
  @JsonKey(name: "rePassword")
  String? rePassword;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "gender")
  String? gender;

  RegisterRequest({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.rePassword,
    this.phone,
    this.gender,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

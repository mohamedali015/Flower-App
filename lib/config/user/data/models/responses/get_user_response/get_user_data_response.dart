import 'package:flower_app/config/user/data/models/responses/get_user_response/user_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_user_data_response.g.dart';

@JsonSerializable()
class GetUserDataResponse {
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "user")
  UserResponse? user;

  GetUserDataResponse({this.message, this.user});

  factory GetUserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserDataResponseToJson(this);

}

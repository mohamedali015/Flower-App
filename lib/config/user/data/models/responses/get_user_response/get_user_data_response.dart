import 'package:json_annotation/json_annotation.dart';

import '../../../../../../features/auth/data/model/response/user_response.dart';

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

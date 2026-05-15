import 'package:flower_app/features/auth/data/model/request/register_request.dart';

import '../../domain/params/register_params.dart';

extension RegisterParamsMapper on RegisterParams {
  RegisterRequest toRequest() {
    return RegisterRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: confirmPassword,
      phone: phone,
      gender: gender,
    );
  }
}

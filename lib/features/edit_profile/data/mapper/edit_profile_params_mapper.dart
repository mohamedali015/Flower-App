import '../../domain/params/edit_profile_params.dart';
import '../model/request/edit_profile_request.dart';

extension EditProfileParamsMapper on EditProfileParams {
  EditProfileRequest toRequest() {
    return EditProfileRequest(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
  }
}

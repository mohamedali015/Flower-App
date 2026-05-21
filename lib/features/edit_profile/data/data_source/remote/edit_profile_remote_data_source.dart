import 'dart:io';

import '../../../../../config/error_handling/result.dart';
import '../../model/request/edit_profile_request.dart';
import '../../model/response/edit_profile_response.dart';
import '../../model/response/upload_image_response.dart';

abstract class EditProfileRemoteDataSource {
  Future<Result<EditProfileResponse>> editProfile({
    required EditProfileRequest request,
  });

  Future<Result<UploadImageResponse>> uploadPhoto({required File image});
}

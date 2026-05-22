import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/error_handling/execute_api.dart';
import '../../../../../config/error_handling/result.dart';
import '../../../data/data_source/remote/edit_profile_remote_data_source.dart';
import '../../../data/model/request/edit_profile_request.dart';
import '../../../data/model/response/edit_profile_response.dart';
import '../../../data/model/response/upload_image_response.dart';
import '../../edit_profile_api_client.dart';

@Injectable(as: EditProfileRemoteDataSource)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSource {
  final EditProfileApiClient _apiClient;

  EditProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<EditProfileResponse>> editProfile({
    required EditProfileRequest request,
  }) {
    return executeApi(() async {
      return _apiClient.editProfile(request);
    });
  }

  @override
  Future<Result<UploadImageResponse>> uploadPhoto({required File image}) async {
    return executeApi(() async {
      final multipartFile = await MultipartFile.fromFile(
        image.path,
        filename: image.path.split('/').last,
      );

      return _apiClient.uploadPhoto(multipartFile);
    });
  }
}

import 'dart:io';

import 'package:flower_app/features/auth/domain/entities/auth_entity.dart';
import 'package:flower_app/features/edit_profile/data/model/response/upload_image_response.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../../domain/params/edit_profile_params.dart';
import '../../domain/repositories/edit_profile_repo.dart';
import '../data_source/remote/edit_profile_remote_data_source.dart';
import '../mapper/edit_profile_params_mapper.dart';
import '../mapper/edit_profile_response_mapper.dart';
import '../model/response/edit_profile_response.dart';

@Injectable(as: EditProfileRepo)
class EditProfileRepoImpl implements EditProfileRepo {
  final EditProfileRemoteDataSource _remoteDataSource;

  EditProfileRepoImpl(this._remoteDataSource);

  @override
  Future<Result<AuthEntity>> editProfile({
    required EditProfileParams params,
  }) async {
    final response = await _remoteDataSource.editProfile(
      request: params.toRequest(),
    );

    switch (response) {
      case Success<EditProfileResponse>():
        {
          return Success(data: response.data.toEntity());
        }

      case Failure<EditProfileResponse>():
        {
          return Failure(errorMessage: response.errorMessage);
        }
    }
  }

  @override
  Future<Result<bool>> uploadPhoto({required File image}) async {
    final response = await _remoteDataSource.uploadPhoto(image: image);

    switch (response) {
      case Success<UploadImageResponse>():
        {
          return Success(data: true);
        }
      case Failure<UploadImageResponse>():
        {
          return Failure(errorMessage: response.errorMessage);
        }
    }
  }
}

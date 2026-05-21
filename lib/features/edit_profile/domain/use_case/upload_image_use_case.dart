import 'dart:io';

import 'package:injectable/injectable.dart';

import '../../../../config/error_handling/result.dart';
import '../repositories/edit_profile_repo.dart';

@injectable
class UploadPhotoUseCase {
  final EditProfileRepo _repo;

  UploadPhotoUseCase(this._repo);

  Future<Result<bool>> call({required File image}) {
    return _repo.uploadPhoto(image: image);
  }
}

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../core/values/api_end_points.dart';
import '../../../core/values/api_strings.dart';
import '../data/model/request/edit_profile_request.dart';
import '../data/model/response/edit_profile_response.dart';
import '../data/model/response/upload_image_response.dart';

part 'edit_profile_api_client.g.dart';

@injectable
@RestApi()
abstract class EditProfileApiClient {
  @factoryMethod
  factory EditProfileApiClient(Dio dio) = _EditProfileApiClient;

  @PUT(ApiEndPoints.editProfile)
  Future<EditProfileResponse> editProfile(@Body() EditProfileRequest request);

  @MultiPart()
  @PUT(ApiEndPoints.uploadPhoto)
  Future<UploadImageResponse> uploadPhoto(
    @Part(name: ApiStrings.photo) MultipartFile photo,
  );
}

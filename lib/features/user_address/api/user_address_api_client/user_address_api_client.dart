import 'package:dio/dio.dart';

import 'package:flower_app/core/values/api_end_points.dart';
import 'package:flower_app/core/values/api_strings.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/models/address_dto.dart';
import '../../data/models/user_address_dto.dart';

part 'user_address_api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiEndPoints.baseUrl)
abstract class UserAddressApiClient {
  @factoryMethod
  factory UserAddressApiClient(Dio dio) = _UserAddressApiClient;

  @GET(ApiEndPoints.userAddress)
  Future<UserAddressResponseDto> getLoggedUserAddresses();

  @PATCH(ApiEndPoints.userAddress)
  Future<UserAddressResponseDto> addUserAddress(@Body() AddressDto address);

  @PATCH(ApiEndPoints.addressById)
  Future<UserAddressResponseDto> updateUserAddress(
    @Body() AddressDto address,
    @Path(ApiStrings.id) String id,
  );

  @DELETE(ApiEndPoints.addressById)
  Future<UserAddressResponseDto> removeUserAddress(@Path(ApiStrings.id) String id);
}

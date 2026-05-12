import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../../../core/values/api_end_points.dart';
import '../../../core/values/api_strings.dart';
import '../data/model/response/categories_response.dart';

part 'category_api_client.g.dart';

@injectable
@RestApi()
abstract class CategoryApiClient {
  @factoryMethod
  factory CategoryApiClient(Dio dio) = _CategoryApiClient;

  ///? GET ALL Categories

  @GET(ApiEndPoints.categories)
  @Extra({ApiStrings.requireAuth: false})
  Future<CategoriesResponse> getAllCategories();

}

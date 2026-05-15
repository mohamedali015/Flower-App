import 'package:flower_app/config/error_handling/result.dart';
import '../model/response/categories_response.dart';

abstract class CategoryRemoteDataSource {
  Future<Result<CategoriesResponse>> getAllCategories();
}
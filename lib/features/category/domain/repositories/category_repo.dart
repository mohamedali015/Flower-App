import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/category/domain/entities/get_all_category_entity.dart';

abstract class CategoryRepo {
  Future<Result<List<GetAllCategoryEntity>>> getAllCategories();
}
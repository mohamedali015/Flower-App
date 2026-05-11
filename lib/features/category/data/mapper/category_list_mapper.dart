import '../../domain/entities/get_all_category_entity.dart';
import '../model/response/categories_response.dart';
import 'categories_response_mapper.dart';

extension CategoryListMapper on CategoriesResponse {
  List<GetAllCategoryEntity> toEntityList() {
    return categories?.map((e) => e.toGetAllCategoryEntity()).toList() ?? [];
  }
}
import '../../domain/entities/get_all_category_entity.dart';
import '../model/response/all_categories_response.dart';

extension CategoriesResponseMapper on AllCategoriesResponse{
  GetAllCategoryEntity toGetAllCategoryEntity() {
    return GetAllCategoryEntity(
      id: id ,
      name: name ,
      image: image,
      isSuperAdmin: isSuperAdmin,
      productsCount: productsCount,
    );
  }
}
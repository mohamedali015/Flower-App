import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/category/data/model/response/categories_response.dart';
import 'package:flower_app/features/category/domain/entities/get_all_category_entity.dart';
import 'package:flower_app/features/category/domain/repositories/category_repo.dart';
import 'package:injectable/injectable.dart';
import '../data_source/category_remote_data_source.dart';
import '../mapper/categories_response_mapper.dart';

@LazySingleton(as: CategoryRepo)
class CategoryRepoImpl implements CategoryRepo {
  final CategoryRemoteDataSource _remoteDataSource;
  CategoryRepoImpl(this._remoteDataSource);

  @override
  Future<Result<List<GetAllCategoryEntity>>> getAllCategories() async {
    var response = await _remoteDataSource.getAllCategories();
    switch (response) {
      case Success<CategoriesResponse>():
        final categoriesResponse = response.data.categories ?? [];
        return Success(
          data: categoriesResponse
              .map((e) => e.toGetAllCategoryEntity())
              .toList(),
        );
      case Failure<CategoriesResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}

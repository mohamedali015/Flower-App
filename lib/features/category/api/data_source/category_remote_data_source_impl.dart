import 'package:flower_app/config/error_handling/execute_api.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/category/data/data_source/category_remote_data_source.dart';
import 'package:flower_app/features/category/data/model/response/categories_response.dart';
import 'package:injectable/injectable.dart';
import '../category_api_client.dart';

@LazySingleton(as: CategoryRemoteDataSource)
class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  final CategoryApiClient _apiClient;
  CategoryRemoteDataSourceImpl(this._apiClient);
  @override


  Future<Result<CategoriesResponse>> getAllCategories() {
    return executeApi<CategoriesResponse>(() async {
      var response = await _apiClient.getAllCategories();
      return response;
    });
  }

}

import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../entities/get_all_category_entity.dart';
import '../repositories/category_repo.dart';

@injectable
class GetCategoryUseCase {
  final CategoryRepo _categoryRepo;
  const GetCategoryUseCase(this._categoryRepo);

  Future<Result<List<GetAllCategoryEntity>>> getAllCategories() async {
    return await _categoryRepo.getAllCategories();
  }
}

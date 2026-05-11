import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/error_handling/result.dart';
import '../../domain/entities/get_all_category_entity.dart';
import '../../domain/use_case/get_category_use_case.dart';
import 'category_event.dart';
import 'category_state.dart';

@injectable
class CategoryCubit extends Cubit<CategoryState> {
  final GetCategoryUseCase _getCategoryUseCase;

  CategoryCubit(this._getCategoryUseCase) : super(const CategoryState());

  Future<void> _getAllCategories() async {
    emit(state.copyWith(isLoading: true, clearError: true));

    final response = await _getCategoryUseCase.getAllCategories();

    switch (response) {
      case Success<List<GetAllCategoryEntity>>():
        emit(
          state.copyWith(
            categories: response.data,
            isLoading: false,
            clearError: true,
          ),
        );

      case Failure<List<GetAllCategoryEntity>>():
        emit(
          state.copyWith(isLoading: false, errorMessage: response.errorMessage),
        );
    }
  }

  void doEvent(CategoryEvent event) {
    switch (event) {
      case GetAllCategoryEvent():
        _getAllCategories();
        break;
    }
  }
}

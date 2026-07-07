import 'package:equatable/equatable.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/features/filter/domain/enums/sort_options.dart';

import '../../../../config/products/domain/entities/product_entity.dart';
import '../../domain/entities/get_all_category_entity.dart';

class CategoryState extends Equatable {
  final BaseState<List<GetAllCategoryEntity>> categoriesState;
  final BaseState<List<ProductEntity>> productsState;

  final String? selectedCategoryId;
  final SortOption? selectedSortOption;

  const CategoryState({
    this.categoriesState = const BaseState(),
    this.productsState = const BaseState(),
    this.selectedCategoryId,
    this.selectedSortOption,
  });

  CategoryState copyWith({
    BaseState<List<GetAllCategoryEntity>>? categoriesStateParam,
    BaseState<List<ProductEntity>>? productsStateParam,
    String? selectedCategoryId,
    SortOption? selectedSortOption,
  }) {
    return CategoryState(
      categoriesState: categoriesStateParam ?? categoriesState,
      productsState: productsStateParam ?? productsState,
      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedSortOption: selectedSortOption ?? this.selectedSortOption,
    );
  }

  @override
  List<Object?> get props => [
    categoriesState,
    productsState,
    selectedCategoryId,
    selectedSortOption,
  ];
}

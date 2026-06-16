import 'package:equatable/equatable.dart';
import 'package:flower_app/features/filter/domain/enums/sort_options.dart';

import '../../../../config/products/domain/entities/product_entity.dart';
import '../../domain/entities/get_all_category_entity.dart';

class CategoryState extends Equatable {
  /// Category
  final List<GetAllCategoryEntity> categories;
  final bool isLoading;
  final String? errorMessage;

  /// Product
  final List<ProductEntity> products;
  final bool isProductLoading;
  final String? productErrorMessage;

  final String? selectedCategoryId;
  final SortOption? selectedSortOption;
  const CategoryState({
    this.categories = const [],
    this.isLoading = false,
    this.errorMessage,
    this.products = const [],
    this.isProductLoading = false,
    this.productErrorMessage,
    this.selectedCategoryId,
    this.selectedSortOption,
  });

  CategoryState copyWith({
    List<GetAllCategoryEntity>? categories,
    bool? isLoading,
    String? errorMessage,
    bool clearCategoryError = false,

    List<ProductEntity>? products,
    bool? isProductLoading,
    String? productErrorMessage,
    bool clearProductError = false,

    String? selectedCategoryId,
    SortOption? selectedSortOption,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearCategoryError
          ? null
          : errorMessage ?? this.errorMessage,

      products: products ?? this.products,
      isProductLoading: isProductLoading ?? this.isProductLoading,
      productErrorMessage: clearProductError
          ? null
          : productErrorMessage ?? this.productErrorMessage,

      selectedCategoryId: selectedCategoryId ?? this.selectedCategoryId,
      selectedSortOption: selectedSortOption ?? this.selectedSortOption,
    );
  }

  @override
  List<Object?> get props => [
    categories,
    isLoading,
    errorMessage,
    products,
    isProductLoading,
    productErrorMessage,
    selectedCategoryId,
    selectedSortOption,
  ];
}

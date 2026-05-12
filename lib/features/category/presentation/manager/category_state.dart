import 'package:equatable/equatable.dart';

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

  const CategoryState({
    this.categories = const [],
    this.isLoading = false,
    this.errorMessage,
    this.products = const [],
    this.isProductLoading = false,
    this.productErrorMessage,
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
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      errorMessage:
      clearCategoryError ? null : errorMessage ?? this.errorMessage,

      products: products ?? this.products,
      isProductLoading:
      isProductLoading ?? this.isProductLoading,
      productErrorMessage:
      clearProductError
          ? null
          : productErrorMessage ?? this.productErrorMessage,
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
  ];
}
import 'package:equatable/equatable.dart';
import '../../../../config/products/domain/entities/product_entity.dart';

class SearchState extends Equatable {
  final List<ProductEntity> searchProducts;
  final bool isSearchProductLoading;
  final String? searchProductErrorMessage;

  const SearchState({
    this.searchProducts = const [],
    this.isSearchProductLoading = false,
    this.searchProductErrorMessage,
  });

  SearchState copyWith({
    List<ProductEntity>? searchProducts,
    bool? isSearchProductLoading,
    String? searchProductErrorMessage,
    bool clearError = false,
  }) {
    return SearchState(
      searchProducts: searchProducts ?? this.searchProducts,
      isSearchProductLoading:
      isSearchProductLoading ?? this.isSearchProductLoading,
      searchProductErrorMessage: clearError
          ? null
          : (searchProductErrorMessage ?? this.searchProductErrorMessage),
    );
  }

  @override
  List<Object?> get props => [
    searchProducts,
    isSearchProductLoading,
    searchProductErrorMessage,
  ];
}
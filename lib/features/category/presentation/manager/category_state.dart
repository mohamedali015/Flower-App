import 'package:equatable/equatable.dart';
import '../../domain/entities/get_all_category_entity.dart';

class CategoryState extends Equatable {
  final List<GetAllCategoryEntity> categories;
  final bool isLoading;
  final String? errorMessage;

  const CategoryState({
    this.categories = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  CategoryState copyWith({
    List<GetAllCategoryEntity>? categories,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return CategoryState(
      categories: categories ?? this.categories,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [categories, isLoading, errorMessage];
}

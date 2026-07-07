import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/filter/domain/enums/sort_options.dart';

extension SortOptionApi on SortOption {
  String get apiKey {
    switch (this) {
      case SortOption.lowestPrice:
        return AppStrings.priceAsc;
      case SortOption.highestPrice:
        return AppStrings.priceDesc;
      case SortOption.newest:
        return AppStrings.newest;
      case SortOption.oldest:
        return AppStrings.oldest;
      case SortOption.discount:
        return AppStrings.discount;
    }
  }
}

SortOption? mapApiKeyToSort(String? apiKey) {
  switch (apiKey) {
    case AppStrings.priceAsc:
      return SortOption.lowestPrice;
    case AppStrings.priceDesc:
      return SortOption.highestPrice;
    case AppStrings.newest:
      return SortOption.newest;
    case AppStrings.oldest:
      return SortOption.oldest;
    case AppStrings.discount:
      return SortOption.discount;
    default:
      return null;
  }
}

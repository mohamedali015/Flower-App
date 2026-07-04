import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/filter/domain/enums/sort_options.dart';

abstract class SortOptionFactory {
  static String toApiKey(SortOption option) {
    switch (option) {
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

  static SortOption? fromApiKey(String? apiKey) {
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

  static String label(SortOption option, AppLocalizations local) {
    switch (option) {
      case SortOption.lowestPrice:
        return local.lowestPrice;
      case SortOption.highestPrice:
        return local.highestPrice;
      case SortOption.newest:
        return local.newest;
      case SortOption.oldest:
        return local.old;
      case SortOption.discount:
        return local.discount;
    }
  }
}

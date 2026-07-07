import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/features/filter/domain/enums/sort_options.dart';

extension SortOptionLocalization on SortOption {
  String label(AppLocalizations local) {
    switch (this) {
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

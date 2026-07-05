import 'package:flower_app/core/localization/l10n/app_localizations_ar.dart';
import 'package:flower_app/core/localization/l10n/app_localizations_en.dart';
import 'package:flower_app/core/values/app_strings.dart';
import 'package:flower_app/features/filter/domain/enums/sort_options.dart';
import 'package:flower_app/features/filter/domain/sort_option_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SortOptionFactory Tests', () {
    test('toApiKey returns correct key for each SortOption', () {
      expect(SortOptionFactory.toApiKey(SortOption.lowestPrice), AppStrings.priceAsc);
      expect(SortOptionFactory.toApiKey(SortOption.highestPrice), AppStrings.priceDesc);
      expect(SortOptionFactory.toApiKey(SortOption.newest), AppStrings.newest);
      expect(SortOptionFactory.toApiKey(SortOption.oldest), AppStrings.oldest);
      expect(SortOptionFactory.toApiKey(SortOption.discount), AppStrings.discount);
    });

    test('fromApiKey returns correct SortOption or null', () {
      expect(SortOptionFactory.fromApiKey(AppStrings.priceAsc), SortOption.lowestPrice);
      expect(SortOptionFactory.fromApiKey(AppStrings.priceDesc), SortOption.highestPrice);
      expect(SortOptionFactory.fromApiKey(AppStrings.newest), SortOption.newest);
      expect(SortOptionFactory.fromApiKey(AppStrings.oldest), SortOption.oldest);
      expect(SortOptionFactory.fromApiKey(AppStrings.discount), SortOption.discount);
      expect(SortOptionFactory.fromApiKey('unknown_key'), null);
      expect(SortOptionFactory.fromApiKey(null), null);
    });

    test('label returns correct localized string in English', () {
      final localEn = AppLocalizationsEn();
      expect(SortOptionFactory.label(SortOption.lowestPrice, localEn), localEn.lowestPrice);
      expect(SortOptionFactory.label(SortOption.highestPrice, localEn), localEn.highestPrice);
      expect(SortOptionFactory.label(SortOption.newest, localEn), localEn.newest);
      expect(SortOptionFactory.label(SortOption.oldest, localEn), localEn.old);
      expect(SortOptionFactory.label(SortOption.discount, localEn), localEn.discount);
    });

    test('label returns correct localized string in Arabic', () {
      final localAr = AppLocalizationsAr();
      expect(SortOptionFactory.label(SortOption.lowestPrice, localAr), localAr.lowestPrice);
      expect(SortOptionFactory.label(SortOption.highestPrice, localAr), localAr.highestPrice);
      expect(SortOptionFactory.label(SortOption.newest, localAr), localAr.newest);
      expect(SortOptionFactory.label(SortOption.oldest, localAr), localAr.old);
      expect(SortOptionFactory.label(SortOption.discount, localAr), localAr.discount);
    });
  });
}

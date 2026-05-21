import 'package:flower_app/features/logout/home/data/model/categories.dart';
import 'package:flower_app/features/logout/home/domain/entities/categories_entity.dart';

extension CategoriesMapper on Categories {
  CategoriesEntity toEntity() {
    return CategoriesEntity(name: name ?? '', image: image ?? '');
  }
}

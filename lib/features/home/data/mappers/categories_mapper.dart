import 'package:flower_app/features/home/data/model/categories.dart';
import 'package:flower_app/features/home/domain/entities/categories_entity.dart';

extension CategoriesMapper on Categories {
  CategoriesEntity toEntity() {
    return CategoriesEntity(name: name ?? '', image: image ?? '');
  }
}

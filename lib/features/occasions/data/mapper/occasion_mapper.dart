import 'package:flower_app/features/occasions/data/model/response/occasion_model.dart';
import 'package:flower_app/features/occasions/domain/entities/occasion_entity.dart';

extension OccasionMapper on OccasionModel {
  OccasionEntity toEntity() {
    return OccasionEntity(
      id: id ?? '',
      name: name ?? '',
      image: image ?? '',
      isSuperAdmin: isSuperAdmin ?? false,
      productsCount: productsCount ?? 0,
    );
  }
}

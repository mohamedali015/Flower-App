import 'package:flower_app/features/home/data/model/occasions.dart';
import 'package:flower_app/features/home/domain/entities/occasions_entity.dart';

extension OccasionsMapper on Occasions {
  OccasionsEntity toEntity() {
    return OccasionsEntity(name: name ?? '', image: image ?? '');
  }
}

import 'package:equatable/equatable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../config/products/domain/entities/products_response_entity.dart';
import '../../domain/entities/occasion_entity.dart';

class OccasionsState extends Equatable {
  final BaseState<List<OccasionEntity>> occasionsCategoryState;
  final BaseState<ProductsResponseEntity> occasionProductsState;

  const OccasionsState({
    this.occasionsCategoryState = const BaseState(),
    this.occasionProductsState = const BaseState(),
  });

  OccasionsState copyWith({
    BaseState<List<OccasionEntity>>? occasionsCategoryStateParam,
    BaseState<ProductsResponseEntity>? occasionProductsStateParam,
  }) {
    return OccasionsState(
      occasionsCategoryState:
          occasionsCategoryStateParam ?? occasionsCategoryState,
      occasionProductsState:
          occasionProductsStateParam ?? occasionProductsState,
    );
  }

  @override
  List<Object?> get props => [occasionsCategoryState, occasionProductsState];
}

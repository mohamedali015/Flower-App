import 'package:equatable/equatable.dart';
import 'package:flower_app/config/products/domain/entities/products_response_entity.dart';

import '../../../../config/base_state/base_state.dart';

class BestSellerState extends Equatable {
  final BaseState<ProductsResponseEntity> bestSellerState;
  const BestSellerState({this.bestSellerState = const BaseState()});
  BestSellerState copyWith({
    BaseState<ProductsResponseEntity>? bestSellerStateParam,
  }) {
    return BestSellerState(
      bestSellerState: bestSellerStateParam ?? bestSellerState,
    );
  }

  @override
  List<Object?> get props => [bestSellerState];
}

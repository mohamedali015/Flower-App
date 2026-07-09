import 'package:flower_app/config/add_to_cart/date/data_source/add_to_cart_data_source.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/cart/data/model/request/add_to_cart_request.dart';
import 'package:flower_app/features/cart/data/model/response/cart_response.dart';
import 'package:injectable/injectable.dart';
import '../../../../features/cart/data/mapper/car_mapper.dart';
import '../../../../features/cart/domain/entities/get_cart_entity.dart';
import '../../domain/repositories/add_to_cart_repo.dart';

@Injectable(as: AddToCartRepo)
class AddToCartRepoImpl implements AddToCartRepo {
  final AddToCartDataSource _dataSource;
  AddToCartRepoImpl(this._dataSource);

  ///////////// Add To Cart //////////////////
  @override
  Future<Result<GetCartEntity>> addToCart(AddToCartRequest request) async {
    final response = await _dataSource.addToCart(request);
    switch (response) {
      case Success<CartResponse>():
        return Success(data: response.data.toEntity());
      case Failure<CartResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }
}

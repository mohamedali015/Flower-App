import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/cart/data/data_source/cart_data_source.dart';
import 'package:flower_app/features/cart/data/model/response/cart_response.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/get_cart_entity.dart';
import '../../domain/repositories/cart_repo.dart';
import '../mapper/car_mapper.dart';
import '../model/request/update_cart_request.dart';

@Injectable(as: CartRepo)
class CartRepoImpl implements CartRepo {
  final GetCartDataSource _dataSource;
  CartRepoImpl(this._dataSource);

  ///////////// Get Cart //////////////////
  @override
  Future<Result<GetCartEntity>> getCart() async {
    final response = await _dataSource.getCart();
    switch (response) {
      case Success<CartResponse>():
        return Success(data: response.data.toEntity());

      case Failure<CartResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  ///////////// Remove From Cart //////////////////
  @override
  Future<Result<GetCartEntity>> removeFromCart(String id) async {
    final response = await _dataSource.removeFromCart(id);
    switch (response) {
      case Success<CartResponse>():
        return Success(data: response.data.toEntity());
      case Failure<CartResponse>():
        return Failure(errorMessage: response.errorMessage);
    }
  }

  ////////////// Update Cart //////////////////
  @override
  Future<Result<GetCartEntity>> updateCart(UpdateCartRequest quantity,String id) async{
   final response = await _dataSource.updateCart(quantity,id);
   switch (response) {
     case Success<CartResponse>():
       return Success(data: response.data.toEntity());
     case Failure<CartResponse>():
       return Failure(errorMessage: response.errorMessage);
   }
  }
}

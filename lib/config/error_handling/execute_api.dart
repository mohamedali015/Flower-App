import 'package:flower_app/config/error_handling/result.dart';
import 'handle_exception.dart';

Future<Result<T>> executeApi<T>(Future<T> Function() callApi) async {
  try {
    var result = await callApi.call();
    return Success(data: result);
  } on Exception catch (e) {
    return Failure(errorMessage: NetworkException.getMessageError(e));
  }
}

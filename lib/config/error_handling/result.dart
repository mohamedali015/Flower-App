sealed class Result<T> {}

class Success<T> extends Result<T> {
  final T data;

  Success({required this.data});
}

class Failure<T> extends Result<T> {
  final String errorMessage;

  Failure({required this.errorMessage});
}
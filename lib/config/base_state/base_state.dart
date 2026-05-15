import 'package:equatable/equatable.dart';

class BaseState<T> extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final T? data;

  const BaseState({
    this.isLoading = false,
    this.isSuccess = false,
    this.errorMessage,
    this.data,
  });

  @override
  List<Object?> get props => [isLoading, errorMessage, isSuccess, data];

  BaseState<T> copyWith({
    bool? isLoadingParam,
    bool? isSuccessParam,
    String? errorMessageParam,
    T? dataParam,
  }) {
    return BaseState<T>(
      isLoading: isLoadingParam ?? isLoading,
      isSuccess: isSuccessParam ?? isSuccess,
      errorMessage: errorMessageParam ,
      data: dataParam ?? data,
    );
  }
}

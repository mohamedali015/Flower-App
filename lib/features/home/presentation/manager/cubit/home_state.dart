import 'package:equatable/equatable.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeSuccess extends HomeState {
  final HomeResponseEntity homeResponseEntity;

  const HomeSuccess({required this.homeResponseEntity});

  @override
  List<Object> get props => [homeResponseEntity];
}

final class HomeFailure extends HomeState {
  final String errorMessage;

  const HomeFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

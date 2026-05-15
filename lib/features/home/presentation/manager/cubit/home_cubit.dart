import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/home/domain/entities/home_response_entity.dart';
import 'package:flower_app/features/home/domain/use_cases/get_home_use_case.dart';
import 'package:flower_app/features/home/presentation/manager/cubit/home_events.dart';
import 'package:flower_app/features/home/presentation/manager/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetHomeUseCase _getHomeUseCase;
  HomeCubit(this._getHomeUseCase) : super(HomeInitial());

  void doEvents(HomeEvents event) {
    switch (event) {
      case GetHomeEvent():
        _getHome();
        break;
    }
  }

  Future<void> _getHome() async {
    emit(HomeLoading());
    final result = await _getHomeUseCase.call();

    switch (result) {
      case Success<HomeResponseEntity>():
        emit(HomeSuccess(homeResponseEntity: result.data));
        break;
      case Failure<HomeResponseEntity>():
        emit(HomeFailure(errorMessage: result.errorMessage));
        break;
    }
  }
}

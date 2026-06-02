import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/features/user_address/manger/user_address_events.dart';
import 'package:flower_app/features/user_address/manger/user_address_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:injectable/injectable.dart';

import '../data/models/address_dto.dart';
import '../data/models/user_address_dto.dart';
import '../domain/use_cases/add_user_address_use_case.dart';
import '../domain/use_cases/get_logged_user_address_use_case.dart';
import '../domain/use_cases/remove_user_address_use_case.dart';
import '../domain/use_cases/update_user_address_use_case.dart';

@LazySingleton()
class UserAddressCubit extends Cubit<UserAddressState> {
  UserAddressCubit(
    this._addUserAddressUseCase,
    this._removeUserAddressUseCase,
    this._getLoggedUserAddressUseCase,
    this._updateUserAddressUseCase,
  ) : super(
        const UserAddressState(
          addUserAddressState: BaseState<UserAddressDto>(),
          getLoggedUserAddressState: BaseState<UserAddressDto>(),
          removeUserAddressState: BaseState<UserAddressDto>(),
          updateUserAddressState: BaseState<UserAddressDto>(),
          placeMark: BaseState(),
          currentUserAddress: null,
        ),
      );

  final AddUserAddressUseCase _addUserAddressUseCase;
  final RemoveUserAddressUseCase _removeUserAddressUseCase;
  final UpdateUserAddressUseCase _updateUserAddressUseCase;
  final GetLoggedUserAddressUseCase _getLoggedUserAddressUseCase;

  void doEvent(UserAddressEvents event) {
    switch (event) {
      case AddUserAddressEvent():
        _addUserAddress(newAddress: event.address);
      case UpdateUserAddressEvent():
        _updateUserAddress(newAddress: event.address, id: event.addressId);
      case RemoveUserAddressEvent():
        _removeUserAddress(id: event.addressId);
      case GetLoggedUserAddressEvent():
        _getLoggedUserAddress();
      case PlaceMarkFromCoordinatesEvent():
        _placeMarkFromCoordinates(event.lat, event.long);
    }
  }

  Future<void> _getLoggedUserAddress() async {
    emit(
      state.copyWith(
        getLoggedUserAddressState: const BaseState<UserAddressDto>(
          isLoading: true,
          isSuccess: false,
          errorMessage: null,
          data: null,
        ),
      ),
    );

    var response = await _getLoggedUserAddressUseCase();

    switch (response) {
      case Success<UserAddressDto>():
        emit(
          state.copyWith(
            getLoggedUserAddressState: BaseState<UserAddressDto>(
              isLoading: false,
              isSuccess: true,
              errorMessage: null,
              data: response.data,
            ),
            currentUserAddress: response.data,
          ),
        );
      case Failure<UserAddressDto>():
        emit(
          state.copyWith(
            getLoggedUserAddressState: BaseState<UserAddressDto>(
              isLoading: false,
              isSuccess: false,
              errorMessage: response.errorMessage,
              data: null,
            ),
          ),
        );
    }
  }

  Future<void> _addUserAddress({required AddressDto newAddress}) async {
    emit(
      state.copyWith(
        addUserAddressState: const BaseState(
          isLoading: true,
          isSuccess: false,
          errorMessage: null,
          data: null,
        ),
      ),
    );

    var response = await _addUserAddressUseCase(newAddress);

    switch (response) {
      case Success<UserAddressDto>():
        emit(
          state.copyWith(
            addUserAddressState: BaseState(
              isLoading: false,
              isSuccess: true,
              errorMessage: null,
              data: response.data,
            ),
            currentUserAddress: response.data,
          ),
        );
      case Failure<UserAddressDto>():
        emit(
          state.copyWith(
            addUserAddressState: BaseState(
              isLoading: false,
              isSuccess: false,
              errorMessage: response.errorMessage,
              data: null,
            ),
          ),
        );
    }
  }

  Future<void> _updateUserAddress({
    required AddressDto newAddress,
    required String id,
  }) async {
    emit(
      state.copyWith(
        updateUserAddressState: const BaseState(
          isLoading: true,
          isSuccess: false,
          errorMessage: null,
          data: null,
        ),
      ),
    );

    var response = await _updateUserAddressUseCase(newAddress, id);

    switch (response) {
      case Success<UserAddressDto>():
        emit(
          state.copyWith(
            updateUserAddressState: BaseState(
              isLoading: false,
              isSuccess: true,
              errorMessage: null,
              data: response.data,
            ),
            currentUserAddress: response.data,
          ),
        );
      case Failure<UserAddressDto>():
        emit(
          state.copyWith(
            updateUserAddressState: BaseState(
              isLoading: false,
              isSuccess: false,
              errorMessage: response.errorMessage,
              data: null,
            ),
          ),
        );
    }
  }

  Future<void> _removeUserAddress({required String id}) async {
    emit(
      state.copyWith(
        removeUserAddressState: const BaseState(
          isLoading: true,
          isSuccess: false,
          errorMessage: null,
          data: null,
        ),
      ),
    );

    var response = await _removeUserAddressUseCase(id);

    switch (response) {
      case Success<UserAddressDto>():
        emit(
          state.copyWith(
            removeUserAddressState: BaseState(
              isLoading: false,
              isSuccess: true,
              errorMessage: null,
              data: response.data,
            ),
            currentUserAddress: response.data,
          ),
        );
      case Failure<UserAddressDto>():
        emit(
          state.copyWith(
            removeUserAddressState: BaseState(
              isLoading: false,
              isSuccess: false,
              errorMessage: response.errorMessage,
              data: null,
            ),
          ),
        );
    }
  }

  Future<void> _placeMarkFromCoordinates(String lat, String long) async {
    emit(
      state.copyWith(
        placeMark: const BaseState(
          isLoading: true,
          isSuccess: false,
          data: null,
          errorMessage: null,
        ),
      ),
    );

    final placeMarks = await placemarkFromCoordinates(
      double.parse(lat),
      double.parse(long),
    );

    emit(
      state.copyWith(
        placeMark: BaseState(
          data: placeMarks,
          errorMessage: null,
          isSuccess: true,
          isLoading: false,
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'dart:ui' as ui;

import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/config/error_handling/result.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flower_app/features/user_address/presentation/manger/user_address_events.dart';
import 'package:flower_app/features/user_address/presentation/manger/user_address_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter_platform_interface/src/types/bitmap.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/city.dart';
import '../../data/models/governorate.dart';
import '../../data/models/user_address_dto.dart';
import '../../domain/entities/address.dart';
import '../../domain/use_cases/add_user_address_use_case.dart';
import '../../domain/use_cases/get_logged_user_address_use_case.dart';
import '../../domain/use_cases/remove_user_address_use_case.dart';
import '../../domain/use_cases/update_user_address_use_case.dart';

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
          currentUserAddresses: null,
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
      case MapLoadingEvent():
        _mapLoading(event.mapLoading);
      case LoadCitiesEvent():
        _loadCities();
      case LoadGovernorateEvent():
        _loadGovernorates();
      case SetSelectedGovernorateEvent():
        _setSelectedGovernorate(governorate: event.governorate);
      case SetSelectedCityEvent():
        _setSelectedCity(event.city);
      case SetLocationEvent():
        _setSelectedLocation(event.location);
      case SetMarkerIconEvent():
        _setMarkerIcon();
    }
  }

  Future<void> _getLoggedUserAddress() async {
    emit(
      state.copyWith(
        getLoggedUserAddressState: const BaseState<List<Address>>(
          isLoading: true,
          isSuccess: false,
          errorMessage: null,
          data: null,
        ),
      ),
    );

    var response = await _getLoggedUserAddressUseCase();

    switch (response) {
      case Success<List<Address>>():
        emit(
          state.copyWith(
            getLoggedUserAddressState: BaseState<List<Address>>(
              isLoading: false,
              isSuccess: true,
              errorMessage: null,
              data: response.data,
            ),
            currentUserAddress: response.data,
          ),
        );
      case Failure<List<Address>>():
        emit(
          state.copyWith(
            getLoggedUserAddressState: BaseState<List<Address>>(
              isLoading: false,
              isSuccess: false,
              errorMessage: response.errorMessage,
              data: null,
            ),
          ),
        );
    }
  }

  Future<void> _addUserAddress({required Address newAddress}) async {
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
      case Success<List<Address>>():
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
      case Failure<List<Address>>():
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
    required Address newAddress,
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
      case Success<List<Address>>():
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
      case Failure<List<Address>>():
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
      case Success<List<Address>>():
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
      case Failure<List<Address>>():
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

  void _mapLoading(bool mapLoading) {
    emit(state.copyWith(mapLoading: mapLoading));
  }

  Future<void> _loadCities() async {
    emit(state.copyWith(cities: null));
    final jsonString = await rootBundle.loadString('assets/states.json');

    final List<dynamic> jsonData = jsonDecode(jsonString);

    final table = jsonData.firstWhere(
      (item) => item['type'] == 'table' && item['name'] == 'cities',
    );

    final List<dynamic> citiesData = table['data'];

    final cities = citiesData
        .map((e) => City.fromJson(e as Map<String, dynamic>))
        .toList();

    emit(state.copyWith(cities: cities));
  }

  Future<void> _loadGovernorates() async {
    emit(state.copyWith(governorates: null));
    final String jsonString = await rootBundle.loadString('assets/cities.json');

    final List<dynamic> jsonData = jsonDecode(jsonString);

    final table = jsonData.firstWhere(
      (item) => item['type'] == 'table' && item['name'] == 'governorates',
    );

    final governorate = (table['data'] as List)
        .map((e) => Governorate.fromJson(e))
        .toList();

    emit(state.copyWith(governorates: governorate));
  }

  void _setSelectedGovernorate({required Governorate governorate}) {
    final filteredCities = _loadFilteredCities(governorate.id);
    emit(
      state.copyWith(
        selectedGovernorate: governorate,
        filteredCities: filteredCities,
        selectedLocation: state.selectedLocation,
      ),
    );
  }

  void _setSelectedCity(City? city) {
    emit(
      state.copyWith(
        selectedCity: city,
        filteredCities: state.filteredCities,
        selectedLocation: state.selectedLocation,
      ),
    );
  }

  List<City>? _loadFilteredCities(int governorateID) {
    final filteredCities = state.cities?.where((city) {
      return city.governorateId == governorateID;
    }).toList();

    return filteredCities;
  }

  void _setSelectedLocation(LatLng location) {
    emit(
      state.copyWith(
        selectedLocation: location,
        filteredCities: state.filteredCities,
        selectedGovernorate: state.selectedGovernorate,
        selectedCity: state.selectedCity,
      ),
    );
  }

  Future<void> _setMarkerIcon() async {
    final svgString = await rootBundle.loadString(AppAssets.locationPicker);

    final pictureInfo = await vg.loadPicture(SvgStringLoader(svgString), null);

    final image = await pictureInfo.picture.toImage(45, 45);

    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    final markerIcon = BitmapDescriptor.bytes(byteData!.buffer.asUint8List());

    emit(state.copyWith(markerIcon: markerIcon));
  }
}

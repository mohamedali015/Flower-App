import 'dart:async';

import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/helpers/validator.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/features/user_address/data/models/governorate.dart';
import 'package:flower_app/features/user_address/presentation/manger/user_address_cubit.dart';
import 'package:flower_app/features/user_address/presentation/manger/user_address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/models/city.dart';
import '../../domain/entities/address.dart';
import '../manger/user_address_events.dart';

class AddAddressScreen extends StatefulWidget {
  AddAddressScreen({super.key, this.editAddress});

  Address? editAddress;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.039551857900626, 31.233740663484312),
    zoom: 14,
  );

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController addressController;

  late TextEditingController phoneNumberController;

  late TextEditingController recipientNameController;

  late TextEditingController streetController;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late UserAddressCubit userAddressCubit;

  Set<Marker> markers = {};

  @override
  void initState() {
    userAddressCubit = context.read<UserAddressCubit>();
    addressController = TextEditingController();
    phoneNumberController = TextEditingController();
    recipientNameController = TextEditingController();
    streetController = TextEditingController();
    userAddressCubit.doEvent(SetMarkerIconEvent());
    if (widget.editAddress != null) {
      addressController.text =
          widget.editAddress!.placeMarks?.firstOrNull?.subAdministrativeArea ??
          "";
      phoneNumberController.text = widget.editAddress!.phone ?? "";
      recipientNameController.text = widget.editAddress!.username ?? "";
      streetController.text = widget.editAddress!.street ?? "";
      markers.add(
        Marker(
          icon:
              userAddressCubit.state.markerIcon ??
              BitmapDescriptor.defaultMarker,
          markerId: const MarkerId('selected_location'),
          position: LatLng(
            double.parse(widget.editAddress!.lat ?? ""),
            double.parse(widget.editAddress!.long ?? ""),
          ),
        ),
      );
    }
    userAddressCubit.doEvent(MapLoadingEvent(true));
    userAddressCubit.doEvent(LoadGovernorateEvent());
    userAddressCubit.doEvent(LoadCitiesEvent());
    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    phoneNumberController.dispose();
    recipientNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    String appBarTitle = widget.editAddress != null
        ? local.edit_address
        : local.add_address;

    String btnTitle = widget.editAddress != null
        ? local.update_address
        : local.add_address;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(appBarTitle),
      ),
      body: Padding(
        padding: MyResponsive.paddingSymmetric(context, horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                BlocBuilder<UserAddressCubit, UserAddressState>(
                  buildWhen: (previous, current) =>
                      previous.mapLoading != current.mapLoading ||
                      previous.selectedLocation != current.selectedLocation,
                  builder: (context, state) {
                    return SizedBox(
                      height: MyResponsive.height(context, value: 145),
                      child: Stack(
                        children: [
                          GoogleMap(
                            onTap: (position) {
                              markers.clear();
                              markers.add(
                                Marker(
                                  markerId: const MarkerId('selected_location'),
                                  position: position,
                                  icon:
                                      state.markerIcon ??
                                      BitmapDescriptor.defaultMarker,
                                ),
                              );
                              userAddressCubit.doEvent(
                                SetLocationEvent(position),
                              );
                            },
                            initialCameraPosition:
                                AddAddressScreen._kGooglePlex,
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                              userAddressCubit.doEvent(MapLoadingEvent(false));
                            },
                            markers: markers,
                          ),
                          if (state.mapLoading)
                            const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: MyResponsive.height(context, value: 48)),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: local.address),
                ),
                SizedBox(height: MyResponsive.height(context, value: 24)),
                TextFormField(
                  controller: streetController,
                  decoration: InputDecoration(labelText: local.street),
                  validator: (value) => Validator.name(value),
                ),
                SizedBox(height: MyResponsive.height(context, value: 24)),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(labelText: local.phoneNumber),
                  validator: (value) => Validator.name(value),
                ),
                SizedBox(height: MyResponsive.height(context, value: 24)),
                TextFormField(
                  controller: recipientNameController,
                  decoration: InputDecoration(labelText: local.recipient_name),
                  validator: (value) => Validator.name(value),
                ),
                SizedBox(height: MyResponsive.height(context, value: 24)),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: BlocBuilder<UserAddressCubit, UserAddressState>(
                        buildWhen: (previous, current) =>
                            previous.governorates != current.governorates,
                        builder:
                            (BuildContext context, UserAddressState state) {
                              if (state.governorates == null) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              return DropdownButtonFormField<Governorate?>(
                                initialValue: state.selectedGovernorate,
                                isExpanded: true,
                                decoration: const InputDecoration(
                                  labelText: 'Governorate',
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                ),
                                items: state.governorates?.map((g) {
                                  return DropdownMenuItem(
                                    value: g,
                                    child: Text(
                                      g.governorateNameEn,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (governorate) {
                                  if (governorate != null) {
                                    userAddressCubit.doEvent(
                                      SetSelectedGovernorateEvent(governorate),
                                    );
                                  }
                                },
                              );
                            },
                      ),
                    ),
                    SizedBox(width: MyResponsive.width(context, value: 17)),
                    Expanded(
                      child: BlocBuilder<UserAddressCubit, UserAddressState>(
                        buildWhen: (previous, current) =>
                            previous.filteredCities != current.filteredCities ||
                            previous.selectedCity != current.selectedCity,
                        builder: (BuildContext context, state) {
                          return DropdownButtonFormField<City?>(
                            validator: (value) =>
                                Validator.name(value?.cityNameEn),
                            initialValue: state.selectedCity,
                            isExpanded: true,
                            decoration: const InputDecoration(
                              labelText: 'City',
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 10,
                              ),
                            ),
                            items: state.filteredCities?.map((city) {
                              return DropdownMenuItem(
                                value: city,
                                child: Text(
                                  city.cityNameEn,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                            onChanged: (city) {
                              if (city != null) {
                                userAddressCubit.doEvent(
                                  SetSelectedCityEvent(city),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: MyResponsive.height(context, value: 24)),
                BlocConsumer<UserAddressCubit, UserAddressState>(
                  buildWhen: (previous, current) {
                    return previous.addUserAddressState !=
                            current.addUserAddressState ||
                        previous.updateUserAddressState !=
                            current.updateUserAddressState;
                  },
                  builder: (BuildContext context, state) {
                    if (state.addUserAddressState.isLoading ||
                        state.updateUserAddressState.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final uploadAddress = Address(
                            id: widget.editAddress?.id,
                            lat: userAddressCubit
                                .state
                                .selectedLocation
                                ?.latitude
                                .toString(),
                            long: userAddressCubit
                                .state
                                .selectedLocation
                                ?.longitude
                                .toString(),
                            city: userAddressCubit.state.selectedCity
                                .toString(),
                            phone: phoneNumberController.text,
                            street: streetController.text,
                            username: recipientNameController.text,
                          );
                          if (widget.editAddress != null) {
                            userAddressCubit.doEvent(
                              UpdateUserAddressEvent(
                                uploadAddress,
                                uploadAddress.id!,
                              ),
                            );
                          } else {
                            userAddressCubit.doEvent(
                              AddUserAddressEvent(uploadAddress),
                            );
                          }
                        }
                      },
                      child: Text(btnTitle),
                    );
                  },
                  listenWhen: (previous, current) {
                    return previous.addUserAddressState !=
                            current.addUserAddressState ||
                        previous.updateUserAddressState !=
                            current.updateUserAddressState;
                  },
                  listener: (BuildContext context, state) {
                    if (state.addUserAddressState.errorMessage != null ||
                        state.updateUserAddressState.errorMessage != null) {
                      if (widget.editAddress != null) {
                        AppSnackBar.error(
                          context,
                          state.updateUserAddressState.errorMessage!,
                        );
                      } else {
                        AppSnackBar.error(
                          context,
                          state.addUserAddressState.errorMessage!,
                        );
                      }
                    }
                    if (state.addUserAddressState.isSuccess ||
                        state.updateUserAddressState.isSuccess) {
                      if (widget.editAddress != null) {
                        AppSnackBar.success(
                          context,
                          local.success_update_address,
                        );
                      } else {
                        AppSnackBar.success(context, local.success_add_address);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

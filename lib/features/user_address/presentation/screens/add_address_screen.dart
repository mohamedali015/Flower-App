import 'dart:async';

import 'package:flower_app/core/helpers/my_responsive.dart';
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
  late TextEditingController addressController;

  late TextEditingController phoneNumberController;

  late TextEditingController recipientNameController;

  Governorate? selectedGovernorate;
  City? selectedCity;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late UserAddressCubit userAddressCubit;

  @override
  void initState() {
    addressController = TextEditingController();
    phoneNumberController = TextEditingController();
    recipientNameController = TextEditingController();
    if (widget.editAddress != null) {
      addressController.text =
          widget.editAddress!.placeMarks?.firstOrNull?.subAdministrativeArea ??
          "";
      phoneNumberController.text = widget.editAddress!.phone ?? "";
      recipientNameController.text = widget.editAddress!.username ?? "";
    }
    userAddressCubit = context.read<UserAddressCubit>();
    userAddressCubit.doEvent(MapLoadingEvent(true));
    userAddressCubit.doEvent(LoadGovernorateEvent());
    userAddressCubit.doEvent(ClearCitiesListEvent());
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(local.add_address),
      ),
      body: Padding(
        padding: MyResponsive.paddingSymmetric(context, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<UserAddressCubit, UserAddressState>(
                builder: (context, state) {
                  return SizedBox(
                    height: MyResponsive.height(context, value: 145),
                    child: Stack(
                      children: [
                        GoogleMap(
                          onTap: (argument) {

                          },
                          initialCameraPosition: AddAddressScreen._kGooglePlex,
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                            userAddressCubit.doEvent(MapLoadingEvent(false));
                          },
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
                controller: phoneNumberController,
                decoration: InputDecoration(labelText: local.phoneNumber),
              ),
              SizedBox(height: MyResponsive.height(context, value: 24)),
              TextFormField(
                controller: recipientNameController,
                decoration: InputDecoration(labelText: local.recipient_name),
              ),
              SizedBox(height: MyResponsive.height(context, value: 24)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: BlocBuilder<UserAddressCubit, UserAddressState>(
                      buildWhen: (previous, current) =>
                          previous.governorate != current.governorate,
                      builder: (BuildContext context, UserAddressState state) {
                        if (state.governorate == null) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return DropdownButtonFormField<Governorate?>(
                          initialValue: selectedGovernorate,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'Governorate',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                          ),
                          items: state.governorate?.map((g) {
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
                              selectedGovernorate = governorate;
                              userAddressCubit.doEvent(
                                LoadCitiesEvent(governorate.id),
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
                          previous.cities != current.cities,
                      builder: (BuildContext context, state) {
                        return DropdownButtonFormField<City?>(
                          initialValue: selectedCity,
                          isExpanded: true,
                          decoration: const InputDecoration(
                            labelText: 'City',
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                          ),
                          items: state.cities?.map((city) {
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
                              selectedCity = city;
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: MyResponsive.height(context, value: 24)),
              ElevatedButton(
                onPressed: () {
                  if(widget.editAddress != null){

                  }else{

                  }
                },
                child: Text(local.add_address),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

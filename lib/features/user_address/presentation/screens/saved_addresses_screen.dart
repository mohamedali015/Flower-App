import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/features/user_address/presentation/manger/user_address_cubit.dart';
import 'package:flower_app/features/user_address/presentation/manger/user_address_state.dart';
import 'package:flower_app/features/user_address/presentation/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../manger/user_address_events.dart';

class SavedAddressesScreen extends StatelessWidget {
  const SavedAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userAddressCubit = context.read<UserAddressCubit>();
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
        title: Text(local.saved_address),
      ),
      body: Padding(
        padding: MyResponsive.paddingSymmetric(context, horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocConsumer<UserAddressCubit, UserAddressState>(
                builder: (context, state) {
                  if (state.getLoggedUserAddressesState.isLoading ||
                      state.removeUserAddressState.isLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (state.getLoggedUserAddressesState.errorMessage != null) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            Text(
                              state.getLoggedUserAddressesState.errorMessage!,
                              style: AppTextStyles.medium14(context),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                userAddressCubit.doEvent(
                                  GetLoggedUserAddressesEvent(),
                                );
                              },
                              child: const Text("Retry"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (state.currentUserAddresses == null ||
                      state.currentUserAddresses!.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32),
                        child: Column(
                          children: [
                            const SvgWrapper(
                              path: AppAssets.location,
                              width: 64,
                              height: 64,
                              // color: AppColors.grayDark, // Assuming SvgWrapper might support color or it's already styled
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "No saved addresses yet",
                              style: AppTextStyles.medium14(context).copyWith(
                                color: AppColors.grayDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return Column(
                    children: List.generate(
                      state.currentUserAddresses!.length,
                      (index) {
                        return AddressCard(state.currentUserAddresses![index]);
                      },
                    ),
                  );
                },
                listenWhen: (previous, current) =>
                    previous.removeUserAddressState !=
                        current.removeUserAddressState ||
                    previous.getLoggedUserAddressesState !=
                        current.getLoggedUserAddressesState,
                listener: (BuildContext context, UserAddressState state) {
                  if (state.removeUserAddressState.isLoading == false &&
                      state.removeUserAddressState.errorMessage != null) {
                    AppSnackBar.error(
                      context,
                      state.removeUserAddressState.errorMessage!,
                    );
                  }
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.addAddressRoute);
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

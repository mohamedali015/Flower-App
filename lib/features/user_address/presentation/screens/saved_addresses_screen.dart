import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/features/user_address/presentation/manger/user_address_cubit.dart';
import 'package:flower_app/features/user_address/presentation/manger/user_address_state.dart';
import 'package:flower_app/features/user_address/presentation/widgets/address_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/l10n/app_localizations.dart';

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
                  if (state.removeUserAddressState.isLoading) {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: List.generate(
                      userAddressCubit.state.currentUserAddress!.length,
                          (index) {
                        return AddressCard(
                          userAddressCubit.state.currentUserAddress![index],
                        );
                      },
                    ),
                  );
                },
                listenWhen: (previous, current) =>
                previous.removeUserAddressState !=
                    current.removeUserAddressState,
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
              ElevatedButton(onPressed: () {}, child: Text(local.add_address)),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flower_app/features/user_address/presentation/manger/user_address_cubit.dart';
import 'package:flower_app/features/user_address/presentation/manger/user_address_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class SavedAddressesScreen extends StatelessWidget {
  SavedAddressesScreen({super.key});

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
        title: Text(local.occasion),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<UserAddressCubit, UserAddressState>(
          builder: (context, state) {
            return Column(
              children: List.generate(
                userAddressCubit.state.currentUserAddress!.length,
                (index) {
                  return Text(state.currentUserAddress![index].city!);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

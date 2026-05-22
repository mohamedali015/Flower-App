import 'package:flower_app/config/user/manager/user_cubit.dart';
import 'package:flower_app/config/user/manager/user_events.dart';
import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/user/manager/user_state.dart';
import '../../../../core/cubit/locale/locale_cubit.dart';
import '../widgets/profile_screen_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final userCubit = context.read<UserCubit>()..doEvent(GetUserDataEvent());
    return BlocConsumer<UserCubit, UserState>(
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (BuildContext context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!state.isLoading && state.error != null) {
          return Center(
            child: ElevatedButton(
              onPressed: () => userCubit.doEvent(GetUserDataEvent()),
              child: const Text("Retry"),
            ),
          );
        }
        return ProfileScreenView();
      },
      listenWhen: (previous, current) {
        return current.error != null;
      },
      listener: (BuildContext context, UserState state) {
        AppSnackBar.error(context, state.error!);
      },
    );
  }
}

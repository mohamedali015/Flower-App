import 'package:flower_app/config/user/manager/user_cubit.dart';
import 'package:flower_app/config/user/manager/user_events.dart';
import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/user/manager/user_state.dart';
import '../widgets/profile_screen_view.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().doEvent(GetUserDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      builder: (BuildContext context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!state.isLoading && state.error != null || state.user == null) {
          return Center(
            child: ElevatedButton(
              onPressed: () =>
                  context.read<UserCubit>().doEvent(GetUserDataEvent()),
              child: const Text("Retry"),
            ),
          );
        }
        return ProfileScreenView(user: state.user!);
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

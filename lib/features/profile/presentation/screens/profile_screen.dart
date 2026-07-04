import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/config/user/manager/user_cubit.dart';
import 'package:flower_app/config/user/manager/user_events.dart';
import 'package:flower_app/core/helpers/app_snack_bar.dart';
import 'package:flower_app/core/shared_widgets/custom_error_widget.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/user/manager/user_state.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_constants.dart';
import '../../../notifications/presentation/manager/notifications_cubit.dart';
import '../../../notifications/presentation/manager/notifications_events.dart';
import '../../../notifications/presentation/manager/notifications_state.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationsCubit>().doEvent(GetUnreadCountEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Image.asset(
          AppAssets.logo,
          height: MyResponsive.height(context, value: 25),
          width: MyResponsive.width(context, value: 90),
        ),
        actions: [
          BlocBuilder<NotificationsCubit, NotificationsState>(
            buildWhen: (previous, current) =>
                previous.unreadCountState != current.unreadCountState,
            builder: (context, state) {
              final unreadCount = state.unreadCountState.data?.unreadCount ?? 0;

              return IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.notificationScreenRoute);
                },
                icon: Badge(
                  label: Text(
                    '$unreadCount',
                    style: AppTextStyles.medium10(
                      context,
                    ).copyWith(color: AppColors.white),
                  ),
                  isLabelVisible: true,
                  backgroundColor: AppColors.error,
                  largeSize: 16,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: const SvgWrapper(
                    path: AppAssets.notification,
                    width: 24,
                    height: 24,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 4),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.paddingHorizontal,
        ),
        child: BlocConsumer<UserCubit, UserState>(
          builder: (BuildContext context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!state.isLoading && state.error != null || state.user == null) {
              return CustomErrorWidget(
                errorMessage: state.error!,
                haveTryAgain: true,
                onPressed: () =>
                    context.read<UserCubit>().doEvent(GetUserDataEvent()),
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
        ),
      ),
    );
  }
}

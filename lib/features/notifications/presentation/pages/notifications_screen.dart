import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_error_widget.dart';
import 'package:flower_app/core/shared_widgets/custom_loading_indicator.dart';
import 'package:flower_app/features/notifications/presentation/manager/notifications_cubit.dart';
import 'package:flower_app/features/notifications/presentation/manager/notifications_events.dart';
import 'package:flower_app/features/notifications/presentation/manager/notifications_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/notification_list_view_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchNotifications();
    });
  }

  Future<void> _fetchNotifications() async {
    context.read<NotificationsCubit>().doEvent(GetNotificationsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(local.notification)),
      body: RefreshIndicator(
        onRefresh: _fetchNotifications,
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            final notificationsState = state.notificationsState;
            final notifications = notificationsState.data?.notifications ?? [];

            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                if (notificationsState.isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: CustomLoadingIndicator(),
                  )
                else if (notificationsState.errorMessage != null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomErrorWidget(
                        errorMessage: notificationsState.errorMessage!,
                        haveTryAgain: true,
                        onPressed: _fetchNotifications,
                      ),
                    ),
                  )
                else if (notifications.isEmpty)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomErrorWidget(
                        errorMessage: local.noNotificationsYet,
                      ),
                    ),
                  )
                else
                  SliverList.separated(
                    itemCount: notifications.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: NotificationListViewItem(
                          entity: notifications[index],
                        ),
                      );
                    },
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

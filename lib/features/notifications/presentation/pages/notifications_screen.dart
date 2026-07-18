import 'package:flower_app/config/user/manager/user_cubit.dart';
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
    final currentUserId = context.read<UserCubit>().state.user?.id ?? '';
    final languageCode = AppLocalizations.of(context)!.localeName;

    // استدعاء الـ Event المخصص للـ Firestore
    context.read<NotificationsCubit>().doEvent(
      GetFiretoreNotificationsEvent(
        userId: currentUserId,
        languageCode: languageCode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(local.notification), centerTitle: true),
      body: SafeArea(
        child: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            // القراءة من الـ firestoreNotificationsState الجديدة
            final firestoreState = state.firestoreNotificationsState;
            final notifications = firestoreState.data ?? [];

            return CustomScrollView(
              slivers: [
                if (firestoreState.isLoading)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: CustomLoadingIndicator()),
                  )
                // التعديل هنا: فحص ما إذا كان هناك رسالة خطأ (لأن الكلاس لا يحتوي على isError)
                else if (firestoreState.errorMessage != null)
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomErrorWidget(
                        errorMessage: firestoreState.errorMessage!,
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

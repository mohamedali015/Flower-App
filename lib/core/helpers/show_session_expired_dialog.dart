import 'package:flutter/material.dart';

import '../shared_widgets/session_expired_dialog.dart';
import '../utils/app_constants.dart';

void showSessionExpiredDialog() {
  showDialog(
    context: AppConstants.navigatorKey.currentContext!,
    barrierDismissible: false,
    builder: (_) => const SessionExpiredDialog(),
  );
}

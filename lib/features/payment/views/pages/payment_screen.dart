import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/custom_logger.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/localization/l10n/app_localizations.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.paymentUrl});

  final String paymentUrl;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            final url = request.url;

            CustomLogger.white('Current Url => $url');

            if (url.contains('allOrders')) {
              CustomLogger.bgGreen("Payment Successful");

              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.bottomNavBarRoute,
                arguments: {"initialIndex": 2},
                (route) => false,
              );

              return NavigationDecision.prevent;
            }

            if (url.contains('cart')) {
              CustomLogger.red("Payment Failed");

              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.bottomNavBarRoute,
                arguments: {"initialIndex": 2},
                (route) => false,
              );

              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  late AppLocalizations local;

  @override
  void didChangeDependencies() {
    local = AppLocalizations.of(context)!;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(local.payment)),
      body: WebViewWidget(controller: _controller),
    );
  }
}

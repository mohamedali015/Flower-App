import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/custom_logger.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/localization/l10n/app_localizations.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  static const paymentUrl =
      "https://checkout.stripe.com/c/pay/cs_test_a1g6yyPhy4aLql8K2X4ltGBatayBZOghX0b5xgOuPdBev98nrp2z2SJwvM#fidnandhYHdWcXxpYCc%2FJ2FgY2RwaXEnKSdicGRmZGhqaWBTZHdsZGtxJz8nZmprcXdqaScpJ2R1bE5gfCc%2FJ3VuWnFgdnFaMDRIdWJiXUA1VjJTak5faFVVb0BKZkFQSWlrYUtWcFRAajZQV25QSEhcfH1oSGNqcEZnU3FndEo1VW1dbFxJMnxDPHZpZmRQQGkxckJdVEdOQjFnMFJmaEQ1NTFgdUoxSlBXJyknY3dqaFZgd3Ngdyc%2FcXdwYCknZ2RmbmJ3anBrYUZqaWp3Jz8nJmNjY2NjYycpJ2lkfGpwcVF8dWAnPyd2bGtiaWBabHFgaCcpJ2BrZGdpYFVpZGZgbWppYWB3dic%2FcXdwYHgl";
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
      ..loadRequest(Uri.parse(paymentUrl));
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

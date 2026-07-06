import 'package:flower_app/config/route_manager/routes.dart';
import 'package:flower_app/core/helpers/custom_logger.dart';
import 'package:flower_app/core/shared_widgets/custom_loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../../../../core/shared_widgets/custom_error_widget.dart';
import '../../../../core/utils/app_constants.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key, required this.paymentUrl});

  final String paymentUrl;

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
          },
          onWebResourceError: (error) {
            setState(() {
              _isLoading = false;
              _hasError = true;
            });
          },
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
      body: Stack(
        children: [
          if (!_hasError)
            AbsorbPointer(
              absorbing: _isLoading,
              child: WebViewWidget(controller: _controller),
            ),
          if (_isLoading) const CustomLoadingIndicator(),
          if (_hasError)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.paddingHorizontal,
              ),
              child: CustomErrorWidget(
                errorMessage: local.unexpectedErrorMessage,
                haveTryAgain: true,
                onPressed: () {
                  _controller.reload();
                },
              ),
            ),
        ],
      ),
    );
  }
}

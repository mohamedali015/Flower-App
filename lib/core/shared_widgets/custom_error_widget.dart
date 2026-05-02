import 'package:flutter/material.dart';
import '../helpers/my_responsive.dart';
import '../values/app_strings.dart';
import 'custom_button.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    required this.errorMessage,
    this.haveTryAgain = false,
    this.onPressed,
  });

  final String errorMessage;
  final bool haveTryAgain;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            // style: AppTextStyles.bold16(),
            textAlign: TextAlign.center,
          ),
          if (haveTryAgain) ...[
            SizedBox(height: MyResponsive.height(value: 32, context)),
            CustomButton(
                onPressed: onPressed,
                title: AppStrings.tryAgain
            ),
          ],
        ],
      ),
    );
  }
}


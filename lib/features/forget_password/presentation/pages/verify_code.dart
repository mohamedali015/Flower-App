import 'package:flower_app/features/forget_password/presentation/manager/cubit/forget_password_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/values/app_strings.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode();
  @override
  Widget build(BuildContext context) {

    final cubit = context.read<ForgetPasswordCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.password),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Center(child: Text(cubit.state.resetCode!),),
    );
  }
}

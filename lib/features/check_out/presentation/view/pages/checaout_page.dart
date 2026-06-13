import 'package:flower_app/config/di/di.dart';
import 'package:flower_app/features/check_out/presentation/manager/checkout_cubit.dart';
import 'package:flower_app/features/check_out/presentation/view/screen/check_out_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckoutCubit>(
      create: (context) => getIt<CheckoutCubit>(),
      child: const CheckOutScreen(),
    );
  }
}

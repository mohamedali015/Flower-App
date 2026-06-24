import 'dart:async';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/di/di.dart';
import '../../config/route_manager/routes.dart';
import '../../config/secure_cache/secure_cache/cache_keys.dart';
import '../../config/secure_cache/secure_cache/secure_cache.dart';
import '../../config/user/manager/user_cubit.dart';
import '../../config/user/manager/user_events.dart';
import '../../config/user/manager/user_state.dart';
import '../../core/utils/app_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final Completer<void> _animationDone = Completer<void>();
  final Completer<bool> _dataResult = Completer<bool>();

  bool _stopNavigation = false;

  @override
  void initState() {
    super.initState();
    _setupAnimation();
    _checkUser();
    _waitAndNavigate();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && !_animationDone.isCompleted) {
        _animationDone.complete();
      }
    });
  }

  void _checkUser() async {
    final cubit = context.read<UserCubit>();
    final secureCache = getIt<SecureCache>();

    final token = await secureCache.getData(key: CacheKeys.token);
    final rememberMe = await secureCache.getData(key: CacheKeys.rememberMe);

    if (!mounted) return;

    if (token != null && token.isNotEmpty && rememberMe == 'true') {
      cubit.doEvent(GetUserDataEvent());
    } else {
      if (!_dataResult.isCompleted) {
        _dataResult.complete(false);
      }
    }
  }

  void _waitAndNavigate() async {
    final results = await Future.wait([
      _animationDone.future,
      _dataResult.future,
    ]);

    if (!mounted || _stopNavigation) return;

    final isSuccess = results[1] as bool;

    if (isSuccess) {
      Navigator.pushReplacementNamed(context, Routes.bottomNavBarRoute);
    } else {
      Navigator.pushReplacementNamed(context, Routes.loginRoute);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state.isUnauthorized) {
            _stopNavigation = true;

            if (!_dataResult.isCompleted) {
              _dataResult.complete(false);
            }
            return;
          }

          if (_dataResult.isCompleted) return;

          if (state.user != null) {
            _dataResult.complete(true);
          } else if (!state.isLoading) {
            _dataResult.complete(false);
          }
        },
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SvgWrapper(
              path: AppAssets.appLogo,
              width: MyResponsive.width(context, value: 240),
              height: MyResponsive.height(context, value: 240),
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

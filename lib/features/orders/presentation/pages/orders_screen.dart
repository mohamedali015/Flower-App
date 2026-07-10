import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_error_widget.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flower_app/features/orders/domain/entities/orders_entity.dart';
import 'package:flower_app/features/orders/presentation/manager/orders_cubit.dart';
import 'package:flower_app/features/orders/presentation/manager/orders_events.dart';
import 'package:flower_app/features/orders/presentation/manager/orders_state.dart';
import 'package:flower_app/features/orders/presentation/widgets/orders_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late AppLocalizations local;
  late OrdersCubit cubit;
  bool isFirstOrdersLoaded = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    local = AppLocalizations.of(context)!;
    cubit = context.read<OrdersCubit>();

    if (!isFirstOrdersLoaded) {
      isFirstOrdersLoaded = true;
      cubit.doEvent(GetOrdersEvent());
    }

    super.didChangeDependencies();
  }

  Widget _buildOrdersTab(List<OrdersEntity> orders, bool isFetchingMore) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          local.noOrdersFound,
          style: AppTextStyles.medium14(
            context,
          ).copyWith(color: AppColors.grayDark),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        cubit.doEvent(GetOrdersEvent());
      },
      child: OrdersList(
        context: context,
        local: local,
        orders: orders,
        cubit: cubit,
        isFetchingMore: isFetchingMore,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(local.myOrders),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: AppColors.primaryColor,
          labelColor: AppColors.primaryColor,
          indicatorWeight: 3,
          labelStyle: AppTextStyles.regular16(context),
          unselectedLabelStyle: AppTextStyles.regular16(context),

          unselectedLabelColor: AppColors.hintTextGray,
          tabs: [
            Tab(text: local.active),
            Tab(text: local.completed),
          ],
        ),
      ),
      body: BlocConsumer<OrdersCubit, OrdersState>(
        listener: (context, state) {},
        listenWhen: (previous, current) {
          return previous.ordersState != current.ordersState;
        },
        buildWhen: (previous, current) {
          return previous.ordersState != current.ordersState;
        },
        builder: (context, state) {
          final ordersData = state.ordersState.data;
          final activeOrders = ordersData?.active ?? [];
          final completedOrders = ordersData?.delivered ?? [];
          final isFetchingMore = state.isFetchingMore;

          if (state.ordersState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.ordersState.errorMessage != null &&
              state.ordersState.errorMessage!.isNotEmpty) {
            return CustomErrorWidget(
              errorMessage: state.ordersState.errorMessage!,
              haveTryAgain: true,
              onPressed: () {
                cubit.doEvent(GetOrdersEvent());
              },
            );
          }

          return TabBarView(
            controller: _tabController,
            children: [
              _buildOrdersTab(activeOrders, isFetchingMore),
              _buildOrdersTab(completedOrders, isFetchingMore),
            ],
          );
        },
      ),
    );
  }
}

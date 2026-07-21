import 'dart:async';

import 'package:flower_app/config/base_cubit/base_event.dart';
import 'package:flower_app/config/base_state/base_state.dart';
import 'package:flower_app/core/localization/l10n/app_localizations.dart';
import 'package:flower_app/core/shared_widgets/custom_loading_indicator.dart';
import 'package:flower_app/features/track_order/domain/entities/driver_entity.dart';
import 'package:flower_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flower_app/features/track_order/presentation/manager/track_order_cubit.dart';
import 'package:flower_app/features/track_order/presentation/manager/track_order_events.dart';
import 'package:flower_app/features/track_order/presentation/manager/track_order_state.dart';
import 'package:flower_app/features/track_order/presentation/pages/track_order_screen.dart';
import 'package:flower_app/features/track_order/presentation/widgets/contact_address_card.dart';
import 'package:flower_app/features/track_order/presentation/widgets/estimated_arrived_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_screen_test.mocks.dart';

@GenerateMocks([TrackOrderCubit])
void main() {
  late MockTrackOrderCubit mockCubit;
  late StreamController<BaseEvent> eventController;

  setUp(() {
    mockCubit = MockTrackOrderCubit();
    eventController = StreamController<BaseEvent>();

    when(mockCubit.state).thenReturn(const TrackOrderState());
    when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
    when(mockCubit.eventStream).thenAnswer((_) => eventController.stream);
  });

  tearDown(() async {
    await eventController.close();
  });

  Future<void> pumpScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      BlocProvider<TrackOrderCubit>.value(
        value: mockCubit,
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale('en'),
          home: TrackOrderScreen(orderId: '123'),
        ),
      ),
    );
    await tester.pump();
  }

  final tOrder = TrackOrderEntity(
    id: '123',
    orderNumber: 'ORD-1',
    orderStatus: 'on the way',
    isActive: true,
    driverId: 'driver1',
    totalPrice: 100,
    paymentType: 'cash',
    isPaid: false,
    isDelivered: false,
    state: '',
    createdAt: '',
    updatedAt: DateTime.now().toIso8601String(),
    paidAt: '',
    v: 0,
    user: const TrackOrderUserEntity(
      id: '',
      firstName: '',
      lastName: '',
      email: '',
      phone: '',
      photo: '',
    ),
    store: const TrackOrderStoreEntity(
      name: '',
      image: '',
      phoneNumber: '',
      address: '',
      latLong: '',
    ),
    shippingAddress: const TrackOrderShippingAddressEntity(
      street: 'Main St',
      city: '',
      phone: '',
      lat: '',
      long: '',
    ),
    orderItems: const [],
    currentLocation: const TrackOrderCurrentLocationEntity(
      latitude: 0,
      longitude: 0,
    ),
  );

  const tDriver = DriverEntity(
    firstName: 'John',
    lastName: 'Doe',
    email: 'j@j.com',
    phone: '123456',
  );

  group('TrackOrderScreen Widget Tests', () {
    testWidgets('should show loading indicator when state is loading', (
      tester,
    ) async {
      when(mockCubit.state).thenReturn(
        const TrackOrderState(trackOrderState: BaseState(isLoading: true)),
      );

      await pumpScreen(tester);

      expect(find.byType(CustomLoadingIndicator), findsOneWidget);
    });

    testWidgets('should show order pending when data is null', (tester) async {
      when(mockCubit.state).thenReturn(const TrackOrderState());

      await pumpScreen(tester);

      expect(find.text('Order is pending'), findsOneWidget);
      expect(find.byIcon(Icons.hourglass_empty), findsOneWidget);
    });

    testWidgets(
      'should render order details and show map button when data is available',
      (tester) async {
        when(mockCubit.state).thenReturn(
          TrackOrderState(
            trackOrderState: BaseState(data: tOrder, isSuccess: true),
          ),
        );

        await pumpScreen(tester);

        expect(find.byType(EstimatedArrivedWidget), findsOneWidget);
        expect(find.text('Main St'), findsOneWidget);
        expect(find.text('Show map'), findsOneWidget);
      },
    );

    testWidgets('should show driver card when driver data is available', (
      tester,
    ) async {
      when(mockCubit.state).thenReturn(
        TrackOrderState(
          trackOrderState: BaseState(data: tOrder, isSuccess: true),
          driverState: const BaseState(data: tDriver, isSuccess: true),
        ),
      );

      await pumpScreen(tester);

      expect(find.byType(ContactAddressCard), findsOneWidget);
      expect(find.text('John Doe'), findsOneWidget);
    });

    testWidgets(
      'should show Order Delivered button only when status is delivered',
      (tester) async {
        final deliveredOrder = TrackOrderEntity(
          id: '123',
          orderNumber: 'ORD-1',
          orderStatus: 'delivered',
          // Match delivered
          isActive: true,
          driverId: '',
          totalPrice: 100,
          paymentType: 'cash',
          isPaid: false,
          isDelivered: false,
          state: '',
          createdAt: '',
          updatedAt: DateTime.now().toIso8601String(),
          paidAt: '',
          v: 0,
          user: const TrackOrderUserEntity(
            id: '',
            firstName: '',
            lastName: '',
            email: '',
            phone: '',
            photo: '',
          ),
          store: const TrackOrderStoreEntity(
            name: '',
            image: '',
            phoneNumber: '',
            address: '',
            latLong: '',
          ),
          shippingAddress: const TrackOrderShippingAddressEntity(
            street: 'Main St',
            city: '',
            phone: '',
            lat: '',
            long: '',
          ),
          orderItems: const [],
          currentLocation: const TrackOrderCurrentLocationEntity(
            latitude: 0,
            longitude: 0,
          ),
        );

        when(mockCubit.state).thenReturn(
          TrackOrderState(
            trackOrderState: BaseState(data: deliveredOrder, isSuccess: true),
          ),
        );

        await pumpScreen(tester);

        expect(find.text('Order Delivered'), findsOneWidget);

        await tester.tap(find.text('Order Delivered'));
        verify(
          mockCubit.doEvent(argThat(isA<UpdateOrderToCompletedEvent>())),
        ).called(1);
      },
    );

    testWidgets('should show error snackbar on DisplayErrorEvent', (
      tester,
    ) async {
      await pumpScreen(tester);

      eventController.add(const DisplayErrorEvent(errorMsg: 'Critical Error'));
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Critical Error'), findsOneWidget);
    });

    testWidgets('should show success snackbar on DisplaySuccessEvent', (
      tester,
    ) async {
      await pumpScreen(tester);

      eventController.add(
        const DisplaySuccessEvent(successMsg: 'Operation Successful'),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Operation Successful'), findsOneWidget);
    });
  });
}

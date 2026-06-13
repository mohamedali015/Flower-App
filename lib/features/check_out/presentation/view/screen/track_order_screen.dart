import 'package:flutter/cupertino.dart';
import '../../../../../core/shared_widgets/custom_button.dart';

class TrackOrderStep extends StatelessWidget {
  const TrackOrderStep({
    super.key,
    required this.onBack,
    required this.onPlaceOrder,
  });

  final VoidCallback onBack;
  final VoidCallback onPlaceOrder;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: Center(child: Text('Track Order'))),

        Padding(
          padding: const EdgeInsets.all(16),
          child: CustomButton(
            title: 'Place Order',
            onPressed: () {
              onPlaceOrder();
            },
          ),
        ),
      ],
    );
  }
}

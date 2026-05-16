import 'package:flutter/cupertino.dart';
import '../../helpers/my_responsive.dart';
import '../shimmer_box.dart';
class GridProductShimmer extends StatelessWidget {
  const GridProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.builder(
            itemCount: 6,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: .7,
            ),
            itemBuilder: (_, __) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ShimmerBox(
                      height: MyResponsive.height(
                        context,
                        value: double.infinity,
                      ),
                    ),
                  ),

                  SizedBox(height: MyResponsive.height(context, value: 8)),

                  ShimmerBox(
                    height: MyResponsive.height(context, value: 14),
                    width: MyResponsive.width(context, value: 100),
                  ),

                  SizedBox(height: MyResponsive.height(context, value: 6)),

                  ShimmerBox(
                    height: MyResponsive.height(context, value: 14),
                    width: MyResponsive.width(context, value: 16),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

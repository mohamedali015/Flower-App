import 'package:carousel_slider/carousel_slider.dart';
import 'package:flower_app/config/products/domain/entities/product_entity.dart';
import 'package:flower_app/core/helpers/my_responsive.dart';
import 'package:flower_app/core/shared_widgets/svg_wrapper.dart';
import 'package:flower_app/core/utils/app_assets.dart';
import 'package:flower_app/core/utils/app_colors.dart';
import 'package:flower_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../core/localization/l10n/app_localizations.dart';
import '../widgets/carousel_slider_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.entity});

  final ProductEntity entity;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int imageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MyResponsive.height(context, value: 400),
                child: Stack(
                  children: [
                    CarouselSliderWidget(
                      widget.entity,
                      onPageChanged: _onCarouselSliderPageChanged,
                    ),
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: SvgWrapper(path: AppAssets.backBtn),
                            padding: MyResponsive.paddingSymmetric(
                              context,
                              vertical: 18,
                              horizontal: 22,
                            ),
                          ),
                          Spacer(),
                          Center(
                            child: AnimatedSmoothIndicator(
                              activeIndex: imageIndex,
                              count: widget.entity.images.length,
                              effect: SlideEffect(
                                dotColor: AppColors.grayMedium,
                                activeDotColor: AppColors.primaryColor,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MyResponsive.height(context, value: 8),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: MyResponsive.height(context, value: 16)),
              Padding(
                padding: MyResponsive.paddingSymmetric(context, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${local.egp} ${widget.entity.price}",
                          style: AppTextStyles.bold20(context),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(width: MyResponsive.width(context, value: 106)),
                        Text(
                          "${local.status} : ${widget.entity.quantity > 0 ? local.inStock : local.outOfStock}",
                          style: AppTextStyles.regular20(context),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 4)),
                    Text(
                      local.allPricesIncludeTax,
                      textAlign: TextAlign.start,
                      style: AppTextStyles.regular14(
                        context,
                      ).copyWith(fontSize: 13, color: AppColors.grayDark),
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 8)),
                    Text(
                      "${widget.entity.quantity} ${widget.entity.title}",
                      style: AppTextStyles.medium16(context),
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 24)),
                    Text(
                      local.description,
                      style: AppTextStyles.medium16(context),
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 8)),
                    Text(
                      widget.entity.description,
                      style: AppTextStyles.regular14(context),
                    ),
                    SizedBox(height: MyResponsive.height(context, value: 133)),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(local.addToCart),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCarouselSliderPageChanged(
    int index,
    CarouselPageChangedReason reason,
  ) {
    setState(() {
      imageIndex = index;
    });
  }
}

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import '../../../../config/products/domain/entities/product_entity.dart';
import '../../../../core/helpers/my_responsive.dart';
import '../../../../core/shared_widgets/cached_network_image_wrapper.dart';

class CarouselSliderWidget extends StatelessWidget {
  final ProductEntity product;

  const CarouselSliderWidget(this.product, {required this.onPageChanged});

  final Function(int, CarouselPageChangedReason) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: product.images
          .map(
            (path) => CachedNetworkImageWrapper(
          width: double.infinity,
          imagePath: path,
          fit: BoxFit.cover,
        ),
      )
          .toList(),
      options: CarouselOptions(
        height: MyResponsive.height(context, value: 400),
        aspectRatio: 15 / 16,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        onPageChanged: onPageChanged,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
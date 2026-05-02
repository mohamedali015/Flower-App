import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'custom_loading_indicator.dart';

class CachedNetworkImageWrapper extends StatelessWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const CachedNetworkImageWrapper({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      placeholder: (context, url) => const CustomLoadingIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      width: width,
      height: height,
      fit: fit,
    );
  }
}

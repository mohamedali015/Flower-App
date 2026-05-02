import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgWrapper extends StatelessWidget {
  const SvgWrapper({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit = BoxFit.scaleDown,
    this.color,
  });

  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      fit: fit!,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      width: width,
      height: height,
    );
  }
}

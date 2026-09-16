import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';

/// Image réseau LUXORA — fade-in doré, placeholder charcoal.
class LuxoraImage extends StatelessWidget {
  const LuxoraImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.borderRadius = LuxoraRadii.brLg,
    this.fit = BoxFit.cover,
  });

  final String url;
  final double? width;
  final double? height;
  final BorderRadius borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: CachedNetworkImage(
        imageUrl: url,
        width: width,
        height: height,
        fit: fit,
        fadeInDuration: const Duration(milliseconds: 320),
        placeholder: (_, __) => Container(
          width: width,
          height: height,
          color: LuxoraColors.charcoal,
        ),
        errorWidget: (_, __, ___) => Container(
          width: width,
          height: height,
          color: LuxoraColors.charcoal,
          child: const Icon(
            Icons.image_not_supported_outlined,
            color: LuxoraColors.textTertiary,
          ),
        ),
      ),
    );
  }
}

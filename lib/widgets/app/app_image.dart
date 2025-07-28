import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:lottie/lottie.dart';
import 'package:portfolio_3/utils/constants.dart';
import 'package:portfolio_3/utils/extensions/context_extensions.dart';

class AppImage extends StatelessWidget {
  final String imageUrl;
  final String? imageHash;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final double? borderRadius;

  const AppImage({
    super.key,
    required this.imageUrl,

    this.width,
    this.height,
    this.fit,
    this.borderRadius,
  }) : imageHash = null;

  const AppImage.hash({
    super.key,
    required this.imageUrl,
    required this.imageHash,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder:
            (context, url) => Center(
              child:
                  imageHash == null
                      ? ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          context.theme.splashColor,
                          BlendMode.srcATop,
                        ),
                        child: Lottie.asset(kAssetWave, width: 60, height: 60),
                      )
                      : Center(child: BlurHash(hash: imageHash!)),
            ),
        errorWidget:
            (context, url, error) => const Center(child: Icon(Icons.error)),
        width: width,
        height: height,
        fit: fit,
      ),
    );
  }
}

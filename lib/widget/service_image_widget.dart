import 'package:flutter/material.dart';

class ServiceImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ServiceImageWidget({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Check if it's a local asset
    final isAsset = imageUrl.startsWith('assets/');

    if (isAsset) {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback(isDark);
        },
      );
    } else {
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback(isDark);
        },
      );
    }
  }

  Widget _buildFallback(bool isDark) {
    return Image.asset(
      'assets/images/default.png',
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isDark
                  ? [Colors.grey.shade800, Colors.grey.shade700]
                  : [Colors.grey.shade200, Colors.grey.shade300],
            ),
          ),
          child: Icon(
            Icons.image,
            size: 60,
            color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
          ),
        );
      },
    );
  }
}

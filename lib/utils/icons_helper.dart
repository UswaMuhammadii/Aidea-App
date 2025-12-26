import 'package:flutter/material.dart';
import 'app_colors.dart';

class IconHelper {
  // Main method to get icon - checks in priority order
  // Main method to get icon - checks in priority order
  // Main method to get icon - checks in priority order
  static Widget getServiceIcon({
    String? category,
    String? subcategory,
    String? subSubcategory,
    String? serviceName,
    Color? color,
    double size = 28,
  }) {
    // Return consistent "House + Wrench" icon with Dashboard Header Gradient
    return Stack(
      alignment: Alignment.center,
      children: [
        Icon(Icons.home_outlined, color: color ?? Colors.white, size: size),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(2),
            child: Icon(
              Icons.build_rounded,
              color: AppColors.electricBlue,
              size: size * 0.45,
            ),
          ),
        ),
      ],
    );
  }

  // Helper retained but unused for now, to avoid breaking other calls if any
  static Icon? _getIconByName(String name, Color color, double size,
      {bool returnNullIfNotFound = false}) {
    return Icon(Icons.build, color: color, size: size);
  }

  // Get color for category
  static Color getCategoryColor(String categoryName) {
    final nameLower = categoryName.toLowerCase();

    // AC Services
    if (nameLower == 'ac services' ||
        nameLower == 'ac repair' ||
        nameLower == 'ac service' ||
        nameLower == 'خدمات مكيفات الهواء' ||
        nameLower == 'تصليح مكيفات' ||
        nameLower.contains('ac')) {
      return Colors.lightBlue;
    }
    // Home Appliances
    if (nameLower == 'home appliances' || nameLower == 'أجهزة منزلية') {
      return Colors.teal;
    }
    // Plumbing
    if (nameLower == 'plumbing' || nameLower == 'سباكة') {
      return Colors.blue;
    }
    // Electric
    if (nameLower == 'electric' ||
        nameLower == 'electrical' ||
        nameLower == 'الكهرباء') {
      return Colors.amber;
    }

    return Colors.blueAccent; // Default color
  }

  // Category-specific icon (for dashboard)
  static Icon getCategoryIcon(String categoryName, {double size = 28}) {
    final color = getCategoryColor(categoryName);
    final icon =
        _getIconByName(categoryName, color, size, returnNullIfNotFound: true);
    return icon ?? Icon(Icons.build, color: Colors.grey, size: size);
  }
}

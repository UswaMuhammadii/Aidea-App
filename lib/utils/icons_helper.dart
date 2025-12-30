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

  static String getCategoryImagePath(String categoryName) {
    // Normalize category name for comparison (remove special chars, lowercase)
    final normalized = categoryName.toLowerCase().trim();

    // Category ID mapping (language-independent)
    final categoryIdMap = {
      // AC Services
      'AC Services': 'ac_services',
      'ac services': 'ac_services',
      'AC Repair': 'ac_services',
      'ac repair': 'ac_services',
      'AC Service': 'ac_services',
      'ac service': 'ac_services',
      'خدمات مكيفات الهواء': 'ac_services',
      'خدمات التكييف': 'ac_services',
      'تصليح مكيفات': 'ac_services',

      // Home Appliances
      'Home Appliances': 'home_appliances',
      'home appliances': 'home_appliances',
      'أجهزة منزلية': 'home_appliances',
      'الأجهزة المنزلية': 'home_appliances',

      // Plumbing
      'Plumbing': 'plumbing',
      'plumbing': 'plumbing',
      'سباكة': 'plumbing',
      'السباكة': 'plumbing',

      // Electric
      'Electric': 'electric',
      'electric': 'electric',
      'Electrical': 'electric',
      'electrical': 'electric',
      'الكهرباء': 'electric',
    };

    // Image paths mapped by category ID
    final imagePathMap = {
      'ac_services': 'assets/images/ac_service.png',
      'home_appliances': 'assets/images/home_appliances.png',
      'plumbing': 'assets/images/plumbing.png',
      'electric': 'assets/images/electric.png',
    };

    // Try exact match first
    String? categoryId = categoryIdMap[categoryName];

    // If no exact match, try normalized match
    if (categoryId == null) {
      categoryId = categoryIdMap[normalized];
    }

    // Return image path or default
    return imagePathMap[categoryId] ?? 'assets/images/default.png';
  }
}

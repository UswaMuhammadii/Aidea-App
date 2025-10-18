import 'package:flutter/material.dart';

class IconHelper {
  // Main method to get icon - checks in priority order
  static Icon getServiceIcon({
    String? category,
    String? subcategory,
    String? subSubcategory,
    String? serviceName,
    Color? color,
    double size = 28,
  }) {
    // Priority: subSubcategory > subcategory > serviceName > category
    String searchTerm = '';

    if (subSubcategory != null && subSubcategory.isNotEmpty) {
      searchTerm = subSubcategory;
    } else if (subcategory != null && subcategory.isNotEmpty) {
      searchTerm = subcategory;
    } else if (serviceName != null && serviceName.isNotEmpty) {
      searchTerm = serviceName;
    } else if (category != null && category.isNotEmpty) {
      searchTerm = category;
    }

    return _getIconByName(searchTerm, color ?? Colors.white, size);
  }

  static Icon _getIconByName(String name, Color color, double size) {
    final nameLower = name.toLowerCase().trim();

    // ✅ CRITICAL: Check Washing Machine FIRST before AC checks
    // (because "washing machine" contains "ac" which was matching AC icon)
    if (nameLower == 'washing machine' || nameLower.contains('washing machine')) {
      return Icon(Icons.local_laundry_service, color: color, size: size);
    }
    if (nameLower == 'automatic' && !nameLower.contains('ac')) {
      return Icon(Icons.local_laundry_service, color: color, size: size);
    }
    if (nameLower == 'regular' && !nameLower.contains('ac')) {
      return Icon(Icons.local_laundry_service_outlined, color: color, size: size);
    }

    // AC Services - Check specific types
    if (nameLower == 'split ac' || nameLower.contains('split')) {
      return Icon(Icons.ac_unit, color: color, size: size);
    }
    if (nameLower == 'window ac' || (nameLower.contains('window') && nameLower.contains('ac'))) {
      return Icon(Icons.window, color: color, size: size);
    }
    if (nameLower == 'central ac' || nameLower.contains('central')) {
      return Icon(Icons.air, color: color, size: size);
    }
    // ✅ FIXED: Only match if it's specifically AC-related, not just contains "ac"
    if (nameLower == 'ac services' || nameLower == 'ac' || (nameLower.contains(' ac') && !nameLower.contains('machine'))) {
      return Icon(Icons.ac_unit, color: color, size: size);
    }

    // Other washing/laundry keywords
    if (nameLower.contains('washing') || nameLower.contains('washer') || nameLower.contains('laundry')) {
      return Icon(Icons.local_laundry_service, color: color, size: size);
    }

    // Other Appliances
    if (nameLower == 'refrigerator' || nameLower.contains('refrigerator') || nameLower.contains('fridge')) {
      return Icon(Icons.kitchen, color: color, size: size);
    }
    if (nameLower == 'oven' || nameLower.contains('oven')) {
      return Icon(Icons.microwave, color: color, size: size);
    }
    if (nameLower == 'stove' || nameLower.contains('stove')) {
      return Icon(Icons.gas_meter, color: color, size: size);
    }
    if (nameLower == 'dishwasher' || nameLower.contains('dishwasher')) {
      return Icon(Icons.countertops, color: color, size: size);
    }
    if (nameLower == 'home appliances') {
      return Icon(Icons.home_repair_service, color: color, size: size);
    }

    // Plumbing
    if (nameLower.contains('pipe')) {
      return Icon(Icons.plumbing, color: color, size: size);
    }
    if (nameLower.contains('drain')) {
      return Icon(Icons.cleaning_services, color: color, size: size);
    }
    if (nameLower.contains('water heater') || nameLower.contains('heater')) {
      return Icon(Icons.water_drop, color: color, size: size);
    }
    if (nameLower.contains('faucet') || nameLower.contains('tap')) {
      return Icon(Icons.shower, color: color, size: size);
    }
    if (nameLower == 'plumbing' || nameLower.contains('plumb')) {
      return Icon(Icons.plumbing, color: color, size: size);
    }

    // Electrical
    if (nameLower.contains('wiring') || nameLower.contains('wire')) {
      return Icon(Icons.cable, color: color, size: size);
    }
    if (nameLower.contains('switch') || nameLower.contains('socket')) {
      return Icon(Icons.electrical_services, color: color, size: size);
    }
    if (nameLower.contains('circuit') || nameLower.contains('breaker')) {
      return Icon(Icons.power, color: color, size: size);
    }
    if (nameLower.contains('lighting') || nameLower.contains('light')) {
      return Icon(Icons.lightbulb, color: color, size: size);
    }
    if (nameLower == 'electric' || nameLower.contains('electrical')) {
      return Icon(Icons.electrical_services, color: color, size: size);
    }

    // Default fallback
    return Icon(Icons.build, color: Colors.grey, size: size);
  }

  // Category-specific icon (for dashboard)
  static Icon getCategoryIcon(String categoryName, {double size = 28}) {
    switch (categoryName.toLowerCase()) {
      case 'ac services':
        return Icon(Icons.ac_unit, color: Colors.lightBlue, size: size);
      case 'home appliances':
        return Icon(Icons.home_repair_service, color: Colors.teal, size: size);
      case 'plumbing':
        return Icon(Icons.plumbing, color: Colors.blue, size: size);
      case 'electric':
        return Icon(Icons.electrical_services, color: Colors.amber, size: size);
      default:
        return Icon(Icons.build, color: Colors.grey, size: size);
    }
  }
}
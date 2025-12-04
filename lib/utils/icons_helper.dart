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
    // Using EXACT translations from app_ar.arb
    if (nameLower == 'washing machine' || nameLower.contains('washing machine') ||
        nameLower == 'غسالة' || nameLower.contains('غسالة')) {  // ✅ EXACT from ARB
      return Icon(Icons.local_laundry_service, color: color, size: size);
    }
    if (nameLower == 'automatic' || nameLower == 'أوتوماتيك') {
      return Icon(Icons.local_laundry_service, color: color, size: size);
    }
    if (nameLower == 'regular' || nameLower == 'عادي') {
      return Icon(Icons.local_laundry_service_outlined, color: color, size: size);
    }
    if (nameLower == 'semi-automatic' || nameLower == 'نصف أوتوماتيك') {
      return Icon(Icons.local_laundry_service, color: color, size: size);
    }
    if (nameLower == 'top load' || nameLower == 'تحميل علوي') {
      return Icon(Icons.vertical_align_top, color: color, size: size);
    }
    if (nameLower == 'front load' || nameLower == 'تحميل أمامي') {
      return Icon(Icons.vertical_align_center, color: color, size: size);
    }

    // AC Services - Using EXACT ARB translations
    if (nameLower == 'split ac' || nameLower.contains('split') ||
        nameLower == 'مكيف سبليت' || nameLower.contains('سبليت')) {  // ✅ EXACT from ARB
      return Icon(Icons.ac_unit, color: color, size: size);
    }
    if (nameLower == 'window ac' || (nameLower.contains('window') && nameLower.contains('ac')) ||
        nameLower == 'مكيف نافذة' || nameLower.contains('نافذة')) {  // ✅ EXACT from ARB (نافذة not شباك)
      return Icon(Icons.window, color: color, size: size);
    }
    if (nameLower == 'central ac' || nameLower.contains('central') ||
        nameLower == 'مكيف مركزي' || nameLower.contains('مركزي')) {  // ✅ EXACT from ARB
      return Icon(Icons.air, color: color, size: size);
    }
    // AC Services general
    if (nameLower == 'ac services' || nameLower == 'ac' ||
        nameLower == 'خدمات مكيفات الهواء' || nameLower.contains('مكيف') ||
        (nameLower.contains(' ac') && !nameLower.contains('machine'))) {
      return Icon(Icons.ac_unit, color: color, size: size);
    }

    // Other washing/laundry keywords
    if (nameLower.contains('washing') || nameLower.contains('washer') || nameLower.contains('laundry')) {
      return Icon(Icons.local_laundry_service, color: color, size: size);
    }

    // Other Appliances - Using EXACT ARB translations
    if (nameLower == 'refrigerator' || nameLower.contains('refrigerator') || nameLower.contains('fridge') ||
        nameLower == 'ثلاجة' || nameLower.contains('ثلاجة')) {  // ✅ EXACT from ARB
      return Icon(Icons.kitchen, color: color, size: size);
    }
    if (nameLower == 'oven' || nameLower.contains('oven') ||
        nameLower == 'فرن' || nameLower.contains('فرن')) {  // ✅ EXACT from ARB
      return Icon(Icons.microwave, color: color, size: size);
    }
    if (nameLower == 'stove' || nameLower.contains('stove') ||
        nameLower == 'موقد' || nameLower.contains('موقد')) {  // ✅ EXACT from ARB
      return Icon(Icons.gas_meter, color: color, size: size);
    }
    if (nameLower == 'dishwasher' || nameLower.contains('dishwasher') ||
        nameLower == 'غسالة صحون' || nameLower.contains('صحون')) {  // ✅ EXACT from ARB
      return Icon(Icons.countertops, color: color, size: size);
    }
    if (nameLower == 'home appliances' || nameLower == 'أجهزة منزلية') {
      return Icon(Icons.home_repair_service, color: color, size: size);
    }

    // Plumbing - Using EXACT ARB translations
    if (nameLower.contains('pipe') ||
        nameLower.contains('أنابيب') || nameLower == 'إصلاح الأنابيب') {  // ✅ EXACT from ARB
      return Icon(Icons.plumbing, color: color, size: size);
    }
    if (nameLower.contains('drain') ||
        nameLower.contains('مصارف') || nameLower == 'تنظيف المصارف') {  // ✅ EXACT from ARB
      return Icon(Icons.cleaning_services, color: color, size: size);
    }
    if (nameLower.contains('water heater') || nameLower.contains('heater') ||
        nameLower == 'سخان المياه' || nameLower.contains('سخان')) {  // ✅ EXACT from ARB
      return Icon(Icons.water_drop, color: color, size: size);
    }
    if (nameLower.contains('faucet') || nameLower.contains('tap') ||
        nameLower == 'تركيب الحنفيات' || nameLower.contains('حنفي')) {  // ✅ EXACT from ARB
      return Icon(Icons.shower, color: color, size: size);
    }
    if (nameLower == 'plumbing' || nameLower.contains('plumb') ||
        nameLower == 'سباكة' || nameLower.contains('سباك')) {
      return Icon(Icons.plumbing, color: color, size: size);
    }

    // Electrical - Using EXACT ARB translations
    if (nameLower.contains('wiring') || nameLower.contains('wire') ||
        nameLower == 'الأسلاك' || nameLower.contains('أسلاك')) {  // ✅ EXACT from ARB
      return Icon(Icons.cable, color: color, size: size);
    }
    if (nameLower.contains('switch') || nameLower.contains('socket') ||
        nameLower == 'المفاتيح والمقابس' || nameLower.contains('مفاتيح') || nameLower.contains('مقابس')) {  // ✅ EXACT from ARB
      return Icon(Icons.electrical_services, color: color, size: size);
    }
    if (nameLower.contains('circuit') || nameLower.contains('breaker') ||
        nameLower == 'قاطع الدائرة' || nameLower.contains('قاطع')) {  // ✅ EXACT from ARB
      return Icon(Icons.power, color: color, size: size);
    }
    if (nameLower.contains('lighting') || nameLower.contains('light') ||
        nameLower == 'تركيب الإضاءة' || nameLower.contains('إضاءة')) {  // ✅ EXACT from ARB
      return Icon(Icons.lightbulb, color: color, size: size);
    }
    if (nameLower == 'electric' || nameLower.contains('electrical') ||
        nameLower == 'الكهرباء' || nameLower.contains('كهرب')) {
      return Icon(Icons.electrical_services, color: color, size: size);
    }

    // Default fallback
    return Icon(Icons.build, color: Colors.grey, size: size);
  }

  // Category-specific icon (for dashboard)
  static Icon getCategoryIcon(String categoryName, {double size = 28}) {
    final nameLower = categoryName.toLowerCase();

    // AC Services (English and Arabic)
    if (nameLower == 'ac services' || nameLower == 'خدمات مكيفات الهواء') {
      return Icon(Icons.ac_unit, color: Colors.lightBlue, size: size);
    }
    // Home Appliances (English and Arabic)
    if (nameLower == 'home appliances' || nameLower == 'أجهزة منزلية') {
      return Icon(Icons.home_repair_service, color: Colors.teal, size: size);
    }
    // Plumbing (English and Arabic)
    if (nameLower == 'plumbing' || nameLower == 'سباكة') {
      return Icon(Icons.plumbing, color: Colors.blue, size: size);
    }
    // Electric (English and Arabic)
    if (nameLower == 'electric' || nameLower == 'الكهرباء') {
      return Icon(Icons.electrical_services, color: Colors.amber, size: size);
    }

    // Default fallback
    return Icon(Icons.build, color: Colors.grey, size: size);
  }
}
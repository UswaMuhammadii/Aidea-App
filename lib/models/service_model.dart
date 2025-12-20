class Service {
  final String id;
  final String name;
  final String nameArabic; // Added
  final String description;
  final double
      price; // Mapped to basePrice + vat + commission (finalPrice) or just basePrice?
  final double basePrice; // Added
  final double commission; // Added
  final double vat; // Added
  final String categoryId; // Added
  final String category;
  final String categoryArabic; // Added
  final String? subcategoryId; // Added
  final String? subcategory;
  final String? subcategoryArabic; // Added
  final String? subSubcategory;
  final List<String> features;
  final bool isActive;
  final String? imageUrl; // Added
  final String? icon; // Added

  Service({
    required this.id,
    required this.name,
    this.nameArabic = '',
    required this.description,
    required this.price,
    this.basePrice = 0.0,
    this.commission = 0.0,
    this.vat = 0.0,
    this.categoryId = '',
    required this.category,
    this.categoryArabic = '',
    this.subcategoryId,
    this.subcategory,
    this.subcategoryArabic,
    this.subSubcategory,
    required this.features,
    this.isActive = true,
    this.imageUrl,
    this.icon,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameArabic': nameArabic,
      'description': description,
      'price': price,
      'basePrice': basePrice,
      'commission': commission,
      'vat': vat,
      'categoryId': categoryId,
      'category': category,
      'categoryArabic': categoryArabic,
      'subcategoryId': subcategoryId,
      'subcategory': subcategory,
      'subcategoryArabic': subcategoryArabic,
      'subSubcategory': subSubcategory,
      'features': features,
      'isActive': isActive,
      'imageUrl': imageUrl,
      'icon': icon,
    };
  }

  factory Service.fromJson(Map<String, dynamic> json) {
    double base = (json['basePrice'] as num?)?.toDouble() ??
        (json['price'] as num?)?.toDouble() ??
        0.0;
    double comm = (json['commission'] as num?)?.toDouble() ?? 0.0;
    double vt = (json['vat'] as num?)?.toDouble() ?? 0.0;
    // Calculate display price if not provided explicitly as 'price'
    // Admin Side logic: total = base + (base*vat/100) + (base*commission/100)
    // Actually Admin Model says:
    // commissionAmount => basePrice * (commission / 100);
    // vatAmount => basePrice * (vat / 100);
    // totalPrice => basePrice + vatAmount;
    // finalPrice => totalPrice + commissionAmount;

    // We'll use finalPrice as the 'price' for the customer
    // MODIFIED: Use base price directly as the display price, ignoring VAT/Commission additions for display
    double finalPrice = base;

    return Service(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      nameArabic: json['nameArabic'] as String? ?? '',
      description: json['description'] as String? ??
          '', // Fallback to empty if Admin doesn't provide
      price: finalPrice > 0
          ? finalPrice
          : (json['price'] as num?)?.toDouble() ?? 0.0,
      basePrice: base,
      commission: comm,
      vat: vt,
      categoryId: json['categoryId'] as String? ?? '',
      category: json['category'] as String? ?? '',
      categoryArabic: json['categoryArabic'] as String? ?? '',
      subcategoryId: json['subcategoryId'] as String?,
      subcategory: json['subcategory'] as String?,
      subcategoryArabic: json['subcategoryArabic'] as String?,
      subSubcategory: json['subSubcategory'] as String?,
      features: (json['features'] as List<dynamic>?)?.cast<String>() ?? [],
      isActive: json['isActive'] as bool? ?? true,
      imageUrl: json['imageUrl'] as String?,
      icon: json['icon'] as String?,
    );
  }
}

class ServiceCategory {
  final String id;
  final String name;
  final String nameArabic; // Added
  final String description;
  final String descriptionArabic; // Added
  final String icon;
  final List<Service> services;
  final List<String>? subcategories;
  final List<String> subcategoriesArabic; // Added
  final String? imageUrl; // Added

  ServiceCategory({
    required this.id,
    required this.name,
    this.nameArabic = '',
    required this.description,
    this.descriptionArabic = '',
    required this.icon,
    required this.services,
    this.subcategories,
    this.subcategoriesArabic = const [],
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nameArabic': nameArabic,
      'description': description,
      'descriptionArabic': descriptionArabic,
      'icon': icon,
      'subcategories': subcategories,
      'subcategoriesArabic': subcategoriesArabic,
      'imageUrl': imageUrl,
      'services': services.map((s) => s.toJson()).toList(),
    };
  }

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ??
          json['nameEnglish'] as String? ??
          json['nameEngLish'] as String? ??
          '',
      nameArabic: json['nameArabic'] as String? ?? '',
      description: json['description'] as String? ??
          json['descriptionEnglish'] as String? ??
          json['descriptionEngLish'] as String? ??
          '',
      descriptionArabic: json['descriptionArabic'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      subcategories: json['subcategories'] != null
          ? (json['subcategories'] as List<dynamic>).cast<String>()
          : null,
      subcategoriesArabic:
          (json['subcategoriesArabic'] as List<dynamic>?)?.cast<String>() ?? [],
      imageUrl: json['imageUrl'] as String?,
      services: (json['services'] as List<dynamic>?)
              ?.map((s) => Service.fromJson(s as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}

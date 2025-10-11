class Service {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String? subcategory; // Added subcategory field
  final List<String> features;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.subcategory, // Optional subcategory
    required this.features,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'subcategory': subcategory,
      'features': features,
    };
  }

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      category: json['category'] as String,
      subcategory: json['subcategory'] as String?,
      features: (json['features'] as List<dynamic>).cast<String>(),
    );
  }
}

class ServiceCategory {
  final String id;
  final String name;
  final String description;
  final String icon;
  final List<Service> services;
  final List<String>? subcategories; // Added subcategories list

  ServiceCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.services,
    this.subcategories, // Optional subcategories
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'icon': icon,
      'subcategories': subcategories,
      'services': services.map((s) => s.toJson()).toList(),
    };
  }

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      subcategories: json['subcategories'] != null
          ? (json['subcategories'] as List<dynamic>).cast<String>()
          : null,
      services: (json['services'] as List<dynamic>)
          .map((s) => Service.fromJson(s as Map<String, dynamic>))
          .toList(),
    );
  }
}
class Service {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String? subcategory; // Added subcategory field
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final Duration duration;
  final List<String> features;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.subcategory, // Optional subcategory
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.duration,
    required this.features,
  });

  String get formattedDuration {
    if (duration.inDays > 0) {
      return '${duration.inDays} ${duration.inDays == 1 ? 'day' : 'days'}';
    } else if (duration.inHours > 0) {
      final minutes = duration.inMinutes % 60;
      if (minutes > 0) {
        return '${duration.inHours}h ${minutes}m';
      }
      return '${duration.inHours} ${duration.inHours == 1 ? 'hour' : 'hours'}';
    } else {
      return '${duration.inMinutes} minutes';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'subcategory': subcategory,
      'imageUrl': imageUrl,
      'rating': rating,
      'reviewCount': reviewCount,
      'duration': duration.inMinutes,
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
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      duration: Duration(minutes: json['duration'] as int),
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
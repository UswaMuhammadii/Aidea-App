// models/user_model.dart
class User {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String address;
  final DateTime createdAt;
  final List<SavedAddress> savedAddresses;
  final String languagePreference;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    this.address = 'Building Sultan Town Lahore Punjab',
    required this.createdAt,
    this.savedAddresses = const [],
    this.languagePreference = 'english',
  });

  // Admin Panel Compatibility
  bool get prefersArabic => languagePreference == 'arabic';
  DateTime get registeredAt => createdAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      // Admin Panel Compatibility Aliases
      'fullName': name,
      'userName': name,
      'displayName': name,
      'phone': phone,
      'email': email,
      'registeredAt':
          createdAt.toIso8601String(), // Map to Admin's registeredAt
      'languagePreference': languagePreference,
      'address': address, // Added as per request
      // Local only or extra fields
      'savedAddresses':
          savedAddresses.map((address) => address.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? 'Building Sultan Town Lahore Punjab',
      createdAt: json['registeredAt'] != null
          ? DateTime.parse(json['registeredAt'])
          : (json['createdAt'] != null
              ? DateTime.parse(json['createdAt'])
              : DateTime.now()),
      savedAddresses: (json['savedAddresses'] as List<dynamic>?)
              ?.map((addressJson) => SavedAddress.fromJson(addressJson))
              .toList() ??
          [],
      languagePreference: json['languagePreference'] ?? 'english',
    );
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? address,
    DateTime? createdAt,
    List<SavedAddress>? savedAddresses,
    String? languagePreference,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      savedAddresses: savedAddresses ?? this.savedAddresses,
      languagePreference: languagePreference ?? this.languagePreference,
    );
  }
}

class SavedAddress {
  final String id;
  final String title;
  final String fullAddress;
  final double? latitude;
  final double? longitude;
  final String type;
  final bool isPrimary;
  final DateTime createdAt;

  SavedAddress({
    required this.id,
    required this.title,
    required this.fullAddress,
    this.latitude,
    this.longitude,
    required this.type,
    this.isPrimary = false,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'fullAddress': fullAddress,
      'latitude': latitude,
      'longitude': longitude,
      'type': type,
      'isPrimary': isPrimary,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory SavedAddress.fromJson(Map<String, dynamic> json) {
    return SavedAddress(
      id: json['id'],
      title: json['title'],
      fullAddress: json['fullAddress'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      type: json['type'],
      isPrimary: json['isPrimary'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  SavedAddress copyWith({
    String? id,
    String? title,
    String? fullAddress,
    double? latitude,
    double? longitude,
    String? type,
    bool? isPrimary,
    DateTime? createdAt,
  }) {
    return SavedAddress(
      id: id ?? this.id,
      title: title ?? this.title,
      fullAddress: fullAddress ?? this.fullAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      type: type ?? this.type,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

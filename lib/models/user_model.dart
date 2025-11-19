// models/user_model.dart
class User {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String address;
  final DateTime createdAt;
  final List<SavedAddress> savedAddresses;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    this.address = 'Building Sultan Town Lahore Punjab',
    required this.createdAt,
    this.savedAddresses = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
      'createdAt': createdAt.toIso8601String(),
      'savedAddresses': savedAddresses.map((address) => address.toJson()).toList(),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'] ?? 'Building Sultan Town Lahore Punjab',
      createdAt: DateTime.parse(json['createdAt']),
      savedAddresses: (json['savedAddresses'] as List<dynamic>?)
          ?.map((addressJson) => SavedAddress.fromJson(addressJson))
          .toList() ?? [],
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
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      savedAddresses: savedAddresses ?? this.savedAddresses,
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
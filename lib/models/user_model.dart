class User {
  final String id;
  final String email;
  final String name;
  final String phone;
  final String address;
  final DateTime createdAt;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    this.address = 'Building Sultan Town Lahore Punjab',
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
      'createdAt': createdAt.toIso8601String(),
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
    );
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? phone,
    String? address,
    DateTime? createdAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
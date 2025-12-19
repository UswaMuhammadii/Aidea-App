import 'package:flutter/material.dart';

// Match Admin Panel ServiceRequestStatus
enum BookingStatus {
  pending,
  assigned,
  accepted, // Was confirmed
  inProgress,
  completed,
  postponed,
  cancelled;

  // Helper for old status compatibility if needed
  static BookingStatus fromString(String status) {
    return BookingStatus.values.firstWhere(
      (e) => e.name == status || e.toString() == 'BookingStatus.$status',
      orElse: () => BookingStatus.pending,
    );
  }
}

enum PaymentMethod { cash, online }

class Booking {
  final String id;
  final String userId; // Maps to customerId
  final String customerName; // Added
  final String serviceId;
  final String serviceName; // Added
  final String? serviceNameArabic; // Added
  final String? workerId; // Added
  final String? workerName; // Added
  final String? workerNameArabic; // Added
  final DateTime bookingDate; // Maps to requestedDate
  final String bookingTime; // Maps to requestedTime
  final String address; // Added
  final String? notes; // Maps to customerNotes
  final BookingStatus status;
  final double basePrice; // Added
  final double commission; // Added
  final double vat; // Added
  final List<ExtraItem> extraItems; // Added
  final String? postponeReason; // Added
  final String? cancellationReason; // Added
  final DateTime? completedDate; // Added
  final PaymentMethod? paymentMethod;
  final bool invoiceGenerated; // Added
  final String customerLanguage; // Added
  final DateTime createdAt;
  final DateTime updatedAt; // Added

  // Legacy UI field fields (mapped or calculated)
  double get totalPrice =>
      totalServicePrice; // For UI compatibility, user pays totalServicePrice
  int get quantity => 1; // Default

  Booking({
    required this.id,
    required this.userId,
    required this.customerName,
    required this.serviceId,
    required this.serviceName,
    this.serviceNameArabic,
    this.workerId,
    this.workerName,
    this.workerNameArabic,
    required this.bookingDate,
    required this.bookingTime,
    required this.address,
    this.notes,
    required this.status,
    required this.basePrice,
    required this.commission,
    required this.vat,
    this.extraItems = const [],
    this.postponeReason,
    this.cancellationReason,
    this.completedDate,
    this.paymentMethod,
    this.invoiceGenerated = false,
    required this.customerLanguage,
    required this.createdAt,
    required this.updatedAt,
  });

  // Check if customer prefers Arabic
  bool get customerPrefersArabic => customerLanguage == 'arabic';

  // Total extra items price
  double get totalExtraPrice =>
      extraItems.fold(0.0, (sum, item) => sum + item.price);

  // Total service price (what customer pays)
  double get totalServicePrice => basePrice + totalExtraPrice;

  Color get statusColor {
    switch (status) {
      case BookingStatus.pending:
        return const Color(0xFFF59E0B);
      case BookingStatus.assigned:
        return const Color(0xFF60A5FA); // Light Blue
      case BookingStatus.accepted:
        return const Color(0xFF3B82F6); // Blue
      case BookingStatus.inProgress:
        return const Color(0xFF8B5CF6); // Purple
      case BookingStatus.completed:
        return const Color(0xFF10B981); // Green
      case BookingStatus.postponed:
        return const Color(0xFFF97316); // Orange
      case BookingStatus.cancelled:
        return const Color(0xFFEF4444); // Red
    }
  }

  String get statusText {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.assigned:
        return 'Assigned';
      case BookingStatus.accepted:
        return 'Accepted';
      case BookingStatus.inProgress:
        return 'In Progress';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.postponed:
        return 'Postponed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerId': userId,
      'customerName': customerName,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'serviceNameArabic': serviceNameArabic,
      'workerId': workerId,
      'workerName': workerName,
      'workerNameArabic': workerNameArabic,
      'requestedDate': bookingDate.toIso8601String(),
      'requestedTime': bookingTime,
      'address': address,
      'customerNotes': notes,
      'status': status.name,
      'basePrice': basePrice,
      'commission': commission,
      'vat': vat,
      'extraItems': extraItems.map((e) => e.toJson()).toList(),
      'postponeReason': postponeReason,
      'cancellationReason': cancellationReason,
      'completedDate': completedDate?.toIso8601String(),
      'paymentMethod': paymentMethod?.name,
      'invoiceGenerated': invoiceGenerated,
      'customerLanguage': customerLanguage,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] ?? '',
      userId: json['customerId'] ?? '',
      customerName: json['customerName'] ?? '',
      serviceId: json['serviceId'] ?? '',
      serviceName: json['serviceName'] ?? '',
      serviceNameArabic: json['serviceNameArabic'],
      workerId: json['workerId'],
      workerName: json['workerName'],
      workerNameArabic: json['workerNameArabic'],
      bookingDate:
          DateTime.tryParse(json['requestedDate'] ?? '') ?? DateTime.now(),
      bookingTime: json['requestedTime'] ?? '',
      address: json['address'] ?? '',
      notes: json['customerNotes'],
      status: BookingStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => BookingStatus.pending,
      ),
      basePrice: (json['basePrice'] ?? 0).toDouble(),
      commission: (json['commission'] ?? 0).toDouble(),
      vat: (json['vat'] ?? 0).toDouble(),
      extraItems: (json['extraItems'] as List?)
              ?.map((e) => ExtraItem.fromJson(e))
              .toList() ??
          [],
      postponeReason: json['postponeReason'],
      cancellationReason: json['cancellationReason'],
      completedDate: json['completedDate'] != null
          ? DateTime.tryParse(json['completedDate'])
          : null,
      paymentMethod: json['paymentMethod'] != null
          ? PaymentMethod.values.firstWhere(
              (e) => e.name == json['paymentMethod'],
              orElse: () => PaymentMethod.cash,
            )
          : null,
      invoiceGenerated: json['invoiceGenerated'] == true ||
          json['invoiceGenerated'].toString().toLowerCase() == 'true',
      customerLanguage: json['customerLanguage'] ?? 'english',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }
}

class ExtraItem {
  final String id;
  final String name; // BILINGUAL
  final String type; // 'service' or 'part'
  final double price;
  final String? description;

  ExtraItem({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    this.description,
  });

  // Get English name only
  String get nameEnglish =>
      name.contains('•') ? name.split('•').first.trim() : name;

  // Get Arabic name only
  String get nameArabic =>
      name.contains('•') ? name.split('•').last.trim() : name;

  factory ExtraItem.fromJson(Map<String, dynamic> json) {
    return ExtraItem(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? 'service',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'price': price,
      'description': description,
    };
  }
}

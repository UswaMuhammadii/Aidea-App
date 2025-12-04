import 'package:flutter/material.dart';
import '../../gen_l10n/app_localizations.dart';
enum BookingStatus {
  pending,
  confirmed,
  inProgress,
  completed,
  cancelled,
}

class Booking {
  final String id;
  final String userId;
  final String serviceId;
  final DateTime bookingDate;
  final DateTime bookingTime;
  final double totalPrice;
  final BookingStatus status;
  final DateTime createdAt;
  final String? notes;
  final dynamic service;
  final int quantity;
  final String paymentMethod;

  Booking({
    required this.id,
    required this.userId,
    required this.serviceId,
    required this.bookingDate,
    required this.bookingTime,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    this.notes,
    this.service,
    required this.quantity,
    required this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'serviceId': serviceId,
      'bookingDate': bookingDate.toIso8601String(),
      'bookingTime': bookingTime.toIso8601String(),
      'totalPrice': totalPrice,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'notes': notes,
      'quantity': quantity,
      'paymentMethod': paymentMethod,
    };
  }

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id'] as String,
      userId: json['userId'] as String,
      serviceId: json['serviceId'] as String,
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      bookingTime: DateTime.parse(json['bookingTime'] as String),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      status: BookingStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => BookingStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt'] as String),
      notes: json['notes'] as String?,
      quantity: json['quantity'] as int? ?? 1,
      paymentMethod: json['paymentMethod'] as String? ?? 'cash',
    );
  }

  String get statusText {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.inProgress:
        return 'In Progress';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
    }
  }

  Color get statusColor {
    switch (status) {
      case BookingStatus.pending:
        return const Color(0xFFF59E0B);
      case BookingStatus.confirmed:
        return const Color(0xFF3B82F6);
      case BookingStatus.inProgress:
        return const Color(0xFF8B5CF6);
      case BookingStatus.completed:
        return const Color(0xFF10B981);
      case BookingStatus.cancelled:
        return const Color(0xFFEF4444);
    }
  }
}
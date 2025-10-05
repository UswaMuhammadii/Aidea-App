import 'package:flutter/material.dart';
import 'service_model.dart';
import 'user_model.dart';

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
  final Service? service;
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
      id: json['id'],
      userId: json['userId'],
      serviceId: json['serviceId'],
      bookingDate: DateTime.parse(json['bookingDate']),
      bookingTime: DateTime.parse(json['bookingTime']),
      totalPrice: json['totalPrice'].toDouble(),
      status: BookingStatus.values.firstWhere(
            (e) => e.name == json['status'],
        orElse: () => BookingStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt']),
      notes: json['notes'],
      quantity: json['quantity'] ?? 1,
      paymentMethod: json['paymentMethod'] ?? 'cash',
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
        return Colors.orange;
      case BookingStatus.confirmed:
        return Colors.blue;
      case BookingStatus.inProgress:
        return Colors.purple;
      case BookingStatus.completed:
        return Colors.green;
      case BookingStatus.cancelled:
        return Colors.red;
    }
  }
}


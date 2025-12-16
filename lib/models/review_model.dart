class Review {
  final String id;
  final String bookingId;
  final String serviceId;
  final String serviceName;
  final String userId;
  final String userName;
  final String? workerId;
  final double rating;
  final String? comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.bookingId,
    required this.serviceId,
    required this.serviceName,
    required this.userId,
    required this.userName,
    this.workerId,
    required this.rating,
    this.comment,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'bookingId': bookingId,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'userId': userId,
      'userName': userName,
      'workerId': workerId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] ?? '',
      bookingId: json['bookingId'] ?? '',
      serviceId: json['serviceId'] ?? '',
      serviceName: json['serviceName'] ?? '',
      userId: json['userId'] ?? '',
      userName: json['userName'] ?? '',
      workerId: json['workerId'],
      rating: (json['rating'] ?? 0).toDouble(),
      comment: json['comment'],
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }
}

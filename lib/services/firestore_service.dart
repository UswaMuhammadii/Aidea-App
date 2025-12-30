import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../models/service_model.dart';
import '../models/booking_model.dart';
import '../models/review_model.dart';
import '../models/notification_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Collection References
  // Using Admin Panel compatible collection names
  CollectionReference get _usersRef => _firestore.collection('customers');
  CollectionReference get _servicesRef =>
      _firestore.collection('services_offered');
  CollectionReference get _categoriesRef =>
      _firestore.collection('service_categories');
  CollectionReference get _bookingsRef =>
      _firestore.collection('service_requests');
  CollectionReference get _reviewsRef => _firestore.collection('reviews');

  // --- User Operations ---
  Future<void> saveUser(User user) async {
    await _usersRef.doc(user.id).set(user.toJson(), SetOptions(merge: true));
  }

  Future<User?> getUser(String uid) async {
    final doc = await _usersRef.doc(uid).get();
    if (doc.exists) {
      return User.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Helper to find worker in likely collections
  Future<User?> getWorker(String uid) async {
    // 1. Try 'workers' collection
    var doc = await _firestore.collection('workers').doc(uid).get();
    if (doc.exists) return User.fromJson(doc.data() as Map<String, dynamic>);

    // 2. Try 'providers' collection
    doc = await _firestore.collection('providers').doc(uid).get();
    if (doc.exists) return User.fromJson(doc.data() as Map<String, dynamic>);

    // 3. Try 'users' collection (generic)
    doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) return User.fromJson(doc.data() as Map<String, dynamic>);

    // 4. Fallback to 'customers' using getUser
    return getUser(uid);
  }

  // --- Service Operations ---
  Future<List<Service>> getServices() async {
    final snapshot =
        await _servicesRef.where('isActive', isEqualTo: true).get();
    return snapshot.docs
        .map((doc) => Service.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<Service>> getServicesByCategory(String categoryId) async {
    final snapshot = await _servicesRef
        .where('isActive', isEqualTo: true)
        .where('categoryId', isEqualTo: categoryId)
        .get();
    return snapshot.docs
        .map((doc) => Service.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<ServiceCategory>> getCategories() async {
    final snapshot = await _categoriesRef.get();
    return snapshot.docs
        .map((doc) =>
            ServiceCategory.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  // --- Booking Operations ---
  Future<void> createBooking(Booking booking) async {
    await _bookingsRef.doc(booking.id).set(booking.toJson());
  }

  Stream<List<Booking>> getUserBookings(String userId) {
    return _bookingsRef
        .where('customerId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      final bookings = snapshot.docs
          .map((doc) => Booking.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      // Client-side sorting to avoid composite index requirements
      bookings.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return bookings;
    });
  }

  Stream<Booking> getBookingStream(String bookingId) {
    return _bookingsRef.doc(bookingId).snapshots().map((doc) {
      if (doc.exists && doc.data() != null) {
        return Booking.fromJson(doc.data() as Map<String, dynamic>);
      } else {
        throw Exception("Booking not found");
      }
    });
  }

  Future<void> cancelBooking(String bookingId, String reason) async {
    await _bookingsRef.doc(bookingId).update({
      'status': BookingStatus.cancelled.name,
      'cancellationReason': reason,
      'updatedAt': DateTime.now().toIso8601String(),
    });
  }

  Future<void> updateBookingStatus(
      String bookingId, BookingStatus status) async {
    final Map<String, dynamic> updates = {
      'status': status.name,
      'updatedAt': DateTime.now().toIso8601String(),
    };

    if (status == BookingStatus.completed) {
      updates['completedDate'] = DateTime.now().toIso8601String();
    }

    await _bookingsRef.doc(bookingId).update(updates);
  }

  Future<int> getWorkerCompletedBookingsCount(String workerId) async {
    final snapshot = await _bookingsRef
        .where('workerId', isEqualTo: workerId)
        .where('status', isEqualTo: 'completed')
        .count()
        .get();
    return snapshot.count ?? 0;
  }

  // --- Review Operations ---
  Future<void> submitReview(Review review) async {
    await _reviewsRef.doc(review.id).set(review.toJson());
  }

  Stream<List<Review>> getUserReviews(String userId) {
    return _reviewsRef
        .where('userId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
      final reviews = snapshot.docs
          .map((doc) => Review.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      // Client-side sorting
      reviews.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return reviews;
    });
  }

  // --- Chat Operations ---
  Stream<List<Map<String, dynamic>>> getChatMessages(String bookingId) {
    return _firestore
        .collection('chats')
        .doc(bookingId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> sendMessage(
      String bookingId, String text, String senderId) async {
    await _firestore
        .collection('chats')
        .doc(bookingId)
        .collection('messages')
        .add({
      'text': text,
      'senderId': senderId,
      'timestamp': FieldValue.serverTimestamp(),
      'type': 'text',
    });
  }

  // Check if a booking has a review
  Future<bool> hasReview(String bookingId) async {
    final snapshot =
        await _reviewsRef.where('bookingId', isEqualTo: bookingId).get();
    return snapshot.docs.isNotEmpty;
  }

  // --- Notification Operations ---
  CollectionReference _getNotificationsRef(String userId) {
    return _usersRef.doc(userId).collection('notifications');
  }

  Stream<List<NotificationModel>> getUserNotifications(String userId) {
    return _getNotificationsRef(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              NotificationModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  Future<void> addNotification(
      String userId, NotificationModel notification) async {
    await _getNotificationsRef(userId)
        .doc(notification.id)
        .set(notification.toJson());
  }

  Future<NotificationModel?> getNotification(
      String userId, String notificationId) async {
    final doc = await _getNotificationsRef(userId).doc(notificationId).get();
    if (doc.exists) {
      return NotificationModel.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  Future<void> markNotificationAsRead(
      String userId, String notificationId) async {
    await _getNotificationsRef(userId)
        .doc(notificationId)
        .update({'read': true});
  }

  Future<void> markAllNotificationsAsRead(String userId) async {
    final batch = _firestore.batch();
    final snapshot = await _getNotificationsRef(userId)
        .where('read', isEqualTo: false)
        .get();

    for (var doc in snapshot.docs) {
      batch.update(doc.reference, {'read': true});
    }

    await batch.commit();
  }

  Future<void> updateUserFcmToken(String userId, String token) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'fcmToken': token,
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Error updating FCM token: $e');
    }
  }
}

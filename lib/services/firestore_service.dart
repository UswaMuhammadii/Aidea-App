import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';
import '../models/service_model.dart';
import '../models/booking_model.dart';
import '../models/review_model.dart';

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

  // --- Review Operations ---
  Future<void> submitReview(Review review) async {
    await _reviewsRef.doc(review.id).set(review.toJson());
  }

  Stream<List<Review>> getUserReviews(String userId) {
    return _reviewsRef
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Review.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }

  // Check if a booking has a review
  Future<bool> hasReview(String bookingId) async {
    final snapshot =
        await _reviewsRef.where('bookingId', isEqualTo: bookingId).get();
    return snapshot.docs.isNotEmpty;
  }
}

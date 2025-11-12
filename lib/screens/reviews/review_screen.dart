// ===== REVIEWS SCREEN =====
// Save as: lib/screens/reviews/review_screen.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/user_model.dart';
import '../../models/booking_model.dart';
import '../../services/dummy_data_service.dart';
import '../../utils/app_colors.dart';
import '../../gen_l10n/app_localizations.dart';

// Review Model
class Review {
  final String id;
  final String bookingId;
  final String serviceId;
  final String serviceName;
  final double rating;
  final String? comment;
  final DateTime createdAt;

  Review({
    required this.id,
    required this.bookingId,
    required this.serviceId,
    required this.serviceName,
    required this.rating,
    this.comment,
    required this.createdAt,
  });
}

// Global reviews list (replace with backend later)
final List<Review> globalReviews = [];

class ReviewScreen extends StatefulWidget {
  final User user;

  const ReviewScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Booking> _completedBookings = [];
  List<Booking> _unratedBookings = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _loadData() {
    setState(() {
      _isLoading = true;
    });

    final allBookings = DummyDataService.getUserBookings(widget.user.id);
    _completedBookings = allBookings
        .where((booking) => booking.status == BookingStatus.completed)
        .toList();

    // Filter unrated bookings
    _unratedBookings = _completedBookings.where((booking) {
      return !globalReviews.any((review) => review.bookingId == booking.id);
    }).toList();

    setState(() {
      _isLoading = false;
    });
  }

  void _showRatingDialog(Booking booking, AppLocalizations l10n) {
    double rating = 5.0;
    final commentController = TextEditingController();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Header
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.electricBlue, Color(0xFF7C3AED)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.rate_review,
                            color: Colors.white,
                            size: 48,
                          ),
                          const SizedBox(height: 12),
                          Text(l10n.rateYourExperience,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            booking.service?.name ?? 'Service',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Star Rating
                    Text(
                      l10n.tapToRate,
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setDialogState(() {
                              rating = index + 1.0;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Icon(
                              index < rating ? Icons.star : Icons.star_border,
                              color: const Color(0xFFFFA726),
                              size: 40,
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      rating == 5.0
                          ? l10n.excellent
                          : rating >= 4.0
                          ? l10n.veryGood
                          : rating >= 3.0
                          ? l10n.good
                          : rating >= 2.0
                          ? l10n.fair
                          : l10n.poor,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Comment Field
                    Container(
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF0F172A) : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: TextField(
                        controller: commentController,
                        maxLines: 4,
                        style: TextStyle(
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        decoration: InputDecoration(
                          hintText: l10n.shareYourExperience,
                          hintStyle: TextStyle(
                            color: isDark ? Colors.grey.shade500 : Colors.grey.shade600,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              side: BorderSide(
                                color: isDark ? Colors.grey.shade600 : Colors.grey.shade400,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              l10n.cancel,
                              style: TextStyle(
                                color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.electricBlue, Color(0xFF7C3AED)],
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                final review = Review(
                                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                                  bookingId: booking.id,
                                  serviceId: booking.service?.id ?? '',
                                  serviceName: booking.service?.name ?? 'Service',
                                  rating: rating,
                                  comment: commentController.text.isNotEmpty
                                      ? commentController.text
                                      : null,
                                  createdAt: DateTime.now(),
                                );

                                setState(() {
                                  globalReviews.add(review);
                                  _loadData();
                                });

                                Navigator.pop(context);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: [
                                        const Icon(Icons.check_circle, color: Colors.white),
                                        const SizedBox(width: 8),
                                        Text(l10n.thankYouForYourReview),
                                      ],
                                    ),
                                    backgroundColor: Colors.green,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(l10n.submit,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(l10n.myReviews),
        backgroundColor: cardColor,
        foregroundColor: textColor,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.electricBlue,
          labelColor: AppColors.electricBlue,
          unselectedLabelColor: subtitleColor,
          tabs: [
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.toReview),
                  if (_unratedBookings.isNotEmpty) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${_unratedBookings.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Tab(text: l10n.myReviews),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
        controller: _tabController,
        children: [
          _buildToReviewTab(l10n),
          _buildMyReviewsTab(l10n),
        ],
      ),
    );
  }

  Widget _buildToReviewTab(AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    if (_unratedBookings.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.electricBlue.withValues(alpha: 0.1),
                    AppColors.electricBlue.withValues(alpha: 0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.rate_review_outlined,
                size: 80,
                color: AppColors.electricBlue,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noServicesToReview,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.completeServicesToLeaveReviews,
              style: TextStyle(
                fontSize: 16,
                color: subtitleColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _unratedBookings.length,
      itemBuilder: (context, index) {
        final booking = _unratedBookings[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.electricBlue, Color(0xFF7C3AED)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.service?.name ?? 'Service',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Completed on ${DateFormat('MMM dd, yyyy').format(booking.bookingDate)}',
                            style: TextStyle(
                              fontSize: 13,
                              color: subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppColors.electricBlue, Color(0xFF7C3AED)],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ElevatedButton(
                      onPressed: () => _showRatingDialog(booking, l10n),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.star, color: Colors.white, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            l10n.writeAReview,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMyReviewsTab(AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    if (globalReviews.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.electricBlue.withValues(alpha: 0.1),
                    AppColors.electricBlue.withValues(alpha: 0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.rate_review_outlined,
                size: 80,
                color: AppColors.electricBlue,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noReviewsYet,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l10n.yourReviewsWillAppearHere,
              style: TextStyle(
                fontSize: 16,
                color: subtitleColor,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: globalReviews.length,
      itemBuilder: (context, index) {
        final review = globalReviews[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.electricBlue, Color(0xFF7C3AED)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.rate_review,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            review.serviceName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            DateFormat('MMM dd, yyyy').format(review.createdAt),
                            style: TextStyle(
                              fontSize: 13,
                              color: subtitleColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(5, (starIndex) {
                    return Icon(
                      starIndex < review.rating ? Icons.star : Icons.star_border,
                      color: const Color(0xFFFFA726),
                      size: 20,
                    );
                  }),
                ),
                if (review.comment != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark ? const Color(0xFF0F172A) : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      review.comment!,
                      style: TextStyle(
                        fontSize: 14,
                        color: textColor,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
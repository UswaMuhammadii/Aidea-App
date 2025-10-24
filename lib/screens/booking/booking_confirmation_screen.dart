// ===== UPDATED: booking_confirmation_screen.dart =====

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/user_model.dart';
import '../../models/booking_model.dart';
import '../dashboard/dashboard_screen.dart';
import '../../utils/app_colors.dart';

class BookingConfirmationScreen extends StatelessWidget {
  final List<Booking> bookings;
  final User user;
  final double totalAmount;

  const BookingConfirmationScreen({
    super.key,
    required this.bookings,
    required this.user,
    required this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    final firstBooking = bookings.first;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              // Success Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.success, AppColors.success],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.success.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 50,
                ),
              ),
              const SizedBox(height: 24),

              // Success Message
              Text(
                'Booking Confirmed!',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.success,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                bookings.length > 1
                    ? 'Your ${bookings.length} services have been successfully booked'
                    : 'Your service has been successfully booked',
                style: TextStyle(
                  fontSize: 16,
                  color: subtitleColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Booking Details Card
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.electricBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.receipt_long,
                              color: AppColors.electricBlue,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Booking Details',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Services List
                      if (bookings.length > 1) ...[
                        _buildDetailRow('Services', '${bookings.length} services booked', textColor, subtitleColor),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey.shade900 : Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: bookings.map((booking) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 6,
                                      height: 6,
                                      decoration: const BoxDecoration(
                                        color: AppColors.electricBlue,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        '${booking.service?.name ?? 'Service'} (Qty: ${booking.quantity})',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: textColor,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'SAR ${booking.totalPrice.toStringAsFixed(0)}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.electricBlue,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 12),
                      ] else
                        _buildDetailRow('Service', firstBooking.service?.name ?? 'Service', textColor, subtitleColor),

                      _buildDetailRow('Date', DateFormat('EEEE, MMMM d, y').format(firstBooking.bookingDate), textColor, subtitleColor),
                      _buildDetailRow('Time', DateFormat('h:mm a').format(firstBooking.bookingTime), textColor, subtitleColor),
                      if (bookings.length == 1)
                        _buildDetailRow('Quantity', '${firstBooking.quantity}', textColor, subtitleColor),
                      Divider(height: 32, color: isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            'SAR ${totalAmount.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.electricBlue,
                            ),
                          ),
                        ],
                      ),

                      if (firstBooking.notes != null && firstBooking.notes!.isNotEmpty) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.electricBlue.withOpacity(isDark ? 0.2 : 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.note,
                                size: 16,
                                color: AppColors.electricBlue,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  firstBooking.notes!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: textColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Info Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.electricBlue.withOpacity(isDark ? 0.15 : 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: AppColors.electricBlue,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'What\'s Next?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: textColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildInfoItem('You will receive a confirmation email shortly', textColor),
                    _buildInfoItem('A reminder will be sent 24 hours before', textColor),
                    _buildInfoItem('View your bookings in the Orders section', textColor),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(
                              user: user,
                              initialTab: 0,
                              onLogout: () {
                                Navigator.of(context).pushReplacementNamed('/login');
                              },
                            ),
                          ),
                              (route) => false,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: isDark ? Colors.grey.shade600 : AppColors.electricBlue,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Back to Home',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.grey.shade300 : AppColors.electricBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppColors.electricBlue, AppColors.electricBlue],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.electricBlue.withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => DashboardScreen(
                                  user: user,
                                  initialTab: 1,
                                  onLogout: () {
                                    Navigator.of(context).pushReplacementNamed('/login');
                                  },
                                ),
                              ),
                                  (route) => false,
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            alignment: Alignment.center,
                            child: const Text(
                              'View Bookings',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
  }

  Widget _buildDetailRow(String label, String value, Color textColor, Color subtitleColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: subtitleColor,
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            size: 16,
            color: AppColors.electricBlue,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;

  const ServiceImageWidget({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAsset = imageUrl.startsWith('assets/');

    if (isAsset) {
      return Image.asset(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback(isDark);
        },
      );
    } else {
      return Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return _buildFallback(isDark);
        },
      );
    }
  }

  Widget _buildFallback(bool isDark) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [Colors.grey.shade800, Colors.grey.shade700]
              : [Colors.grey.shade200, Colors.grey.shade300],
        ),
      ),
      child: Icon(
        Icons.image,
        size: 60,
        color: isDark ? Colors.grey.shade500 : Colors.grey.shade400,
      ),
    );
  }
}

// ===== UPDATED: service_checkout_screen.dart (Dark Mode) =====
// Add to build method:
// final isDark = Theme.of(context).brightness == Brightness.dark;
// final backgroundColor = isDark ? const Color(0xFF0F172A) : Colors.white;
// final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
// final textColor = isDark ? Colors.white : Colors.black87;

// Then update Container decorations:
// body: Container(
//   color: backgroundColor,
//   child: ...

// And TextField backgrounds:
// fillColor: isDark ? const Color(0xFF1E293B) : Colors.white,
// hintStyle: TextStyle(color: isDark ? Colors.grey.shade400 : Colors.grey.shade600),
// style: TextStyle(color: textColor),

// ===== UPDATED: service_detail_screen.dart (Dark Mode) =====
// In build() add:
// final isDark = Theme.of(context).brightness == Brightness.dark;
// final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
// final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
// final textColor = isDark ? Colors.white : Colors.black87;

// Update Scaffold:
// Scaffold(
//   backgroundColor: backgroundColor,
//   ...

// Update Container backgrounds in build:
// Container(
//   color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA),
//   ...

// ===== DARK MODE THEME HELPER =====
// Use this across all screens for consistency:

class DarkModeHelper {
  static Map<String, Color> getColors(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return {
      'background': isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA),
      'surface': isDark ? const Color(0xFF1E293B) : Colors.white,
      'text': isDark ? Colors.white : Colors.black87,
      'subtitle': isDark ? Colors.grey.shade400 : Colors.grey.shade600,
      'border': isDark ? Colors.grey.shade700 : Colors.grey.shade300,
      //'shadow': isDark ? 0.3 : 0.08,
    };
  }
}
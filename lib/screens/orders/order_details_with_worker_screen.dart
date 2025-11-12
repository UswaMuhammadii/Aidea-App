import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/user_model.dart';
import '../../models/booking_model.dart';
import 'vendor_profile_screen.dart';
import 'chat_screen.dart';
import '../../utils/app_colors.dart';
import '../../gen_l10n/app_localizations.dart';

class OrderDetailsWithWorkerScreen extends StatefulWidget {
  final User user;
  final Booking booking;

  const OrderDetailsWithWorkerScreen({
    Key? key,
    required this.user,
    required this.booking,
  }) : super(key: key);

  @override
  State<OrderDetailsWithWorkerScreen> createState() => _OrderDetailsWithWorkerScreenState();
}

class _OrderDetailsWithWorkerScreenState extends State<OrderDetailsWithWorkerScreen> {
  // Dummy worker data
  final String workerName = "Sarish Naz";
  final String workerPhone = "+92 300 1234567";
  final int totalOrders = 432;
  final String workingPeriod = "2 years";
  final String workerImage = "";

  // Previous services done by this technician
  final List<Map<String, dynamic>> previousServices = [
    {
      'icon': Icons.clean_hands,
      'title': 'Deep House Cleaning',
      'count': 156,
      'color': AppColors.electricBlue,
    },
    {
      'icon': Icons.weekend,
      'title': 'Sofa Cleaning',
      'count': 98,
      'color': AppColors.electricBlue,
    },
    {
      'icon': Icons.local_laundry_service,
      'title': 'Carpet Cleaning',
      'count': 87,
      'color': AppColors.brightTeal,
    },
    {
      'icon': Icons.countertops,
      'title': 'Kitchen Deep Clean',
      'count': 63,
      'color': const Color(0xFFF59E0B),
    },
    {
      'icon': Icons.shower,
      'title': 'Bathroom Sanitization',
      'count': 28,
      'color': AppColors.success,
    },
  ];

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
        title: Text(l10n.orderDetails),
        backgroundColor: cardColor,
        foregroundColor: textColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Service Title
                  Text(
                    widget.booking.service?.name ?? 'Service',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.electricBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('h:mm a, d-MMM-y').format(widget.booking.bookingTime),
                    style: TextStyle(fontSize: 14, color: subtitleColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Order #${widget.booking.id.substring(0, widget.booking.id.length > 15 ? 15 : widget.booking.id.length).toUpperCase()}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.electricBlue,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Address
                  Text(
                    'Service Address',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.user.address,
                    style: TextStyle(fontSize: 13, color: textColor),
                  ),

                  const SizedBox(height: 16),

                  // Emergency Button
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.red.shade300, width: 2),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Emergency contact initiated'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Icon(Icons.warning, color: Colors.red.shade700, size: 32),
                              const SizedBox(width: 12),
                              Text(
                                'Faced any emergency?',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red.shade700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Worker Info Card
                  Container(
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
                        children: [
                          // Worker Profile
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColors.electricBlue.withValues(alpha: 0.1),
                                child: const Icon(Icons.person, size: 35, color: AppColors.electricBlue),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      workerName,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Professional Technician',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: subtitleColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.verified, color: AppColors.electricBlue, size: 20),
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Stats Row - Only Orders and Time Period
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _buildStatItem(
                                Icons.check_circle,
                                '$totalOrders',
                                l10n.ordersDone,
                                textColor,
                                subtitleColor,
                              ),
                              Container(
                                height: 40,
                                width: 1,
                                color: Colors.grey.shade300,
                              ),
                              _buildStatItem(
                                Icons.access_time,
                                workingPeriod,
                                l10n.experience,
                                textColor,
                                subtitleColor,
                              ),
                            ],
                          ),

                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 8),

                          // Action Buttons
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VendorProfileScreen(
                                          workerName: workerName,
                                          totalOrders: totalOrders,
                                          workingPeriod: workingPeriod,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.person),
                                  label: Text(l10n.viewProfile),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.blue,
                                    side: const BorderSide(color: Colors.blue),
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                          workerName: workerName,
                                          user: widget.user,
                                        ),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.chat),
                                  label: Text(l10n.chat),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(vertical: 12),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Services Expertise Section
                  Text(
                    'Service Expertise',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Previously completed services by $workerName',
                    style: TextStyle(
                      fontSize: 13,
                      color: subtitleColor,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Services List
                  Container(
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
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: previousServices.length,
                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: isDark ? Colors.grey.shade700 : Colors.grey.shade200,
                      ),
                      itemBuilder: (context, index) {
                        final service = previousServices[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: (service['color'] as Color).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              service['icon'] as IconData,
                              color: service['color'] as Color,
                              size: 24,
                            ),
                          ),
                          title: Text(
                            service['title'] as String,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          trailing: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: (service['color'] as Color).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${service['count']} done',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: service['color'] as Color,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    String? selectedReason;
    final reasons = [
      'Change of plans',
      'Found better service',
      'Incorrect booking details',
      'Emergency situation',
      'Price too high',
      'Technician not available',
      'Service no longer needed',
      'Other reason',
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: dialogBg,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.red.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.cancel,
                            color: Colors.red.shade700,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            l10n.cancelBooking,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close, color: textColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Please select a reason for cancellation',
                      style: TextStyle(
                        fontSize: 14,
                        color: subtitleColor,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      constraints: const BoxConstraints(maxHeight: 300),
                      child: SingleChildScrollView(
                        child: Column(
                          children: reasons.map((reason) {
                            final isSelected = selectedReason == reason;
                            return InkWell(
                              onTap: () {
                                setDialogState(() {
                                  selectedReason = reason;
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.red.shade50
                                      : (isDark ? const Color(0xFF0F172A) : Colors.grey.shade100),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected ? Colors.red.shade300 : Colors.transparent,
                                    width: 2,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                                      color: isSelected ? Colors.red.shade700 : subtitleColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        reason,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                          color: isSelected ? Colors.red.shade700 : textColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.orange.shade200),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning_amber_rounded, color: Colors.orange.shade700, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Cancellation may incur charges',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange.shade900,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: isDark ? Colors.grey.shade600 : Colors.grey.shade300),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text('Keep Booking', style: TextStyle(color: textColor, fontWeight: FontWeight.w600)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: selectedReason == null
                                ? null
                                : () {
                              Navigator.pop(context);
                              _confirmCancellation(context, selectedReason!, l10n);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              disabledBackgroundColor: Colors.grey.shade300,
                            ),
                            child: Text(l10n.cancelBooking, style: TextStyle(fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _confirmCancellation(BuildContext context, String reason, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: dialogBg,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade100,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.check_circle, color: Colors.green.shade700, size: 48),
                ),
                const SizedBox(height: 20),
                Text('Booking Cancelled', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: textColor)),
                const SizedBox(height: 12),
                Text(
                  'Your booking has been cancelled successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? const Color(0xFF0F172A) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline, size: 16, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      Expanded(child: Text('Reason: $reason', style: TextStyle(fontSize: 12, color: textColor))),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(l10n.done, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(
      IconData icon,
      String value,
      String label,
      Color textColor,
      Color subtitleColor,
      ) {
    return Column(
      children: [
        Icon(icon, color: AppColors.electricBlue, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: subtitleColor,
          ),
        ),
      ],
    );
  }
}
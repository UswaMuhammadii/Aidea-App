import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../models/booking_model.dart';
import 'order_details_with_worker_screen.dart';
import '../../utils/app_colors.dart';
import '../../gen_l10n/app_localizations.dart';
import '../../utils/formatting_utils.dart';
import '../../services/firestore_service.dart';

class OrderTrackingScreen extends StatefulWidget {
  final User user;
  final Booking booking;
  final String? localizedServiceName; // Added

  const OrderTrackingScreen({
    Key? key,
    required this.user,
    required this.booking,
    this.localizedServiceName,
  }) : super(key: key);

  @override
  State<OrderTrackingScreen> createState() => _OrderTrackingScreenState();
}

class _OrderTrackingScreenState extends State<OrderTrackingScreen> {
  final TextEditingController _cancelReasonController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void dispose() {
    _cancelReasonController.dispose();
    super.dispose();
  }

  void _showCancelDialog(
      BuildContext context, AppLocalizations l10n, String bookingId) {
    _cancelReasonController.clear();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    String? selectedReason;
    final reasons = [
      l10n.changeOfPlans,
      l10n.foundBetterService,
      l10n.incorrectBookingDetails,
      l10n.emergencySituation,
      l10n.priceTooHigh,
      l10n.technicianNotAvailable,
      l10n.serviceNoLongerNeeded,
      l10n.otherReason,
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
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
                          child: Icon(Icons.cancel,
                              color: Colors.red.shade700, size: 24),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(l10n.cancelBooking,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: textColor)),
                        ),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(Icons.close, color: textColor),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(l10n.pleaseSelectReasonForCancellation,
                        style: TextStyle(fontSize: 14, color: subtitleColor)),
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
                                      : (isDark
                                          ? const Color(0xFF0F172A)
                                          : Colors.grey.shade100),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                      color: isSelected
                                          ? Colors.red.shade300
                                          : Colors.transparent,
                                      width: 2),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      isSelected
                                          ? Icons.radio_button_checked
                                          : Icons.radio_button_unchecked,
                                      color: isSelected
                                          ? Colors.red.shade700
                                          : subtitleColor,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        reason,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: isSelected
                                              ? FontWeight.w600
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? Colors.red.shade700
                                              : textColor,
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
                          Icon(Icons.warning_amber_rounded,
                              color: Colors.orange.shade700, size: 20),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              l10n.cancellationMayIncurCharges,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.orange.shade900,
                                  fontWeight: FontWeight.w500),
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
                              side: BorderSide(
                                  color: isDark
                                      ? Colors.grey.shade600
                                      : Colors.grey.shade300),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(l10n.keepBooking,
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: selectedReason == null
                                ? null
                                : () async {
                                    Navigator.pop(context);
                                    try {
                                      await _firestoreService.cancelBooking(
                                        bookingId,
                                        selectedReason!,
                                      );
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(l10n.bookingCancelled),
                                          backgroundColor: Colors.green,
                                        ),
                                      );
                                      // Pop is handled by StreamBuilder update or user action
                                      Navigator.pop(context);
                                    } catch (e) {
                                      if (!mounted) return;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('Error: $e'),
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    }
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade600,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              disabledBackgroundColor: Colors.grey.shade300,
                            ),
                            child: Text(l10n.cancelBooking,
                                style: TextStyle(fontWeight: FontWeight.w600)),
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : Colors.white;
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return StreamBuilder<Booking>(
      stream: _firestoreService.getBookingStream(widget.booking.id),
      initialData: widget.booking,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.orderDetails)),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        if (!snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.orderDetails)),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        final booking = snapshot.data!;
        final currentStatus = booking.status;

        bool hasTechnician = currentStatus == BookingStatus.accepted ||
            currentStatus == BookingStatus.inProgress;

        // Disable cancel if technician assigned (accepted/inProgress) or completed/cancelled
        bool canCancel = currentStatus == BookingStatus.pending;

        return Scaffold(
            backgroundColor: backgroundColor,
            appBar: AppBar(
              title: Text(l10n.orderDetails),
              backgroundColor: cardColor,
              foregroundColor: textColor,
              elevation: 0,
              actions: [
                // Always show the button, but disable it visually and functionally if not allowed
                TextButton.icon(
                  onPressed: canCancel
                      ? () {
                          _showCancelDialog(context, l10n, booking.id);
                        }
                      : null, // Disable if cannot cancel
                  icon: Icon(Icons.cancel_outlined,
                      color: canCancel ? Colors.red.shade600 : Colors.grey,
                      size: 20),
                  label: Text(
                    l10n.cancelBooking,
                    style: TextStyle(
                      color: canCancel ? Colors.red.shade600 : Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
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
                        Text(
                          l10n.servicesList,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Service Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.cleaning_services,
                                        color: Colors.blue, size: 24),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.localizedServiceName ??
                                              (booking.serviceName.isNotEmpty
                                                  ? booking.serviceName
                                                  : l10n.service),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: textColor,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '${l10n.quantity}: ${FormattingUtils.formatNumber(booking.quantity, locale)}',
                                          style: TextStyle(
                                            fontSize: 13,
                                            color: subtitleColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    FormattingUtils.formatCurrency(
                                        booking.totalPrice, l10n, locale),
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Order Info Card
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isDark
                                  ? Colors.grey.shade700
                                  : Colors.grey.shade300,
                            ),
                          ),
                          child: Column(
                            children: [
                              _buildInfoRow(
                                  Icons.receipt_long,
                                  l10n.orderId,
                                  '#${booking.id.substring(0, booking.id.length > 15 ? 15 : booking.id.length).toUpperCase()}',
                                  textColor,
                                  subtitleColor),
                              const Divider(height: 24),
                              _buildInfoRow(
                                  Icons.calendar_today,
                                  l10n.bookingDate,
                                  FormattingUtils.formatDateShort(
                                      context, booking.bookingDate),
                                  textColor,
                                  subtitleColor),
                              const Divider(height: 24),
                              _buildInfoRow(
                                  Icons.access_time,
                                  l10n.serviceTime,
                                  booking.bookingTime,
                                  textColor,
                                  subtitleColor),
                              const Divider(height: 24),
                              _buildInfoRow(
                                  Icons.location_on,
                                  l10n.address,
                                  widget.user.address,
                                  textColor,
                                  subtitleColor),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Order Status Card
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.electricBlue,
                                AppColors.electricBlue
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.withValues(alpha: 0.3),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    l10n.orderStatus,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 6),
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.white.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      _getStatusText(currentStatus, l10n),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              _buildStatusTimeline(currentStatus, l10n, locale),
                            ],
                          ),
                        ),

                        if (hasTechnician) ...[
                          const SizedBox(height: 20),
                          // Technician Card - with navigate button
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isDark
                                    ? Colors.grey.shade700
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundColor: Colors.blue.shade100,
                                      child: const Icon(Icons.person,
                                          size: 35, color: Colors.blue),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.booking.workerName ??
                                                'Assigned Worker',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  color: Colors.amber,
                                                  size: 16),
                                              const SizedBox(width: 4),
                                              Text(
                                                '4.8',
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: subtitleColor,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                l10n.ordersDone,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: subtitleColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Icon(Icons.verified,
                                        color: Colors.blue, size: 24),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrderDetailsWithWorkerScreen(
                                            user: widget.user,
                                            booking: booking,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(Icons.info_outline,
                                        size: 20),
                                    label: Text(l10n.viewTechnicianDetails),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
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
                ],
              ),
            ));
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value,
      Color textColor, Color subtitleColor) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: subtitleColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getStatusText(BookingStatus status, AppLocalizations l10n) {
    switch (status) {
      case BookingStatus.pending:
        return l10n.pending;
      case BookingStatus.accepted:
        return l10n.confirmed;
      case BookingStatus.inProgress:
        return l10n.inProgress;
      case BookingStatus.completed:
        return l10n.completed;
      case BookingStatus.cancelled:
        return l10n.cancelled;
      default:
        return 'Unknown';
    }
  }

  Widget _buildStatusTimeline(
      BookingStatus currentStatus, AppLocalizations l10n, Locale locale) {
    final stages = [
      {'status': BookingStatus.pending, 'label': l10n.bookingReceived},
      {'status': BookingStatus.accepted, 'label': l10n.technicianAssigned},
      {'status': BookingStatus.inProgress, 'label': l10n.workStarted},
      {'status': BookingStatus.completed, 'label': l10n.workCompleted},
    ];

    return Row(
      children: List.generate(stages.length, (index) {
        final stage = stages[index];
        final stageStatus = stage['status'] as BookingStatus;
        final isActive = currentStatus.index >= stageStatus.index;
        final isLast = index == stages.length - 1;

        return Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isActive
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: isActive
                            ? const Icon(Icons.check,
                                color: Colors.blue, size: 20)
                            : Text(
                                FormattingUtils.formatNumber(index + 1, locale),
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      stage['label'] as String,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: isActive
                            ? Colors.white
                            : Colors.white.withValues(alpha: 0.6),
                        fontWeight:
                            isActive ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Container(
                  height: 2,
                  width: 20,
                  color: isActive
                      ? Colors.white
                      : Colors.white.withValues(alpha: 0.3),
                ),
            ],
          ),
        );
      }),
    );
  }
}

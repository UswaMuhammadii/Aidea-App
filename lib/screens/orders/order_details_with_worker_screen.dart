import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/user_model.dart';
import '../../models/booking_model.dart';

import '../../services/firestore_service.dart';

import 'chat_screen.dart';
import '../../utils/app_colors.dart';
import '../../gen_l10n/app_localizations.dart';
import '../../utils/formatting_utils.dart';

class OrderDetailsWithWorkerScreen extends StatefulWidget {
  final User user;
  final Booking booking;
  final String? localizedServiceName; // Added

  const OrderDetailsWithWorkerScreen({
    Key? key,
    required this.user,
    required this.booking,
    this.localizedServiceName,
  }) : super(key: key);

  @override
  State<OrderDetailsWithWorkerScreen> createState() =>
      _OrderDetailsWithWorkerScreenState();
}

class _OrderDetailsWithWorkerScreenState
    extends State<OrderDetailsWithWorkerScreen> {
  // Worker Data
  User? _fetchedWorker;
  bool _isLoadingWorker = false;
  int _completedOrdersCount = 0;
  final FirestoreService _firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _fetchWorker();
  }

  Future<void> _fetchWorker() async {
    if (widget.booking.workerId != null) {
      setState(() => _isLoadingWorker = true);
      try {
        final worker =
            await _firestoreService.getWorker(widget.booking.workerId!);
        final count = await _firestoreService
            .getWorkerCompletedBookingsCount(widget.booking.workerId!);

        if (mounted) {
          setState(() {
            _fetchedWorker = worker;
            _completedOrdersCount = count;
          });
        }
      } catch (e) {
        debugPrint("Error fetching worker: $e");
      } finally {
        if (mounted) {
          setState(() => _isLoadingWorker = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context);

    // Check if cancellation is allowed (only when status is pending)
    final bool canCancel = widget.booking.status == BookingStatus.pending;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor =
        isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
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
        actions: [
          TextButton.icon(
            onPressed: canCancel
                ? () {
                    _showCancelDialog(context, l10n);
                  }
                : null,
            icon: Icon(Icons.cancel_outlined,
                color: canCancel ? Colors.red.shade600 : Colors.grey, size: 20),
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
                  // Service Title
                  Text(
                    widget.localizedServiceName ??
                        (widget.booking.serviceName.isNotEmpty
                            ? widget.booking.serviceName
                            : l10n.service),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.electricBlue,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${widget.booking.bookingTime}, ${FormattingUtils.formatDateShort(context, widget.booking.bookingDate)}',
                    style: TextStyle(fontSize: 14, color: subtitleColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${l10n.orderNumber} ${widget.booking.id.substring(0, widget.booking.id.length > 15 ? 15 : widget.booking.id.length).toUpperCase()}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.electricBlue,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Address
                  Text(
                    l10n.serviceLocation,
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
                        onTap: () async {
                          final Uri launchUri = Uri(
                            scheme: 'tel',
                            path: '0590409260',
                          );
                          try {
                            if (!await launchUrl(launchUri)) {
                              throw Exception('Could not launch');
                            }
                          } catch (e) {
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(l10n.emergencyContactInitiated),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              const Icon(Icons.warning,
                                  color: Colors.red, size: 32),
                              const SizedBox(width: 12),
                              Text(
                                l10n.facedAnyEmergency,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
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
                          color: Colors.black
                              .withValues(alpha: isDark ? 0.3 : 0.08),
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
                                backgroundColor: AppColors.electricBlue
                                    .withValues(alpha: 0.1),
                                backgroundImage: _fetchedWorker?.profileImage !=
                                        null
                                    ? Image.network(
                                        _fetchedWorker!.profileImage!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return const Icon(Icons.person,
                                              size: 35,
                                              color: AppColors.electricBlue);
                                        },
                                      ).image
                                    : null,
                                child: _fetchedWorker?.profileImage == null
                                    ? const Icon(Icons.person,
                                        size: 35, color: AppColors.electricBlue)
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _fetchedWorker?.name ??
                                          widget.booking.workerName ??
                                          "Assigned Worker",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      l10n.professionalTechnician,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: subtitleColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (_fetchedWorker !=
                                  null) // Removed isVerified check for now as User doesn't have it
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade100,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.verified,
                                      color: AppColors.electricBlue, size: 20),
                                ),
                            ],
                          ),

                          const SizedBox(height: 16),

                          // Stats Row - Only Orders
                          if (_isLoadingWorker)
                            const Center(child: CircularProgressIndicator())
                          else if (_fetchedWorker != null)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _buildStatItem(
                                  Icons.check_circle,
                                  FormattingUtils.formatNumber(
                                      _completedOrdersCount, locale),
                                  l10n.ordersDone,
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
                                    _showWorkerProfileDialog(context);
                                  },
                                  icon: const Icon(Icons.person),
                                  label: Text(l10n.viewProfile),
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.blue,
                                    side: const BorderSide(color: Colors.blue),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
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
                                          workerName: _fetchedWorker?.name ??
                                              widget.booking.workerName ??
                                              "Worker",
                                          workerId:
                                              widget.booking.workerId ?? '',
                                          bookingId: widget.booking.id,
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
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
                      l10n.pleaseSelectReasonForCancellation,
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
                                      : (isDark
                                          ? const Color(0xFF0F172A)
                                          : Colors.grey.shade100),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.red.shade300
                                        : Colors.transparent,
                                    width: 2,
                                  ),
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
                                : () {
                                    Navigator.pop(context);
                                    _confirmCancellation(
                                        context, selectedReason!, l10n);
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

  void _confirmCancellation(
      BuildContext context, String reason, AppLocalizations l10n) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                  child: Icon(Icons.check_circle,
                      color: Colors.green.shade700, size: 48),
                ),
                const SizedBox(height: 20),
                Text(l10n.bookingCancelled,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textColor)),
                const SizedBox(height: 12),
                Text(
                  'Your booking has been cancelled successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color:
                          isDark ? Colors.grey.shade400 : Colors.grey.shade600),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color:
                        isDark ? const Color(0xFF0F172A) : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.info_outline,
                          size: 16, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      Expanded(
                          child: Text('Reason: $reason',
                              style:
                                  TextStyle(fontSize: 12, color: textColor))),
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(l10n.done,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showWorkerProfileDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final dialogBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    final workerName =
        _fetchedWorker?.name ?? widget.booking.workerName ?? 'Worker';
    final workerPhone = _fetchedWorker?.phone ?? '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: dialogBg,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.electricBlue.withOpacity(0.1),
                  backgroundImage: _fetchedWorker?.profileImage != null
                      ? NetworkImage(_fetchedWorker!.profileImage!)
                      : null,
                  child: _fetchedWorker?.profileImage == null
                      ? const Icon(Icons.person,
                          size: 40, color: AppColors.electricBlue)
                      : null,
                ),
                const SizedBox(height: 16),

                // Name
                Text(
                  workerName,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor),
                ),
                const SizedBox(height: 8),

                // Phone
                if (workerPhone.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.phone, size: 16, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text(
                        workerPhone,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: textColor),
                      ),
                    ],
                  ),

                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 16),

                // Stats
                Column(
                  children: [
                    Text(
                      '${_completedOrdersCount}',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.electricBlue),
                    ),
                    Text(
                      l10n.ordersDone,
                      style: TextStyle(
                          fontSize: 14,
                          color: isDark
                              ? Colors.grey.shade400
                              : Colors.grey.shade600),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 12)),
                    child: Text(l10n.done),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(IconData icon, String value, String label,
      Color textColor, Color subtitleColor) {
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

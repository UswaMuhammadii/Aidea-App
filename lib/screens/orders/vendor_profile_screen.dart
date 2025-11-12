import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../gen_l10n/app_localizations.dart';

class VendorProfileScreen extends StatelessWidget {
  final String workerName;
  final int totalOrders;
  final String workingPeriod;

  const VendorProfileScreen({
    Key? key,
    required this.workerName,
    required this.totalOrders,
    required this.workingPeriod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;

    // Dummy services list
    final services = [
      'Sofa Cleaning',
      '7 Seater Sofa Set Cleaning',
      '5 Seater Sofa Set Cleaning',
      '6 Seater Sofa Set Cleaning',
      'Dewan Cleaning',
      'Sofa Cum Bed Cleaning',
      '10 Seater Sofa Cleaning',
      'Chair Cleaning - 4 Seats',
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(l10n.vendorProfile),
        backgroundColor: cardColor,
        foregroundColor: textColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header with Black Background
            Container(
              color: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  // Worker Avatar
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey.shade300,
                    child: const Icon(Icons.person, size: 60, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),

                  // Worker Name
                  Text(
                    workerName,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Stats Cards - REMOVED workerRating parameter
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard(
                          Icons.check_circle,
                          '$totalOrders',
                          l10n.orderDone,
                        ),
                        _buildStatCard(
                          Icons.access_time,
                          workingPeriod,
                          l10n.timePeriod,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Verification Badges
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.blue, size: 20),
                          SizedBox(width: 4),
                          Text(
                            l10n.profileVerified,
                            style: TextStyle(color: Colors.blue, fontSize: 13),
                          ),
                        ],
                      ),
                      SizedBox(width: 24),
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.blue, size: 20),
                          SizedBox(width: 4),
                          Text(
                            l10n.policeVerified,
                            style: TextStyle(color: Colors.blue, fontSize: 13),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Services List
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.servicesProvide,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Services Cards
                  ...List.generate(services.length, (index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Text(
                        '(${index + 1})  ${services[index]}',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../gen_l10n/app_localizations.dart';
import '../../services/firestore_service.dart';
import '../../models/notification_model.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final String? _currentUserId = FirebaseAuth.instance.currentUser?.uid;

  String _getTimeAgo(DateTime dateTime, AppLocalizations l10n) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return l10n.timeAgoJustNow;
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return minutes == 1
          ? l10n.timeAgoMinutesAgo.replaceAll('\$COUNT\$', '1')
          : l10n.timeAgoMinutesAgoPlural
              .replaceAll('\$COUNT\$', minutes.toString());
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return hours == 1
          ? l10n.timeAgoHoursAgo.replaceAll('\$COUNT\$', '1')
          : l10n.timeAgoHoursAgoPlural
              .replaceAll('\$COUNT\$', hours.toString());
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return days == 1
          ? l10n.timeAgoDaysAgo.replaceAll('\$COUNT\$', '1')
          : l10n.timeAgoDaysAgoPlural.replaceAll('\$COUNT\$', days.toString());
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1
          ? l10n.timeAgoWeeksAgo.replaceAll('\$COUNT\$', '1')
          : l10n.timeAgoWeeksAgoPlural
              .replaceAll('\$COUNT\$', weeks.toString());
    } else {
      final months = (difference.inDays / 30).floor();
      return months == 1
          ? l10n.timeAgoMonthsAgo.replaceAll('\$COUNT\$', '1')
          : l10n.timeAgoMonthsAgoPlural
              .replaceAll('\$COUNT\$', months.toString());
    }
  }

  void _markAllAsRead() async {
    if (_currentUserId != null) {
      await _firestoreService.markAllNotificationsAsRead(_currentUserId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_currentUserId == null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.notifications)),
        body: Center(child: Text("Please login to view notifications")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notifications),
        actions: [
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: 'Mark all as read',
            onPressed: _markAllAsRead,
          ),
        ],
      ),
      body: StreamBuilder<List<NotificationModel>>(
        stream: _firestoreService.getUserNotifications(_currentUserId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final notifications = snapshot.data ?? [];

          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.notifications_off_outlined,
                      size: 60, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(l10n.noNotificationsYet ??
                      "No notifications yet"), // Fallback if l10n missing
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final item = notifications[index];
              final timeAgo = _getTimeAgo(item.createdAt, l10n);

              return Dismissible(
                key: Key(item.id),
                background: Container(color: Colors.red),
                onDismissed: (direction) {
                  // Optional: Implement delete logic
                },
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: item.read
                        ? Colors.grey.shade200
                        : Theme.of(context).primaryColor.withOpacity(0.1),
                    child: Icon(
                      item.type == 'invoice'
                          ? Icons.receipt_long
                          : Icons.notifications,
                      color: item.read
                          ? Colors.grey
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  title: Text(
                    item.title,
                    style: TextStyle(
                      fontWeight:
                          item.read ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("${item.message}\n$timeAgo"),
                  isThreeLine: true,
                  onTap: () {
                    // Mark as read when tapped
                    _firestoreService.markNotificationAsRead(
                        _currentUserId!, item.id);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

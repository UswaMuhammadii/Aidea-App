import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/user_model.dart';

enum NotificationType {
  booking,
  promotion,
  reminder,
  payment,
  technicianAssigned,
  workStarted,
  workCompleted,
  invoiceGenerated,
  general,
}

class NotificationModel {
  final String id;
  final String title;
  final String message;
  final NotificationType type;
  final DateTime createdAt;
  bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.createdAt,
    this.isRead = false,
  });
}

// Global notifications list (replace with actual backend later)
final List<NotificationModel> globalNotifications = [
  NotificationModel(
    id: '1',
    title: 'Booking Confirmed',
    message: 'Your AC Cleaning service has been confirmed for tomorrow at 10:00 AM',
    type: NotificationType.booking,
    createdAt: DateTime.now().subtract(const Duration(hours: 2)),
    isRead: false,
  ),
  NotificationModel(
    id: '2',
    title: 'Special Offer',
    message: 'Get 20% off on all plumbing services this weekend!',
    type: NotificationType.promotion,
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
    isRead: false,
  ),
  NotificationModel(
    id: '3',
    title: 'Service Reminder',
    message: 'Your washing machine cleaning is scheduled for today at 2:00 PM',
    type: NotificationType.reminder,
    createdAt: DateTime.now().subtract(const Duration(hours: 8)),
    isRead: true,
  ),
  NotificationModel(
    id: '4',
    title: 'Service Completed',
    message: 'Your electrical repair service has been completed. Rate your experience!',
    type: NotificationType.general,
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    isRead: true,
  ),
  NotificationModel(
    id: '5',
    title: 'Technician Assigned',
    message: 'Your technician Ahmed has been assigned to your AC Cleaning service',
    type: NotificationType.technicianAssigned,
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
    isRead: false,
  ),
  NotificationModel(
    id: '6',
    title: 'Work Started',
    message: 'Your technician has started working on your service',
    type: NotificationType.workStarted,
    createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
    isRead: false,
  ),
  NotificationModel(
    id: '7',
    title: 'Work Completed',
    message: 'Your service has been completed successfully. Please review and rate!',
    type: NotificationType.workCompleted,
    createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
    isRead: false,
  ),
  NotificationModel(
    id: '8',
    title: 'Invoice Generated',
    message: 'Your invoice is ready. Total amount: SAR 150',
    type: NotificationType.invoiceGenerated,
    createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
    isRead: false,
  ),
];

class NotificationScreen extends StatefulWidget {
  final User user;

  const NotificationScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  void _markAsRead(String notificationId) {
    setState(() {
      final notification = globalNotifications.firstWhere(
            (n) => n.id == notificationId,
      );
      notification.isRead = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in globalNotifications) {
        notification.isRead = true;
      }
    });
  }

  void _deleteNotification(String notificationId) {
    setState(() {
      globalNotifications.removeWhere((n) => n.id == notificationId);
    });
  }

  void _clearAllNotifications() {
    showDialog(
      context: context,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
          title: Text(
            'Clear All Notifications',
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
            ),
          ),
          content: Text(
            'Are you sure you want to clear all notifications? This action cannot be undone.',
            style: TextStyle(
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.red, Colors.redAccent],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    globalNotifications.clear();
                  });
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: const Text('Clear All'),
              ),
            ),
          ],
        );
      },
    );
  }

  IconData _getIconForType(NotificationType type) {
    switch (type) {
      case NotificationType.booking:
        return Icons.calendar_today;
      case NotificationType.promotion:
        return Icons.local_offer;
      case NotificationType.reminder:
        return Icons.access_time;
      case NotificationType.payment:
        return Icons.payment;
      case NotificationType.general:
        return Icons.notifications;
      case NotificationType.technicianAssigned:
        return Icons.person_add;
      case NotificationType.workStarted:
        return Icons.play_circle_outline;
      case NotificationType.workCompleted:
        return Icons.check_circle_outline;
      case NotificationType.invoiceGenerated:
        return Icons.receipt_long;
    }
  }

  Color _getColorForType(NotificationType type) {
    switch (type) {
      case NotificationType.booking:
        return Colors.blue;
      case NotificationType.promotion:
        return Colors.orange;
      case NotificationType.reminder:
        return Colors.purple;
      case NotificationType.payment:
        return Colors.green;
      case NotificationType.general:
        return Colors.grey;
      case NotificationType.technicianAssigned:
        return Colors.teal;
      case NotificationType.workStarted:
        return Colors.indigo;
      case NotificationType.workCompleted:
        return Colors.green;
      case NotificationType.invoiceGenerated:
        return Colors.deepPurple;
    }
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  int get _unreadCount => globalNotifications.where((n) => !n.isRead).length;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0F172A) : const Color(0xFFF8F9FA);
    final cardColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subtitleColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: cardColor,
        foregroundColor: textColor,
        elevation: 0,
        actions: [
          if (globalNotifications.isNotEmpty && _unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: const Text(
                'Mark all read',
                style: TextStyle(
                  color: Color(0xFF6B5B9A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          if (globalNotifications.isNotEmpty)
            PopupMenuButton(
              icon: Icon(Icons.more_vert, color: textColor),
              color: cardColor,
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: _clearAllNotifications,
                  child: Row(
                    children: [
                      const Icon(Icons.delete_sweep, color: Colors.red),
                      const SizedBox(width: 8),
                      Text(
                        'Clear All',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: globalNotifications.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF6B5B9A).withOpacity(0.1),
                    const Color(0xFF6B5B9A).withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none,
                size: 80,
                color: Color(0xFF6B5B9A),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Notifications',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You\'re all caught up!',
              style: TextStyle(
                fontSize: 16,
                color: subtitleColor,
              ),
            ),
          ],
        ),
      )
          : Column(
        children: [
          if (_unreadCount > 0)
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFF6B5B9A).withOpacity(0.1),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF6B5B9A), Color(0xFF7C3AED)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$_unreadCount New',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'You have $_unreadCount unread notification${_unreadCount > 1 ? 's' : ''}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: globalNotifications.length,
              itemBuilder: (context, index) {
                final notification = globalNotifications[index];
                return Dismissible(
                  key: Key(notification.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  onDismissed: (direction) {
                    _deleteNotification(notification.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Notification deleted'),
                        backgroundColor: Colors.red,
                        behavior: SnackBarBehavior.floating,
                        action: SnackBarAction(
                          label: 'Undo',
                          textColor: Colors.white,
                          onPressed: () {
                            setState(() {
                              globalNotifications.insert(index, notification);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: notification.isRead
                          ? cardColor
                          : (isDark
                          ? const Color(0xFF6B5B9A).withOpacity(0.1)
                          : const Color(0xFF6B5B9A).withOpacity(0.05)),
                      borderRadius: BorderRadius.circular(16),
                      border: notification.isRead
                          ? null
                          : Border.all(
                        color: const Color(0xFF6B5B9A).withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(isDark ? 0.3 : 0.08),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          if (!notification.isRead) {
                            _markAsRead(notification.id);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: _getColorForType(notification.type)
                                      .withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  _getIconForType(notification.type),
                                  color: _getColorForType(notification.type),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            notification.title,
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: notification.isRead
                                                  ? FontWeight.w600
                                                  : FontWeight.bold,
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                        if (!notification.isRead)
                                          Container(
                                            width: 8,
                                            height: 8,
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xFF6B5B9A),
                                                  Color(0xFF7C3AED)
                                                ],
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      notification.message,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: subtitleColor,
                                        height: 1.4,
                                      ),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.access_time,
                                          size: 14,
                                          color: subtitleColor,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          _getTimeAgo(notification.createdAt),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: subtitleColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
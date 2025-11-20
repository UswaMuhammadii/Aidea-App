import 'package:flutter/material.dart';
import '../../gen_l10n/app_localizations.dart';
List<Map<String, dynamic>> globalNotifications = [];
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {

  int _unreadCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final l10n = AppLocalizations.of(context)!;
      if (globalNotifications.isEmpty) {
        globalNotifications.addAll(getLocalizedNotifications(l10n));
        setState(() {});
      }
    });
  }

  List<Map<String, dynamic>> getLocalizedNotifications(AppLocalizations l10n) {
    return [
      {
        'title': l10n.newNotification,
        'message': l10n.youHaveUnreadNotificationsSingular,
        'date': DateTime.now().subtract(const Duration(minutes: 3)),
        'read': false,
      },
    ];
  }

  String _getTimeAgo(DateTime dateTime, AppLocalizations l10n) {
    final difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return l10n.timeAgoJustNow;
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return minutes == 1
          ? l10n.timeAgoMinutesAgo.replaceAll('{count}', '1')
          : l10n.timeAgoMinutesAgoPlural.replaceAll('{count}', minutes.toString());
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return hours == 1
          ? l10n.timeAgoHoursAgo.replaceAll('{count}', '1')
          : l10n.timeAgoHoursAgoPlural.replaceAll('{count}', hours.toString());
    } else if (difference.inDays < 7) {
      final days = difference.inDays;
      return days == 1
          ? l10n.timeAgoDaysAgo.replaceAll('{count}', '1')
          : l10n.timeAgoDaysAgoPlural.replaceAll('{count}', days.toString());
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1
          ? l10n.timeAgoWeeksAgo.replaceAll('{count}', '1')
          : l10n.timeAgoWeeksAgoPlural.replaceAll('{count}', weeks.toString());
    } else {
      final months = (difference.inDays / 30).floor();
      return months == 1
          ? l10n.timeAgoMonthsAgo.replaceAll('{count}', '1')
          : l10n.timeAgoMonthsAgoPlural.replaceAll('{count}', months.toString());
    }
  }

  void _clearNotifications() async {
    final l10n = AppLocalizations.of(context)!;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.clearAll),
        content: Text(l10n.areYouSureYouWantToClearAllNotifications),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(l10n.cancel)),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(l10n.clearAll)),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        globalNotifications.clear();
        _unreadCount = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.notifications),
        actions: [
          if (globalNotifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _clearNotifications,
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: globalNotifications.length,
        itemBuilder: (context, index) {
          final item = globalNotifications[index];
          final timeAgo = _getTimeAgo(item['date'], l10n);

          return ListTile(
            title: Text(item['title']),
            subtitle: Text("${item['message']} • $timeAgo"),
          );
        },
      ),
      floatingActionButton: _unreadCount > 0
          ? FloatingActionButton(
        child: Text('$_unreadCount ${l10n.newNotification}'),
        onPressed: () {},
      )
          : null,
    );
  }
}

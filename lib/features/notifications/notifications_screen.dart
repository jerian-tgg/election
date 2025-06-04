import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'id': '1',
      'title': 'Election Reminder',
      'message': 'Student Council Election starts in 1 hour',
      'time': '10 minutes ago',
      'type': 'reminder',
      'isRead': false,
    },
    {
      'id': '2',
      'title': 'Vote Confirmation',
      'message': 'Your vote for Class Representative has been recorded',
      'time': '2 hours ago',
      'type': 'confirmation',
      'isRead': true,
    },
    {
      'id': '3',
      'title': 'Election Results',
      'message': 'Results for Department Council Election are now available',
      'time': '1 day ago',
      'type': 'results',
      'isRead': true,
    },
    {
      'id': '4',
      'title': 'New Candidate',
      'message': 'A new candidate has been added to Student Council Election',
      'time': '2 days ago',
      'type': 'update',
      'isRead': true,
    },
  ];

  void _markAsRead(String notificationId) {
    setState(() {
      final notification = _notifications.firstWhere((n) => n['id'] == notificationId);
      notification['isRead'] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in _notifications) {
        notification['isRead'] = true;
      }
    });
  }

  void _clearAllNotifications() {
    setState(() {
      _notifications.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (_notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.done_all),
              onPressed: _markAllAsRead,
              tooltip: 'Mark all as read',
            ),
          if (_notifications.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: _clearAllNotifications,
              tooltip: 'Clear all notifications',
            ),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView.separated(
              padding: const EdgeInsets.all(AppTheme.spacingL),
              itemCount: _notifications.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationItem(notification);
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 64,
            color: AppTheme.textSecondaryColor,
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'No Notifications',
            style: AppTheme.headingStyle,
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            'You\'re all caught up!',
            style: AppTheme.bodyStyle.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem(Map<String, dynamic> notification) {
    return Dismissible(
      key: Key(notification['id']),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppTheme.spacingL),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        setState(() {
          _notifications.removeWhere((n) => n['id'] == notification['id']);
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4),
        elevation: notification['isRead'] ? 0 : 1,
        color: notification['isRead'] ? null : AppTheme.primaryColor.withOpacity(0.05),
        child: InkWell(
          onTap: () {
            if (!notification['isRead']) {
              _markAsRead(notification['id']);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacingM),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNotificationIcon(notification['type']),
                const SizedBox(width: AppTheme.spacingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification['title'],
                              style: AppTheme.bodyStyle.copyWith(
                                fontWeight: notification['isRead'] ? FontWeight.normal : FontWeight.bold,
                              ),
                            ),
                          ),
                          if (!notification['isRead'])
                            IconButton(
                              icon: const Icon(Icons.circle),
                              color: AppTheme.primaryColor,
                              iconSize: 12,
                              onPressed: () => _markAsRead(notification['id']),
                            ),
                        ],
                      ),
                      const SizedBox(height: AppTheme.spacingXS),
                      Text(
                        notification['message'],
                        style: AppTheme.bodyStyle,
                      ),
                      const SizedBox(height: AppTheme.spacingXS),
                      Text(
                        notification['time'],
                        style: AppTheme.captionStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationIcon(String type) {
    IconData icon;
    Color color;

    switch (type) {
      case 'reminder':
        icon = Icons.alarm;
        color = Colors.orange;
        break;
      case 'confirmation':
        icon = Icons.check_circle;
        color = Colors.green;
        break;
      case 'results':
        icon = Icons.bar_chart;
        color = Colors.blue;
        break;
      case 'update':
        icon = Icons.update;
        color = Colors.purple;
        break;
      default:
        icon = Icons.notifications;
        color = AppTheme.primaryColor;
    }

    return CircleAvatar(
      backgroundColor: color.withOpacity(0.1),
      child: Icon(
        icon,
        color: color,
        size: 20,
      ),
    );
  }
} 
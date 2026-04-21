import 'package:flutter/material.dart';

enum NotificationType { horoscope, match, connect }

class NotificationItem {
  final String avatarUrl;
  final String title;
  final String? subtitle;
  final String time;
  final NotificationType type;
  final bool isRead;

  const NotificationItem({
    required this.avatarUrl,
    required this.title,
    this.subtitle,
    required this.time,
    required this.type,
    this.isRead = false,
  });
}

final _todayItems = [
  const NotificationItem(
    avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
    title: 'Virgo Daily Horoscope',
    subtitle: 'Your sun sign predictions : Love, Career, health & money. Find out now!',
    time: '2m',
    type: NotificationType.horoscope,
  ),
  const NotificationItem(
    avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
    title: 'Contracts! You matched with Mayur G.',
    time: '3h',
    type: NotificationType.match,
  ),
  const NotificationItem(
    avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
    title: 'Mayur G. has accepted your request to connect.',
    time: '3h',
    type: NotificationType.connect,
  ),
];

final _earlierItems = [
  const NotificationItem(
    avatarUrl: 'https://randomuser.me/api/portraits/men/45.jpg',
    title: 'Himanshu D and 3 other has accepted your request to connect.',
    time: '1d',
    type: NotificationType.connect,
    isRead: true,
  ),
  const NotificationItem(
    avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
    title: 'Contracts! You matched with Mayur G.',
    time: '2d',
    type: NotificationType.match,
    isRead: true,
  ),
  const NotificationItem(
    avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
    title: 'Mayur G. has accepted your request to connect.',
    time: '3d',
    type: NotificationType.connect,
    isRead: true,
  ),
  const NotificationItem(
    avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
    title: 'Mayur G. has accepted your request to connect.',
    time: '3d',
    type: NotificationType.connect,
    isRead: true,
  ),
];


const Color kPrimary = Color(0xFFAD2F6D);
const Color kPrimaryLight = Color(0xFFFDF0F7);
const Color kSubtext = Color(0xFF888888);
const Color kDivider = Color(0xFFE8E8E8);
const Color kUnreadBg = Color(0xFFFDF0F7);
const Color kReadBg = Colors.white;



class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            /// Top App Bar
            Container(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    "Notification",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            /// Notification List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 8),
                children: [
                  const _SectionHeader(label: "Today"),

                  ..._todayItems.map(
                        (item) => _NotificationTile(item: item),
                  ),

                  const SizedBox(height: 14),

                  const _SectionHeader(label: "Earlier"),

                  ..._earlierItems.map(
                        (item) => _NotificationTile(item: item),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String label;

  const _SectionHeader({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xff7D7D7D),
        ),
      ),
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final NotificationItem item;

  const _NotificationTile({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final bool isHoroscope =
        item.type == NotificationType.horoscope;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 6,
      ),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: item.isRead
            ? Colors.white
            : const Color(0xffFFF6FB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Avatar
          CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(item.avatarUrl),
          ),

          const SizedBox(width: 12),

          /// Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title + Time
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _buildTitle(item.title),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      item.time,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xffA0A0A0),
                      ),
                    ),
                  ],
                ),

                /// Subtitle
                if (item.subtitle != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    item.subtitle!,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Color(0xff6D6D6D),
                    ),
                  ),
                ],

                const SizedBox(height: 10),

                /// Button
                _ActionButton(
                  text: isHoroscope
                      ? "Read More"
                      : item.type == NotificationType.match
                      ? "Connect"
                      : "View Profile",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        height: 1.4,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;

  const _ActionButton({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffC12A74),
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Color(0xffC12A74),
        ),
      ),
    );
  }
}
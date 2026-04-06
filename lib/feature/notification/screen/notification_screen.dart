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

// ─────────────────────────────────────────────
// Constants
// ─────────────────────────────────────────────

const Color kPrimary = Color(0xFFAD2F6D);
const Color kPrimaryLight = Color(0xFFFDF0F7);
const Color kSubtext = Color(0xFF888888);
const Color kDivider = Color(0xFFE8E8E8);
const Color kUnreadBg = Color(0xFFFDF0F7);
const Color kReadBg = Colors.white;

// ─────────────────────────────────────────────
// Screen
// ─────────────────────────────────────────────

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── App Bar ───────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);

                    },
                    child: const Icon(Icons.arrow_back_ios,
                        size: 20, color: Colors.black87),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Notification',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // ── List ─────────────────────────────
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  _SectionHeader(label: 'Today'),
                  ..._todayItems.map((item) => _NotificationTile(item: item)),
                  const SizedBox(height: 12),
                  _SectionHeader(label: 'Earlier'),
                  ..._earlierItems.map((item) => _NotificationTile(item: item)),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomBar(),
    );
  }
}

// ─────────────────────────────────────────────
// Section Header
// ─────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  final String label;
  const _SectionHeader({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 6),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: kSubtext,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Notification Tile
// ─────────────────────────────────────────────

class _NotificationTile extends StatelessWidget {
  final NotificationItem item;
  const _NotificationTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final isHoroscope = item.type == NotificationType.horoscope;
    final bgColor = item.isRead ? kReadBg : kUnreadBg;

    return Container(
      color: bgColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                _Avatar(url: item.avatarUrl),
                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title row
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
                              color: kSubtext,
                            ),
                          ),
                        ],
                      ),

                      // Subtitle
                      if (item.subtitle != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle!,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF555555),
                            height: 1.4,
                          ),
                        ),
                      ],

                      // Read More button for horoscope
                      if (isHoroscope) ...[
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: kPrimary, width: 1.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            'Read More',
                            style: TextStyle(
                              color: kPrimary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: kDivider),
        ],
      ),
    );
  }

  Widget _buildTitle(String title) {
    // Bold names (Mayur G., Himanshu D, 3 other)
    final boldPatterns = [
      'Mayur G.',
      'Himanshu D',
      '3 other',
    ];

    List<TextSpan> spans = [];
    String remaining = title;

    while (remaining.isNotEmpty) {
      int matchStart = -1;
      String? matchedPattern;

      for (final pattern in boldPatterns) {
        final idx = remaining.indexOf(pattern);
        if (idx != -1 && (matchStart == -1 || idx < matchStart)) {
          matchStart = idx;
          matchedPattern = pattern;
        }
      }

      if (matchStart == -1 || matchedPattern == null) {
        spans.add(TextSpan(text: remaining));
        break;
      }

      if (matchStart > 0) {
        spans.add(TextSpan(text: remaining.substring(0, matchStart)));
      }

      spans.add(TextSpan(
        text: matchedPattern,
        style: const TextStyle(fontWeight: FontWeight.w700),
      ));

      remaining = remaining.substring(matchStart + matchedPattern.length);
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black87,
          height: 1.4,
        ),
        children: spans,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Avatar
// ─────────────────────────────────────────────

class _Avatar extends StatelessWidget {
  final String url;
  const _Avatar({required this.url});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 26,
      backgroundColor: Colors.grey[200],
      backgroundImage: NetworkImage(url),
    );
  }
}

// ─────────────────────────────────────────────
// Bottom Nav Bar (Android style)
// ─────────────────────────────────────────────

class _BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black54),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.circle, color: Colors.black54, size: 20),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.stop, color: Colors.black54),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
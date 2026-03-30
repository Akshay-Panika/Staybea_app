import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final List<Map<String, dynamic>> _data = [
  {
    "profileImage": "assets/profile/profile1.jpg",
    "name": "Mitali",
    "age": "23",
    "height": "5' 6\"",
    "community": "Maratha",
    "location": "Pune",
    "rangeKM": "3.5 KM",
    "profession": "Software Engineer",
    "matchPercent": 82,
    "isOnline": true,
    "images": [
      "https://picsum.photos/500/900?random=11",
      "https://picsum.photos/500/900?random=12",
      "https://picsum.photos/500/900?random=13",
    ],
  },
  {
    "profileImage": "assets/profile/profile2.jpg",
    "name": "Rini",
    "age": "21",
    "height": "5' 4\"",
    "community": "Bengali Brahmin",
    "location": "Mumbai",
    "rangeKM": "2.8 KM",
    "profession": "Fashion Designer",
    "matchPercent": 74,
    "isOnline": true,
    "images": [
      "https://picsum.photos/500/900?random=21",
      "https://picsum.photos/500/900?random=22",
      "https://picsum.photos/500/900?random=23",
    ],
  },
  {
    "profileImage": "assets/profile/profile3.jpg",
    "name": "Lena",
    "age": "26",
    "height": "5' 7\"",
    "community": "Goan Catholic",
    "location": "Goa",
    "rangeKM": "5.0 KM",
    "profession": "Doctor",
    "matchPercent": 68,
    "isOnline": false,
    "images": [
      "https://picsum.photos/500/900?random=31",
      "https://picsum.photos/500/900?random=32",
      "https://picsum.photos/500/900?random=33",
    ],
  },
  {
    "profileImage": "assets/profile/profile4.jpg",
    "name": "Tashi",
    "age": "24",
    "height": "5' 5\"",
    "community": "Tibetan Buddhist",
    "location": "Dharamshala",
    "rangeKM": "4.2 KM",
    "profession": "Teacher",
    "matchPercent": 91,
    "isOnline": true,
    "images": [
      "https://picsum.photos/500/900?random=41",
      "https://picsum.photos/500/900?random=42",
      "https://picsum.photos/500/900?random=43",
    ],
  },
];

// ─── Main Screen ─────────────────────────────────────────────────────────────

class DateToMarryScreen extends StatefulWidget {
  const DateToMarryScreen({super.key});

  @override
  State<DateToMarryScreen> createState() => _DateToMarryScreenState();
}

class _DateToMarryScreenState extends State<DateToMarryScreen> {
  int _currentIndex = 0;
  int _selectedTab = 1; // 0=Search, 1=New, 2=Daily25, 3=My

  // Per-card state
  late List<int> _photoIndex;
  late List<bool> _liked;

  @override
  void initState() {
    super.initState();
    _photoIndex = List.filled(_data.length, 0);
    _liked = List.filled(_data.length, false);
  }

  void _nextCard() {
    if (_currentIndex < _data.length - 1) {
      setState(() => _currentIndex++);
    }
  }

  void _prevCard() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    final profile = _data[_currentIndex];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(data: _data),
            _FilterTabs(
              selected: _selectedTab,
              onTap: (i) => setState(() => _selectedTab = i),
            ),
            Expanded(
              child: _ProfileCard(
                key: ValueKey(_currentIndex),
                profile: profile,
                photoIndex: _photoIndex[_currentIndex],
                isLiked: _liked[_currentIndex],
                onPhotoTap: (side) {
                  setState(() {
                    final imgs = (profile['images'] as List).length;
                    if (side == 'right') {
                      _photoIndex[_currentIndex] =
                          (_photoIndex[_currentIndex] + 1) % imgs;
                    } else {
                      _photoIndex[_currentIndex] =
                          (_photoIndex[_currentIndex] - 1 + imgs) % imgs;
                    }
                  });
                },
                onLike: () => setState(() {
                  _liked[_currentIndex] = !_liked[_currentIndex];
                }),
                onBack: _prevCard,
                onNext: _nextCard,
                canGoBack: _currentIndex > 0,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

// ─── Top Bar ─────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final List<Map<String, dynamic>> data;
  const _TopBar({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // Avatar with online indicator
          Stack(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Colors.grey.shade300,
                backgroundImage:
                const NetworkImage('https://picsum.photos/100/100?random=99'),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          // Notification icons
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined, size: 26),
            color: Colors.black87,
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_active_outlined, size: 26),
                color: Colors.black87,
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE91E63),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Filter Tabs ─────────────────────────────────────────────────────────────

class _FilterTabs extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onTap;
  const _FilterTabs({required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final tabs = ['Search', 'New (2090)', 'Daily 25', 'My'];
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          // Filter icon button
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Icon(Icons.tune, size: 18, color: Colors.black87),
            ),
          ),
          ...List.generate(tabs.length, (i) {
            final active = selected == i;
            return GestureDetector(
              onTap: () => onTap(i),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: active ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: active
                      ? Border.all(color: const Color(0xFFE91E63), width: 1.5)
                      : Border.all(color: Colors.grey.shade300),
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[i],
                  style: TextStyle(
                    color: active ? const Color(0xFFE91E63) : Colors.black54,
                    fontWeight:
                    active ? FontWeight.w600 : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ─── Profile Card ─────────────────────────────────────────────────────────────

class _ProfileCard extends StatelessWidget {
  final Map<String, dynamic> profile;
  final int photoIndex;
  final bool isLiked;
  final void Function(String side) onPhotoTap;
  final VoidCallback onLike;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final bool canGoBack;

  const _ProfileCard({
    super.key,
    required this.profile,
    required this.photoIndex,
    required this.isLiked,
    required this.onPhotoTap,
    required this.onLike,
    required this.onBack,
    required this.onNext,
    required this.canGoBack,
  });

  @override
  Widget build(BuildContext context) {
    final images = profile['images'] as List<String>;
    final matchPercent = profile['matchPercent'] as int;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // ── Background Photo ──────────────────────────────────────────
            Image.network(
              images[photoIndex],
              fit: BoxFit.cover,
              loadingBuilder: (_, child, progress) => progress == null
                  ? child
                  : Container(
                color: Colors.grey.shade300,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),

            // ── Gradient overlay ─────────────────────────────────────────
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.45, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.85),
                    ],
                  ),
                ),
              ),
            ),

            // ── Photo tap zones ───────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => onPhotoTap('left'),
                    child: const SizedBox.expand(),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onPhotoTap('right'),
                    child: const SizedBox.expand(),
                  ),
                ),
              ],
            ),

            // ── Photo indicator dots ──────────────────────────────────────
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(images.length, (i) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == photoIndex ? 20 : 6,
                    height: 4,
                    decoration: BoxDecoration(
                      color: i == photoIndex
                          ? Colors.white
                          : Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
              ),
            ),

            // ── Back button ───────────────────────────────────────────────
            Positioned(
              top: 12,
              left: 12,
              child: GestureDetector(
                onTap: canGoBack ? onBack : null,
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.replay,
                    color: canGoBack
                        ? Colors.white
                        : Colors.white.withOpacity(0.3),
                    size: 20,
                  ),
                ),
              ),
            ),

            // ── Menu button ───────────────────────────────────────────────
            Positioned(
              top: 12,
              right: 12,
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),

            // ── Bottom info ───────────────────────────────────────────────
            Positioned(
              left: 16,
              right: 72,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Name + Age + Match %
                  Row(
                    children: [
                      // Online dot
                      if (profile['isOnline'] == true)
                        Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(right: 6),
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                        ),
                      Text(
                        '${profile['name']}  ${profile['age']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Match badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.4), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.verified,
                                color: Color(0xFF42A5F5), size: 14),
                            const SizedBox(width: 3),
                            Text(
                              '$matchPercent%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Height • Community
                  Text(
                    "${profile['height']} • ${profile['community']}",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Location
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          color: Colors.white.withOpacity(0.8), size: 15),
                      const SizedBox(width: 3),
                      Text(
                        "${profile['location']} • ${profile['rangeKM']} away",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Profession
                  Row(
                    children: [
                      Icon(Icons.work_outline,
                          color: Colors.white.withOpacity(0.8), size: 15),
                      const SizedBox(width: 3),
                      Text(
                        profile['profession'] as String,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.85),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── Like / Dislike / Super-like buttons ───────────────────────
            Positioned(
              right: 14,
              bottom: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Like heart
                  GestureDetector(
                    onTap: () {
                      onLike();
                      onNext();
                    },
                    // onTap: onLike,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: isLiked
                            ? const Color(0xFFE91E63)
                            : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Icon(
                        isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked ? Colors.white : const Color(0xFFE91E63),
                        size: 26,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Super-like star
                  // GestureDetector(
                  //   onTap: onNext,
                  //   child: Container(
                  //     width: 40,
                  //     height: 40,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white.withOpacity(0.9),
                  //       shape: BoxShape.circle,
                  //       boxShadow: [
                  //         BoxShadow(
                  //           color: Colors.black.withOpacity(0.2),
                  //           blurRadius: 6,
                  //         )
                  //       ],
                  //     ),
                  //     child: const Icon(Icons.star,
                  //         color: Color(0xFFFFB300), size: 22),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
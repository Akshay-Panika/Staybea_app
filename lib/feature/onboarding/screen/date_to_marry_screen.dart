import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import 'package:staybea_app/feature/profile/screen/profile_screen.dart';

import '../../get_boost/screen/get_boost_screen.dart';
import '../../notification/screen/notification_screen.dart';
import 'd2m_boost_screen.dart';
import 'marriage_profile_screen.dart';

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


class DateToMarryScreen extends StatefulWidget {
  const DateToMarryScreen({super.key});

  @override
  State<DateToMarryScreen> createState() => _DateToMarryScreenState();
}

class _DateToMarryScreenState extends State<DateToMarryScreen> {
  int _selectedTab = 1;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(data: _data),
            _FilterTabs(
              selected: _selectedTab,
              onTap: (i) => setState(() => _selectedTab = i),
            ),
            10.height,
            Expanded(child: _ProfileCard(data: _data,)),

          ],
        ),
      ),
    );
  }
}


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
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),));
                },
                icon: Icon(Icons.menu,size: 30,),
                // child: CircleAvatar(
                //   radius: 22,
                //   backgroundColor: Colors.grey.shade300,
                //   backgroundImage:
                //   const NetworkImage('https://picsum.photos/100/100?random=99'),
                // ),
              ),
              // Positioned(
              //   right: 0,
              //   bottom: 0,
              //   child: Container(
              //     width: 12,
              //     height: 12,
              //     decoration: BoxDecoration(
              //       color: const Color(0xFF4CAF50),
              //       shape: BoxShape.circle,
              //       border: Border.all(color: Colors.white, width: 2),
              //     ),
              //   ),
              // ),
            ],
          ),
          const Spacer(),
          // Notification icons
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => D2mBoostScreen(),));
            },
            icon:  Icon(Icons.rocket_launch_outlined, size: 26),
            color: Colors.black87,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));

            },
            icon: const Icon(Icons.notifications_active_outlined, size: 26),
            color: Colors.black87,
          ),
        ],
      ),
    );
  }
}

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
                    fontSize: 14
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

class _ProfileCard extends StatefulWidget {
  final List<Map<String, dynamic>> data;
   const _ProfileCard({super.key, required this.data});

  @override
  State<_ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<_ProfileCard> {
  int currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: widget.data.length,
      scrollDirection: Axis.vertical, // profile swipe
      itemBuilder: (context, index) {
        final profile = widget.data[index];
        final List images = profile['images'];
        final heroTag = "profile_${profile['name']}";
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MarriageProfileScreen(
              profile: profile,
              heroTag: heroTag,
            ),));
          },
          child: Stack(
            children: [
              Hero(
                tag: heroTag,
                child: PageView.builder(
                  itemCount: images.length,
                  scrollDirection: Axis.horizontal, // image swipe
                  onPageChanged: (imgIndex) {
                    setState(() {
                      currentImageIndex = imgIndex;
                    });
                  },
                  itemBuilder: (context, imgIndex) {
                    return Image.network(
                      images[imgIndex],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    );
                  },
                ),
              ),

              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔥 Name + Match %
                      Row(
                        children: [
                          // 🟢 Online Dot
                          Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.only(right: 6),
                            decoration: BoxDecoration(
                              color: profile['isOnline'] ? Colors.green : Colors.grey,
                              shape: BoxShape.circle,
                            ),
                          ),

                          // Name + Age
                          Text(
                            "${profile['name']} ${profile['age']}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          10.width,

                          Container(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              spacing: 10,
                              children: [
                                Icon(Icons.verified,color: Colors.blue,size: 16,),
                                Text(
                                  "${profile['matchPercent']}%",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // 📏 Height + Community
                      Text(
                        "${profile['height']} • ${profile['community']}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                        ),
                      ),

                      const SizedBox(height: 6),

                      // 📍 Location + Distance
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            "${profile['location']} • ${profile['rangeKM']} away",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),

                      // 💼 Profession
                      Row(
                        children: [
                          const Icon(Icons.work_outline,
                              color: Colors.white, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            profile['profession'],
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 20,
                bottom: 20,
                child: InkWell(
                  onTap: () => _showConversationSheet(context),
                  child: Container(
                    height: 55,
                    width: 55,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.favorite, color: Colors.red, size: 28),
                  ),
                ),
              ),

              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Row(
                  children: List.generate(images.length, (index) {
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 4,
                        decoration: BoxDecoration(
                          color: index == currentImageIndex
                              ? Colors.white
                              : Colors.white.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Positioned(
                  top: 20,right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black54,
                      border: Border.all(color: Colors.white,width: 1)
                    ),
                child: IconButton(onPressed: () {
                  _showMoreOptionsSheet(context);
                }, icon: Icon(Icons.more_vert, color: Colors.white,)),)),
            ],
          ),
        );
      },
    );
  }
}


void _showConversationSheet(BuildContext context) {
  final TextEditingController messageController = TextEditingController();
  bool _superConnect = false;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: _superConnect
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  50.height,
                  const Text(
                    "You're one step closer.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Your connection sent.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  50.height,
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  50.height,
                ],
              )
                  : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const Text(
                    "Start a conversation",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Send a message to express your interest.",
                    style: TextStyle(fontSize: 13, color: Colors.black45),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: messageController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Write a short message...",
                      hintStyle: const TextStyle(color: Colors.black38),
                      contentPadding: const EdgeInsets.all(14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                        const BorderSide(color: Color(0xFFC2185B)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      // TODO: open message picker
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Choose Message",
                          style: TextStyle(
                            color: Color(0xFFC2185B),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.chevron_right,
                            color: Color(0xFFC2185B), size: 18),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _superConnect = true; // ✅ update state
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFC2185B),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                                icon: const Icon(Icons.favorite_border,
                                    color: Colors.white, size: 18),
                                label: const Text(
                                  "Super Connect",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: -8,
                              right: 10,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFC2185B),
                                  shape: BoxShape.circle,
                                  border: Border.fromBorderSide(
                                    BorderSide(color: Colors.white, width: 1.5),
                                  ),
                                ),
                                child: const Text(
                                  "20",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            setState(() {
                              _superConnect = true; // ✅ update state
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                                color: Color(0xFFC2185B), width: 1.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding:
                            const EdgeInsets.symmetric(vertical: 14),
                          ),
                          icon: const Icon(Icons.favorite_border,
                              color: Color(0xFFC2185B), size: 18),
                          label: const Text(
                            "Connect",
                            style: TextStyle(
                              color: Color(0xFFC2185B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
void _showMoreOptionsSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            _moreOptionTile(
              context,
              icon: Icons.share_outlined,
              label: "Share Profile",
              onTap: () {
                Navigator.pop(context);
                // TODO: share logic
              },
            ),

            _moreOptionTile(
              context,
              icon: Icons.star_border_outlined,
              label: "Add to shortlist",
              onTap: () {
                Navigator.pop(context);
                // TODO: shortlist logic
              },
            ),

            _moreOptionTile(
              context,
              icon: Icons.visibility_off_outlined,
              label: "Hide this profile",
              onTap: () {
                Navigator.pop(context);
                // TODO: hide logic
              },
            ),

            _moreOptionTile(
              context,
              icon: Icons.block_outlined,
              label: "Block this profile",
              onTap: () {
                Navigator.pop(context);
                // TODO: block logic
              },
            ),

            _moreOptionTile(
              context,
              icon: Icons.warning_amber_outlined,
              label: "Report this profile",
              onTap: () {
                Navigator.pop(context);
                // TODO: report logic
              },
            ),

            const SizedBox(height: 10),
          ],
        ),
      );
    },
  );
}

Widget _moreOptionTile(
    BuildContext context, {
      required IconData icon,
      required String label,
      required VoidCallback onTap,
    }) {
  return InkWell(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
      child: Row(
        children: [
          Icon(icon, size: 22, color: Colors.black54),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}
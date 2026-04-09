import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import 'package:staybea_app/feature/profile/screen/profile_screen.dart';

import '../../get_boost/screen/get_boost_screen.dart';
import '../../notification/screen/notification_screen.dart';
import 'marriage_profile_screen.dart';
import 'mature_connection_profile.dart';

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


class MatureConnection extends StatefulWidget {
  const MatureConnection({super.key});

  @override
  State<MatureConnection> createState() => _MatureConnectionState();
}

class _MatureConnectionState extends State<MatureConnection> {

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: appSize.height*0.08,
        backgroundColor: Colors.white,
        elevation: 0,
        leading:  Padding(
          padding: EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),));
            },
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=a1'),
            ),
          ),
        ),
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Daily 25",
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
              ),
            ),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.tune, color: Colors.black54)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => GetBoostScreen(),));
          }, icon: const Icon(Icons.rocket_launch_outlined, color: Colors.black54)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
          }, icon: const Icon(Icons.notifications_active_outlined, color: Colors.black54)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: _ProfileCard(data: _data,appSize: appSize,)),

          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final AppSize appSize;
  const _ProfileCard({super.key, required this.data, required this.appSize,});

  @override
  State<_ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<_ProfileCard> {
  int currentImageIndex = 0;
  bool _isFavorite = false;
  bool _showHeart = false;


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
            Navigator.push(context, MaterialPageRoute(builder: (context) => MatureConnectionProfile(
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
                  padding: const EdgeInsets.only(bottom: 16,left: 10,right: 10),
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
                  child: Row(
                     crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
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

                          // // 📏 Height + Community
                          // Text(
                          //   "${profile['height']} • ${profile['community']}",
                          //   style: const TextStyle(
                          //       color: Colors.white,
                          //       fontSize: 14,
                          //       fontWeight: FontWeight.w500
                          //   ),
                          // ),

                          // const SizedBox(height: 6),

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

                          // const SizedBox(height: 6),

                          // 💼 Profession
                          Row(
                            children: [
                              const Icon(Icons.search,
                                  color: Colors.white, size: 16),
                              const SizedBox(width: 4),
                              Text('Looking for Life Partner',
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

                      Row(
                        spacing: 16,
                        children: [
                          InkWell(
                            onTap: () => _showInterestSheet(context),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child:  Icon(Icons.heart_broken, color:AppColors.secondary,size:30,),
                            ),
                          ),


                          InkWell(
                            onTap: () {
                              setState(() {
                                _isFavorite = !_isFavorite;
                                _showHeart = true;
                              });

                              Future.delayed(const Duration(milliseconds: 600), () {
                                if (mounted) {
                                  setState(() {
                                    _showHeart = false;
                                  });
                                }
                              });
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                transitionBuilder: (child, animation) =>
                                    ScaleTransition(scale: animation, child: child),
                                child: Icon(
                                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                                  key: ValueKey(_isFavorite),
                                  color: _isFavorite ? Colors.red : Colors.grey,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Column(
                  spacing: 10,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
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
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(onPressed: () {
                        _showMoreOptionsSheet(context);
                      }, icon: Icon(Icons.more_vert, color: Colors.black,)),)
                  ],
                ),
              ),


              if (_showHeart)
                Positioned.fill(
                  child: Center(
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.5, end: 1.4),
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutBack,
                      builder: (context, scale, child) {
                        return Transform.scale(
                          scale: scale,
                          child: child,
                        );
                      },
                      child: AnimatedOpacity(
                        opacity: _showHeart ? 1 : 0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOut,
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red.withOpacity(0.9),
                          size: widget.appSize.height * 0.1,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}


void _showInterestSheet(BuildContext context) {
  final TextEditingController messageController = TextEditingController();
  bool isSelectMSGView = false;
  bool isSentSuccess = false; 
  String selectedMessage = "";

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return AnimatedSize(
            duration: const Duration(milliseconds: 500),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                left: 20, right: 20, top: 20,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // --- 1. SUCCESS VIEW (Replace logic) ---
                    if (isSentSuccess) ...[
                      const SizedBox(height: 40),
                      const Text(
                        "You're on step closer.",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text("Your connection sent.", style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 30),
                      const CircleAvatar(
                        radius: 45,
                        backgroundColor: Color(0xFF76D746), // Green color from image
                        child: Icon(Icons.check, color: Colors.white, size: 55),
                      ),
                      const SizedBox(height: 40),
                    ]

                    // --- 2. CHOOSE MESSAGE VIEW ---
                    else if (isSelectMSGView) ...[
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back_ios, size: 20),
                            onPressed: () => setModalState(() => isSelectMSGView = false),
                          ),
                          const Text('Choose message', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            _buildOption(
                              "Hello, I like your profile. Accept my interest if my profile interests you too.",
                              selectedMessage,
                                  (val) => setModalState(() {
                                selectedMessage = val;
                                messageController.text = val;
                                isSelectMSGView = false;
                              }),
                            ),
                            const Divider(height: 1),
                            _buildOption(
                              "hey, would really like to know more about you. Let me know if you'd like to catch up.",
                              selectedMessage,
                                  (val) => setModalState(() {
                                selectedMessage = val;
                                messageController.text = val;
                                isSelectMSGView = false;
                              }),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                    ]

                    // --- 3. MAIN INPUT VIEW ---
                    else ...[
                        const Text('Start a conversation', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        const Text('Send a rose with message & Gift to express your interest.',
                            textAlign: TextAlign.center, style: TextStyle(color: Colors.grey, fontSize: 13)),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: messageController,
                                maxLines: 3,
                                decoration: InputDecoration(
                                  hintText: 'Write a short message...',
                                  fillColor: Colors.grey.shade50,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 20),
                        Column(
                          spacing: 10,
                          children: [
                            TextButton(
                              onPressed: () => setModalState(() => isSelectMSGView = true),
                              child: const Text('Choose Message >', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: BorderRadius.circular(16)
                              ),
                              child: InkWell(
                                onTap: () {
                                  setModalState(() => isSentSuccess = true);
                                  Future.delayed(const Duration(seconds: 1), () {
                                    if (context.mounted) Navigator.pop(context);
                                  });
                                },
                                child: Row(
                                  spacing: 10,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.heart_broken, color: Colors.white,),
                                    Text("Super Connect",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),),
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.white,
                                      child: Text('20',style: TextStyle(fontSize: 10),),)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ],
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}
Widget _buildOption(String text, String selected, Function(String) onSelect) {
  bool isSelected = text == selected;
  return ListTile(
    title: Text(text, style: TextStyle(fontSize: 14, color: isSelected ? Colors.black : Colors.grey.shade600)),
    trailing: Icon(
      isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
      color: isSelected ? const Color(0xFFAC4870) : Colors.grey.shade300,
    ),
    onTap: () => onSelect(text),
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
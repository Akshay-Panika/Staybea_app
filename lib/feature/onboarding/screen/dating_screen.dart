import 'package:flutter/material.dart';
import 'package:staybea_app/feature/onboarding/dating/profile_page.dart';
import 'package:staybea_app/feature/profile/screen/profile_screen.dart';
import '../../../core/utils/app_size.dart';
import '../../get_boost/screen/get_boost_screen.dart';
import '../../notification/screen/notification_screen.dart';
import '../dating/datign_gift.dart';

class DatingScreen extends StatefulWidget {
  const DatingScreen({super.key});

  @override
  State<DatingScreen> createState() => _DatingScreenState();
}

class _DatingScreenState extends State<DatingScreen>
    with SingleTickerProviderStateMixin {
  final bottomNavBarHeight = 80.0;

  int currentIndex = 0;

  Offset position = Offset.zero;
  double angle = 0;

  double likeOpacity = 0;
  double dislikeOpacity = 0;

  List<int> history = [];

  late AnimationController controller;
  late Animation<Offset> animation;

  final List<Map<String, dynamic>> _data = const [
    {
      "name": "Mitali",
      "age": "23",
      "location": "Pune",
      "rangeKM": "3.5 KM",
      "profession": "Software Engineer",
      "matchPercent": 82,
      "isOnline": true,
      "images": ["https://picsum.photos/500/900?random=11"],
    },
    {
      "name": "Rini",
      "age": "21",
      "location": "Mumbai",
      "rangeKM": "2.8 KM",
      "profession": "Fashion Designer",
      "matchPercent": 74,
      "isOnline": true,
      "images": ["https://picsum.photos/500/900?random=21"],
    },
    {
      "name": "Lena",
      "age": "26",
      "location": "Goa",
      "rangeKM": "5.0 KM",
      "profession": "Doctor",
      "matchPercent": 68,
      "isOnline": false,
      "images": ["https://picsum.photos/500/900?random=31"],
    },
    {
      "name": "Tashi",
      "age": "24",
      "location": "Dharamshala",
      "rangeKM": "4.2 KM",
      "profession": "Teacher",
      "matchPercent": 91,
      "isOnline": true,
      "images": ["https://picsum.photos/500/900?random=41"],
    },
  ];

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );

    controller.addListener(() {
      setState(() {
        position = animation.value;
        angle = position.dx * 0.002;
      });
    });
  }

  void startAnimation(Offset endOffset) {
    controller.stop();

    animation = Tween(
      begin: position,
      end: endOffset,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.fastOutSlowIn,
      ),
    );

    controller.forward(from: 0).whenComplete(() {
      controller.reset();
      nextCard();
    });
  }

  void nextCard() {
    if (currentIndex < _data.length - 1) {
      setState(() {
        currentIndex++;
        position = Offset.zero;
        angle = 0;
      });
    }
  }

  void previousCard() {
    if (history.isNotEmpty) {
      setState(() {
        currentIndex = history.removeLast();
        position = Offset.zero;
        angle = 0;
      });
    }
  }

  void resetPosition() {
    controller.stop();

    animation = Tween(
      begin: position,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOutBack,
      ),
    );

    controller.forward(from: 0);
  }

  Widget buildTopCard(AppSize appSize) {
    final profile = _data[currentIndex];
    final isLast = currentIndex == _data.length - 1;

    return GestureDetector(
      onPanUpdate: (details) {
        if (isLast) return;

        setState(() {
          position += details.delta;
          angle = position.dx * 0.002;

          likeOpacity =
          position.dx > 0 ? (position.dx / 150).clamp(0, 1) : 0;
          dislikeOpacity =
          position.dx < 0 ? (-position.dx / 150).clamp(0, 1) : 0;
        });
      },
      onPanEnd: (details) {
        if (isLast) return;

        final velocity = details.velocity.pixelsPerSecond;
        final isFastSwipe = velocity.dx.abs() > 800;

        if (position.dx > 120 || (isFastSwipe && velocity.dx > 0)) {
          history.add(currentIndex);
          startAnimation(Offset(600, position.dy));
        } else if (position.dx < -120 ||
            (isFastSwipe && velocity.dx < 0)) {
          history.add(currentIndex);
          startAnimation(Offset(-600, position.dy));
        } else {
          resetPosition();
        }

        likeOpacity = 0;
        dislikeOpacity = 0;
      },

      child: Transform.translate(
        offset: position,
        child: Transform.rotate(
          angle: angle,
          child: Stack(
            children: [
              /// 👇 ORIGINAL CARD
              buildCard(profile, appSize, isLast),

              /// ❤️ LIKE (ONLY TOP CARD)
              Center(
                child: Opacity(
                  opacity: likeOpacity,
                  child: Transform.scale(
                    scale: 1 + likeOpacity,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.green,
                      size: 100,
                    ),
                  ),
                ),
              ),

              /// ❌ DISLIKE (ONLY TOP CARD)
              Center(
                child: Opacity(
                  opacity: dislikeOpacity,
                  child: Transform.scale(
                    scale: 1 + dislikeOpacity,
                    child: const Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(Map profile, AppSize appSize, bool isLast) {
    return Container(
      // margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        // borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
        image: DecorationImage(
          image: NetworkImage(profile['images'][0]),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Colors.black.withOpacity(0.85),
              Colors.transparent,
              Colors.black.withOpacity(0.2),
            ],
          ),
        ),
        child: Stack(
          children: [
            // /// ❤️ LIKE
            // Center(
            //   child: Opacity(
            //     opacity: likeOpacity,
            //     child: Transform.scale(
            //       scale: 1 + likeOpacity,
            //       child: const Icon(Icons.favorite,
            //           color: Colors.green, size: 100),
            //     ),
            //   ),
            // ),
            //
            // /// ❌ DISLIKE
            // Center(
            //   child: Opacity(
            //     opacity: dislikeOpacity,
            //     child: Transform.scale(
            //       scale: 1 + dislikeOpacity,
            //       child: const Icon(Icons.close,
            //           color: Colors.red, size: 100),
            //     ),
            //   ),
            // ),

            /// TOP
            Positioned(
              top: 12,
              left: 12,
              right: 12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: previousCard,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.25),
                      child: const Icon(Icons.replay,
                          color: Colors.white),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _showMoreOptionsSheet(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(0.25),
                      child: const Icon(Icons.more_vert,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
            ),

            if (isLast)
              const Center(
                child: Text(
                  "No More Profiles",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
              ),

            /// BOTTOM
            Positioned(
              bottom: appSize.height*0.04,
              left: appSize.height*0.02,
              right: appSize.height*0.02,
              child: _profileData(context, profile,appSize),
            ),
          ],
        ),
      ),
    );
  }

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
          }, icon: const Icon(Icons.notifications_none, color: Colors.black54)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height
                  - kToolbarHeight // AppBar height
                  - MediaQuery.of(context).padding.top // status bar
                  - bottomNavBarHeight,
              // height: MediaQuery.of(context).size.height
              //     - kToolbarHeight // AppBar height
              //     - MediaQuery.of(context).padding.top,
              child: Stack(
                children: [
                  if (currentIndex + 1 < _data.length)
                    Transform.scale(
                      scale: 0.95,
                      child: buildCard(
                          _data[currentIndex + 1], appSize, false),
                    ),
                  if (currentIndex < _data.length)
                    buildTopCard(appSize),
                ],
              ),
            ),
        
            ProfilePage()
          ],
        ),
      ),
    );
  }
}

Widget _profileData(BuildContext context,Map<dynamic, dynamic> profile, AppSize appSize){
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (profile['isOnline'])
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                  ),
                Text(
                  "${profile['name']}  ${profile['age']}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: appSize.extraLargeText,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'serif',
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.verified,
                          color: Colors.blue, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "${profile['matchPercent']}%",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: appSize.smallText),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    color: Colors.white, size: 20),
                const SizedBox(width: 4),
                Text(
                  "${profile['location']} • ${profile['rangeKM']}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: appSize.mediumText),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.work_outline,
                    color: Colors.white, size: 20),
                const SizedBox(width: 4),
                Text(
                  profile['profession'],
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: appSize.mediumText),
                ),
              ],
            ),
          ],
        ),
      ),
      InkWell(
        onTap: () => _showInterestSheet(context),
        child: Container(
          height: appSize.height * 0.06,
          width: appSize.height * 0.06,
          padding: EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4))
            ],
          ),
          child: Image.asset('assets/image/rose-icon.png'),
        ),
      ),
    ],
  );

}

void _showInterestSheet(BuildContext context) {
  final TextEditingController messageController = TextEditingController();
  bool isSelectMSGView = false;
  bool isSentSuccess = false; // Success state track karne ke liye
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
                            const SizedBox(width: 12),
                            InkWell(
                              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DatingGift(),)),
                              child: Container(
                                height: 90,
                                width: 70,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.card_giftcard, size: 35, color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => setModalState(() => isSelectMSGView = true),
                              child: const Text('Choose Message >', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // 1. Show success UI
                                setModalState(() => isSentSuccess = true);

                                // 2. Wait 1 second then close
                                Future.delayed(const Duration(seconds: 1), () {
                                  if (context.mounted) Navigator.pop(context);
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFAC4870),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                              ),
                              child: const Text('Send Rose', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                            ),
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

// Helper for Radio List
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
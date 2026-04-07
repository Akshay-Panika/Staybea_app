import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:staybea_app/feature/profile/screen/profile_screen.dart';

import '../../../core/utils/app_size.dart';
import '../dating/profile_page.dart';

class DatingScreen extends StatelessWidget {
  const DatingScreen({super.key});
  final bottomNavBarHeight = 80.0;

  final List<Map<String, dynamic>> _data = const [
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

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.rocket_launch_outlined, color: Colors.black54)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none, color: Colors.black54)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // PageView with fixed height
            SizedBox(
              height: MediaQuery.of(context).size.height
                  - kToolbarHeight // AppBar height
                  - MediaQuery.of(context).padding.top // status bar
                  - bottomNavBarHeight,
              // height: MediaQuery.of(context).size.height
              //     - kToolbarHeight // AppBar height
              //     - MediaQuery.of(context).padding.top,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  final profile = _data[index];
                  return Stack(
                    children: [
                      Image.network(
                        profile['images'][0],
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.black.withOpacity(0.85),
                                Colors.transparent,
                                Colors.black.withOpacity(0.2),
                              ],
                              stops: const [0.0, 0.45, 1.0],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        left: 10,
                        right: 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.2),
                              child: const Icon(Icons.replay, color: Colors.white),
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.2),
                              child: const Icon(Icons.more_vert, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 25,
                        left: 20,
                        right: 20,
                        child: Row(
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
                            Container(
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
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            ProfilePage(),
          ],
        ),
      ),    );
  }
}

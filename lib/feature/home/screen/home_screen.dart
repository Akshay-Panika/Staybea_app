import 'package:flutter/material.dart';
import 'package:staybea_app/feature/profile/screen/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {

  final TextEditingController controller = TextEditingController();
  IconData? selectedAction;
  bool showIcons = false;
  bool readMore = false;
  final FocusNode messageFocus = FocusNode();

  final PageController imageController = PageController();
  int currentImageIndex = 0;


  @override
  void initState() {
    super.initState();

    messageFocus.addListener(() {
      if (messageFocus.hasFocus) {
        setState(() {
          showIcons = false;
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    messageFocus.dispose();
    imageController.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> _data = [
    {
      "profileImage": "assets/profile/profile1.jpg",
      "name": "Mitali",
      "age": "23",
      "rangeKM": "3.5 KM",
      "images": [
        "https://picsum.photos/500/900?random=11",
        "https://picsum.photos/500/900?random=12",
        "https://picsum.photos/500/900?random=13",
      ]
    },
    {
      "profileImage": "assets/profile/profile2.jpg",
      "name": "Rini",
      "age": "21",
      "rangeKM": "2.8 KM",
      "images": [
        "https://picsum.photos/500/900?random=21",
        "https://picsum.photos/500/900?random=22",
        "https://picsum.photos/500/900?random=23",
      ]
    },
    {
      "profileImage": "assets/profile/profile3.jpg",
      "name": "Lena",
      "age": "26",
      "rangeKM": "5.0 KM",
      "images": [
        "https://picsum.photos/500/900?random=31",
        "https://picsum.photos/500/900?random=32",
        "https://picsum.photos/500/900?random=33",
      ]
    },
    {
      "profileImage": "assets/profile/profile4.jpg",
      "name": "Tashi",
      "age": "24",
      "rangeKM": "4.2 KM",
      "images": [
        "https://picsum.photos/500/900?random=41",
        "https://picsum.photos/500/900?random=42",
        "https://picsum.photos/500/900?random=43",
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: Colors.black,
    //   body: Stack(
    //     children: [
    //       Column(
    //         children: [
    //           Expanded(
    //             child: PageView.builder(
    //               itemCount: _data.length,
    //               scrollDirection: Axis.vertical,
    //               onPageChanged: (value) {
    //                 setState(() {
    //                   currentImageIndex = 0;
    //                 });
    //
    //                 imageController.jumpToPage(0);
    //               },
    //
    //               itemBuilder: (context, index) {
    //
    //                 final user = _data[index];
    //
    //                 return Stack(
    //                   children: [
    //                     Stack(
    //                       children: [
    //
    //
    //                         PageView.builder(
    //                           key: ValueKey(index),
    //                           controller: imageController,
    //                           itemCount: user["images"].length,
    //                           onPageChanged: (i) {
    //                             setState(() {
    //                               currentImageIndex = i;
    //                             });
    //                           },
    //                           itemBuilder: (context, imgIndex) {
    //                             return InkWell(
    //                               onTapUp: (details) {
    //
    //                                 double screenWidth = MediaQuery.of(context).size.width;
    //
    //                                 if (details.localPosition.dx > screenWidth / 2) {
    //
    //                                   /// Right tap → Next image
    //                                   if (currentImageIndex < user["images"].length - 1) {
    //                                     imageController.nextPage(
    //                                       duration: const Duration(milliseconds: 250),
    //                                       curve: Curves.ease,
    //                                     );
    //                                   }
    //
    //                                 } else {
    //
    //                                   /// Left tap → Previous image
    //                                   if (currentImageIndex > 0) {
    //                                     imageController.previousPage(
    //                                       duration: const Duration(milliseconds: 250),
    //                                       curve: Curves.ease,
    //                                     );
    //                                   }
    //
    //                                 }
    //                               },
    //                               child: Image.network(
    //                                 user["images"][imgIndex],
    //                                 fit: BoxFit.cover,
    //                               ),
    //                             );
    //                           },
    //                         ),
    //
    //                         Positioned(
    //                           top: 40,
    //                           left: 10,
    //                           right: 10,
    //                           child: Row(
    //                             children: List.generate(
    //                               user["images"].length,
    //                                   (i) => Expanded(
    //                                 child: Container(
    //                                   margin: const EdgeInsets.symmetric(horizontal: 2),
    //                                   height: 4,
    //                                   decoration: BoxDecoration(
    //                                     color: i == currentImageIndex
    //                                         ? Colors.white
    //                                         : Colors.white.withOpacity(0.3),
    //                                     borderRadius: BorderRadius.circular(4),
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //
    //                         /// Action
    //                         if (selectedAction != null)
    //                           Center(
    //                             child: AnimatedScale(
    //                               scale: selectedAction != null ? 1 : 0.6,
    //                               duration: const Duration(milliseconds: 350),
    //                               curve: Curves.easeOutBack,
    //                               child: AnimatedOpacity(
    //                                 opacity: selectedAction != null ? 1 : 0,
    //                                 duration: const Duration(milliseconds: 300),
    //                                 child: Container(
    //                                   padding: const EdgeInsets.all(20),
    //                                   decoration: BoxDecoration(
    //                                     shape: BoxShape.circle,
    //                                     boxShadow: [
    //                                       BoxShadow(
    //                                         color: Colors.white.withOpacity(0.16),
    //                                         blurRadius: 25,
    //                                         spreadRadius: 5,
    //                                       ),
    //                                     ],
    //                                   ),
    //                                   child: Icon(
    //                                     selectedAction,
    //                                     size: 120,
    //                                     color: selectedAction == Icons.favorite
    //                                         ? Colors.redAccent
    //                                         : Colors.amber,
    //                                     shadows: [
    //                                       Shadow(
    //                                         color: Colors.black.withOpacity(0.6),
    //                                         blurRadius: 5,
    //                                         offset: const Offset(0, 2),
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                       ],
    //                     ),
    //
    //                     Container(
    //                       padding: const EdgeInsets.only(
    //                           top: 50, left: 16, right: 16, bottom: 16),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //
    //                           /// Top Profile Image
    //                           InkWell(
    //                             onTap: () {
    //                               messageFocus.unfocus();
    //                               // FocusScope.of(context).unfocus();
    //                               Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),));
    //                             },
    //                             child: CircleAvatar(
    //                               radius: 28,
    //                               backgroundImage: AssetImage(user["profileImage"]),
    //                             ),
    //                           ),
    //
    //                           /// Bottom Info
    //                           AnimatedSize(
    //                             duration: const Duration(milliseconds: 300),
    //                             curve: Curves.easeInOut,
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //
    //                                 Text(
    //                                   "👤 ${user["name"]}",
    //                                   style: const TextStyle(
    //                                     color: Colors.white,
    //                                     fontWeight: FontWeight.bold,
    //                                     fontSize: 16,
    //                                   ),
    //                                 ),
    //
    //                                 Text(
    //                                   "🎂 Age: ${user["age"]}",
    //                                   style: const TextStyle(color: Colors.white70),
    //                                 ),
    //
    //                                 Text(
    //                                   "📍 Distance: ${user["rangeKM"]}",
    //                                   style: const TextStyle(color: Colors.white70),
    //                                 ),
    //
    //                                 const SizedBox(height: 6),
    //
    //                                 Text(
    //                                   "🌿 Beautiful place to visit. Nature looks amazing here. "
    //                                       "🏔️ The mountains, rivers and fresh air make this place "
    //                                       "perfect for relaxing and enjoying nature.",
    //                                   style: const TextStyle(
    //                                     color: Colors.white,
    //                                     fontSize: 14,
    //                                   ),
    //                                   maxLines: readMore ? 3 : 2,
    //                                   overflow: TextOverflow.ellipsis,
    //                                 ),
    //
    //                                 const SizedBox(height: 4),
    //
    //                                 GestureDetector(
    //                                   onTap: () {
    //                                     setState(() {
    //                                       readMore = !readMore;
    //                                     });
    //                                   },
    //                                   child: Text(
    //                                     readMore ? "⬆️ Read less" : "⬇️ Read more",
    //                                     style: const TextStyle(
    //                                       color: Colors.white70,
    //                                       fontWeight: FontWeight.bold,
    //                                     ),
    //                                   ),
    //                                 ),
    //                               ],
    //                             ),
    //                           )
    //                         ],
    //                       ),
    //                     ),
    //                   ],
    //                 );
    //               },
    //             ),
    //           ),
    //
    //           Container(
    //             padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    //             color: Colors.black,
    //             child: Row(
    //               children: [
    //
    //                 /// TextField
    //                 Expanded(
    //                   child: Container(
    //                     padding: const EdgeInsets.symmetric(horizontal: 12),
    //                     decoration: BoxDecoration(
    //                       color: Colors.grey[900],
    //                       borderRadius: BorderRadius.circular(30),
    //                     ),
    //                     child: Row(
    //                       children: [
    //
    //                         const Icon(Icons.emoji_emotions_outlined,
    //                             color: Colors.white70),
    //
    //                         const SizedBox(width: 8),
    //
    //                         Expanded(
    //                           child: TextField(
    //                             controller: controller,
    //                             focusNode: messageFocus,
    //                             style: const TextStyle(color: Colors.white),
    //                             decoration: const InputDecoration(
    //                               hintText: "Type a message",
    //                               hintStyle: TextStyle(color: Colors.white54),
    //                               border: InputBorder.none,
    //                             ),
    //                             onChanged: (value) {
    //                               setState(() {
    //                                 showIcons = value.isEmpty;
    //                               });
    //                             },
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //
    //                 const SizedBox(width: 8),
    //
    //                 /// Animated Icons
    //                 AnimatedContainer(
    //                   duration: const Duration(milliseconds: 300),
    //                   child: Row(
    //                     children: [
    //
    //                       /// Hidden Icons
    //                       AnimatedSwitcher(
    //                         duration: const Duration(milliseconds: 300),
    //                         child: showIcons
    //                             ? Row(
    //                           spacing: 5,
    //                           key: const ValueKey(1),
    //                           children: [
    //                             CircleAvatar(
    //                               backgroundColor: Colors.amber,
    //                               child: IconButton(
    //                                 icon: const Icon(Icons.star,
    //                                     color: Colors.white),
    //                                 onPressed: () {
    //                                   setState(() {
    //                                     selectedAction = Icons.star;
    //                                     showIcons = false;
    //                                   });
    //
    //                                   Future.delayed(const Duration(milliseconds: 800), () {
    //                                     setState(() {
    //                                       selectedAction = null;
    //                                     });
    //                                   });
    //                                 },
    //                               ),
    //                             ),
    //                             const SizedBox(width: 6),
    //                             CircleAvatar(
    //                               backgroundColor: Colors.pink,
    //                               child: IconButton(
    //                                 icon: const Icon(Icons.favorite,
    //                                     color: Colors.white),
    //                                 onPressed: () {
    //                                   setState(() {
    //                                     selectedAction = Icons.favorite;
    //                                     showIcons = false;
    //                                   });
    //
    //                                   Future.delayed(const Duration(milliseconds: 800), () {
    //                                     setState(() {
    //                                       selectedAction = null;
    //                                     });
    //                                   });
    //                                 },
    //                               ),
    //                             ),
    //                             const SizedBox(width: 6),
    //                           ],
    //                         )
    //                             : const SizedBox(key: ValueKey(2)),
    //                       ),
    //
    //                       /// Main Button
    //                       CircleAvatar(
    //
    //                         backgroundColor: Colors.green,
    //                         child: IconButton(
    //                           icon: const Icon(Icons.add, color: Colors.white),
    //                           onPressed: () {
    //                             setState(() {
    //                               showIcons = !showIcons;
    //                             });
    //                           },
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           SizedBox(height: 20,)
    //         ],
    //       ),
    //
    //       Positioned(
    //         top: 50,right: 10,
    //         child: Row(
    //           spacing: 10,
    //           crossAxisAlignment: CrossAxisAlignment.end,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             CircleAvatar(
    //                 backgroundColor: Colors.black.withOpacity(0.16),
    //                 child: Icon(Icons.info, color: Colors.white,)),
    //             CircleAvatar(
    //                 backgroundColor: Colors.black.withOpacity(0.16),
    //                 child: Icon(Icons.info, color: Colors.white,)),
    //           ],
    //         ),
    //       )
    //     ],
    //   ),
    // );
    return Center(child: Text("Dating"),);
  }
}
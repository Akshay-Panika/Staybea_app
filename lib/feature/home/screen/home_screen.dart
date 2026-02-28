import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import 'package:staybea_app/core/utils/app_logo.dart';
import '../../profile/screen/profile_screen.dart';
import '../widget/about_widget.dart';
import '../widget/verification_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, dynamic>> _data = [

    {
      "profileImage": "assets/profile/profile1.jpg",
      "name": "Mitali",
      "age": "23",
      "rangeKM": "3.5 KM",
      "verifyID": true,
    },
    {
      "profileImage": "assets/profile/profile2.jpg",
      "name": "Rini",
      "age": "21",
      "rangeKM": "2.8 KM",
      "verifyID": false,
    },
    {
      "profileImage": "assets/profile/profile3.jpg",
      "name": "Lena",
      "age": "26",
      "rangeKM": "5.0 KM",
      "verifyID": true,
    },
    {
      "profileImage": "assets/profile/profile4.jpg",
      "name": "Tashi",
      "age": "24",
      "rangeKM": "4.2 KM",
      "verifyID": true,
    },
  ];

  int _currentIndex = 0;
  Offset _dragOffset = Offset.zero;
  double _dragAngle = 0;

  // ✅ Center animation state
  String? _centerAction;
  bool _showCenterAnimation = false;

  void _onDragUpdate(DragUpdateDetails details) {
    setState(() {
      _dragOffset += details.delta;
      _dragAngle = _dragOffset.dx / 300 * 0.3;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_dragOffset.dx > 100) {
      _swipe('like');
    } else if (_dragOffset.dx < -100) {
      _swipe('dislike');
    } else {
      setState(() {
        _dragOffset = Offset.zero;
        _dragAngle = 0;
      });
    }
  }

  void _swipe(String action) {
    setState(() {
      _dragOffset = Offset.zero;
      _dragAngle = 0;
      if (_currentIndex < _data.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
    });
  }

  // ✅ Center animation trigger
  void _triggerCenterAnimation(String action) async {
    setState(() {
      _centerAction = action;
      _showCenterAnimation = true;
    });

    await Future.delayed(Duration(milliseconds: 800));

    setState(() {
      _showCenterAnimation = false;
    });

    await Future.delayed(Duration(milliseconds: 200));

    _swipe(action);
  }

  // ✅ Action ke hisab se icon + color
  Map<String, dynamic> _getActionStyle(String action) {
    switch (action) {
      case 'like':
        return {
          'icon': 'assets/icon/dill_icon.png',
          'color': Colors.green,
          'label': 'LIKE',
        };
      case 'dislike':
        return {
          'icon': 'assets/icon/crose_icon.png',
          'color': Colors.red,
          'label': 'NOPE',
        };
      case 'superlike':
        return {
          'icon': 'assets/icon/super_like.png',
          'color': Colors.blue,
          'label': 'SUPER',
        };
      default:
        return {
          'icon': 'assets/icon/like.png',
          'color': Colors.green,
          'label': 'LIKE',
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                _buildAppBar(context),
                Container(
                  height: 650,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Back card
                      if (_currentIndex + 1 < _data.length)
                        Positioned.fill(
                          child: Container(
                            margin: EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: _buildProfileCard(_data[_currentIndex + 1]),
                          ),
                        ),

                      // Front card
                      Positioned.fill(
                        child: GestureDetector(
                          onPanUpdate: _onDragUpdate,
                          onPanEnd: _onDragEnd,
                          child: AnimatedContainer(
                            duration: _dragOffset == Offset.zero
                                ? Duration(milliseconds: 300)
                                : Duration.zero,
                            margin: EdgeInsets.all(10),
                            child: Transform.translate(
                              offset: _dragOffset,
                              child: Transform.rotate(
                                angle: _dragAngle,
                                child: Stack(
                                  children: [
                                    _buildProfileCard(_data[_currentIndex]),

                                    // Drag LIKE overlay
                                    if (_dragOffset.dx > 30)
                                      Positioned(
                                        top: 40,
                                        left: 20,
                                        child: _overlayLabel('LIKE', Colors.green),
                                      ),

                                    // Drag NOPE overlay
                                    if (_dragOffset.dx < -30)
                                      Positioned(
                                        top: 40,
                                        right: 20,
                                        child: _overlayLabel('NOPE', Colors.red),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ✅ Center Animation Overlay
                      if (_showCenterAnimation && _centerAction != null)
                        Positioned.fill(
                          child: IgnorePointer(
                            child: Container(
                              margin: EdgeInsets.all(16),
                              child: Center(
                                child: _CenterActionAnimation(
                                  action: _centerAction!,
                                  style: _getActionStyle(_centerAction!),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                ProfileDetailsScreen(),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFFFF5FF),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () => _triggerCenterAnimation('dislike'), // ✅
                  child: _actionButton(icon: 'assets/icon/back_arrow.png'),
                ),
                GestureDetector(
                  onTap: () => _triggerCenterAnimation('superlike'), // ✅
                  child: _actionButton(icon: 'assets/icon/super_like.png'),
                ),
                GestureDetector(
                  onTap: () => _triggerCenterAnimation('like'), // ✅
                  child: _actionButton(icon: 'assets/icon/like.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard(Map<String, dynamic> profile) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            profile['profileImage'],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.white,
              child: Icon(Icons.image_not_supported_outlined, size: 100, color: Colors.grey.withOpacity(0.16)),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                if (profile['verifyID'] == true)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VerificationCardWidget(progress: 0.25,)
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${profile['name']}, ${profile['age']}",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          if (profile['verifyID'] == true)
                            Icon(Icons.verified, color: Colors.blue, size: 20),
                        ],
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            profile['rangeKM'],
                            style:
                            TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _overlayLabel(String text, Color color) {
    return Transform.rotate(
      angle: text == 'LIKE' ? -0.3 : 0.3,
      child: Image.asset(text == 'LIKE' ? 'assets/icon/dill_icon.png':'assets/icon/crose_icon.png', height: 80,),
    );
  }

  Widget _actionButton({required String icon}) {
    return Container(
      height: 50,
      width: 50,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Image.asset(icon),
    );
  }
}

class _CenterActionAnimation extends StatefulWidget {
  final String action;
  final Map<String, dynamic> style;

  const _CenterActionAnimation({
    required this.action,
    required this.style,
  });

  @override
  State<_CenterActionAnimation> createState() =>
      _CenterActionAnimationState();
}

class _CenterActionAnimationState extends State<_CenterActionAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    // Scale: 0.5 → 1.2 → 1.0
    _scaleAnim = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.5, end: 1.2),
        weight: 60,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 1.0),
        weight: 40,
      ),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Opacity: 0 → 1 → fade out
    _opacityAnim = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 1.0),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0),
        weight: 30,
      ),
    ]).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = widget.style['color'];
    final String label = widget.style['label'];
    final String icon = widget.style['icon'];

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnim.value,
          child: Transform.scale(
            scale: _scaleAnim.value,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                // color: Colors.white.withOpacity(0.3),
                // shape: BoxShape.circle,
                image: DecorationImage(image:AssetImage(icon))
                // border: Border.all(color: color, width: 3),
              ),
             
            ),
          ),
        );
      },
    );
  }
}

Widget _buildAppBar(BuildContext context) {
  return SizedBox(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(AppLogo.appLogo, height: 30),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 20),
              // Icon(Icons.notifications_none),
              SizedBox(width: 20),
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(),));
                  },
                  child: Icon(CupertinoIcons.person_crop_circle,size: 30,color: Colors.grey,)),
            ],
          )
        ],
      ),
    ),
  );
}
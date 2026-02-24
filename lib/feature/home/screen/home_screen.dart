import 'package:flutter/material.dart';
import 'dart:math' as math;

class DatingProfile {
  final String name;
  final int age;
  final String distance;
  final String imageUrl;
  final bool isVerified;

  const DatingProfile({
    required this.name,
    required this.age,
    required this.distance,
    required this.imageUrl,
    this.isVerified = false,
  });
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DatingProfile> _profiles = [
    const DatingProfile(
      name: 'Shraddhaaa',
      age: 21,
      distance: 'Just 7 km away from you',
      imageUrl:
      'https://images.unsplash.com/photo-1531746020798-e6953c6e8e04?w=600&q=80',
      isVerified: true,
    ),
    const DatingProfile(
      name: 'Priya',
      age: 24,
      distance: 'Just 3 km away from you',
      imageUrl:
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?w=600&q=80',
      isVerified: true,
    ),
    const DatingProfile(
      name: 'Ananya',
      age: 22,
      distance: 'Just 12 km away from you',
      imageUrl:
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=600&q=80',
    ),
    const DatingProfile(
      name: 'Meera',
      age: 26,
      distance: 'Just 5 km away from you',
      imageUrl:
      'https://images.unsplash.com/photo-1502823403499-6ccfcf4fb453?w=600&q=80',
      isVerified: true,
    ),
  ];

  int _currentIndex = 0;
  int _selectedTab = 1;

  void _onSwipeLeft() {
    setState(() {
      if (_currentIndex < _profiles.length - 1) _currentIndex++;
    });
  }

  void _onSwipeRight() {
    setState(() {
      if (_currentIndex < _profiles.length - 1) _currentIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: Container(
                color: Colors.white, // ensures background is white
                child: _profiles.isEmpty || _currentIndex >= _profiles.length
                    ? _buildEmptyState()
                    : _buildCardStack(),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  // ── AppBar
  Widget _buildAppBar() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Staybea',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
              letterSpacing: -0.5,
            ),
          ),
          Row(
            children: [
              _iconButton(Icons.notifications_outlined),
              const SizedBox(width: 8),
              _iconButton(Icons.person_outline),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Icon(icon, size: 20, color: const Color(0xFF1A1A1A)),
    );
  }

  // ── Card Stack
  Widget _buildCardStack() {
    if (_profiles.isEmpty || _currentIndex >= _profiles.length) {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Next card
          if (_currentIndex + 1 < _profiles.length)
            Positioned(
              top: 5,
              left: 5,
              right: 5,
              bottom: 5,
              child: _buildCard(_profiles[_currentIndex + 1], isBack: true),
            ),
          // Front card
          _SwipeableCard(
            key: ValueKey(_currentIndex),
            profile: _profiles[_currentIndex],
            onSwipeLeft: _onSwipeLeft,
            onSwipeRight: _onSwipeRight,
          ),
        ],
      ),
    );
  }

  Widget _buildCard(DatingProfile profile, {bool isBack = false}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Image.network(
          profile.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              Container(color: const Color(0xFFE0E0E0)),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('💔', style: TextStyle(fontSize: 64)),
          SizedBox(height: 16),
          Text(
            'No more profiles',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          SizedBox(height: 8),
          Text('Check back later!',
              style: TextStyle(color: Colors.black, fontSize: 16)),
        ],
      ),
    );
  }

  // ── Bottom Nav
  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navBtn(Icons.replay_rounded, const Color(0xFFFFB347), 0, size: 26),
          _navBtn(Icons.catching_pokemon_rounded, const Color(0xFFFF4D6D), 1,
              size: 32, isPrimary: true),
          _navBtn(Icons.favorite_border_rounded, const Color(0xFFFF4D6D), 2,
              size: 26),
        ],
      ),
    );
  }

  Widget _navBtn(IconData icon, Color color, int index,
      {double size = 24, bool isPrimary = false}) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isPrimary ? 64 : 52,
        height: isPrimary ? 64 : 52,
        decoration: BoxDecoration(
          color:
          isPrimary ? color : (isSelected ? color.withOpacity(0.1) : Colors.white),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: isPrimary ? color.withOpacity(0.4) : Colors.black.withOpacity(0.06),
              blurRadius: isPrimary ? 16 : 8,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Icon(
          icon,
          color: isPrimary ? Colors.white : (isSelected ? color : const Color(0xFFAAAAAA)),
          size: size,
        ),
      ),
    );
  }
}

// ─── Swipeable Card
class _SwipeableCard extends StatefulWidget {
  final DatingProfile profile;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;

  const _SwipeableCard({
    super.key,
    required this.profile,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });

  @override
  State<_SwipeableCard> createState() => _SwipeableCardState();
}

class _SwipeableCardState extends State<_SwipeableCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Offset _dragOffset = Offset.zero;
  bool _isDragging = false;
  _SwipeDirection? _swipeDir;
  double _overlayOpacity = 0;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPanStart(DragStartDetails _) {
    setState(() => _isDragging = true);
    _controller.stop();
  }

  void _onPanUpdate(DragUpdateDetails d) {
    setState(() {
      _dragOffset += d.delta;
      _overlayOpacity = (_dragOffset.dx.abs() / 150).clamp(0, 1);
      _swipeDir =
      _dragOffset.dx > 0 ? _SwipeDirection.right : _SwipeDirection.left;
    });
  }

  void _onPanEnd(DragEndDetails details) {
    final velocity = details.velocity.pixelsPerSecond.dx;
    final threshold = 100.0;

    if (_dragOffset.dx.abs() > threshold || velocity.abs() > 600) {
      final direction = (_dragOffset.dx > 0 || velocity > 0) ? 1.0 : -1.0;
      final screenWidth = MediaQuery.of(context).size.width;
      final targetX = direction * screenWidth * 1.5;

      _animateTo(Offset(targetX, _dragOffset.dy + direction * 200), () {
        if (direction > 0) {
          widget.onSwipeRight();
        } else {
          widget.onSwipeLeft();
        }
      });
    } else {
      _animateTo(Offset.zero, null);
    }
  }

  void _animateTo(Offset target, VoidCallback? onComplete) {
    final startOffset = _dragOffset;
    final startOpacity = _overlayOpacity;

    _controller.reset();
    _controller.addListener(() {
      setState(() {
        _dragOffset = Offset.lerp(startOffset, target, _controller.value)!;
        _overlayOpacity = (startOpacity * (1 - _controller.value)).clamp(0, 1);
      });
    });

    _controller.forward().whenComplete(() {
      setState(() {
        _isDragging = false;
        _swipeDir = null;
        _overlayOpacity = 0;
      });
      onComplete?.call();
    });
  }

  double get _rotation => (_dragOffset.dx / 300) * (math.pi / 8);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform(
        transform: Matrix4.identity()
          ..translate(_dragOffset.dx, _dragOffset.dy)
          ..rotateZ(_rotation),
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: size.width - 32,
          height: size.height * 0.68,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        widget.profile.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (_, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            color: const Color(0xFFE0E0E0),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          );
                        },
                        errorBuilder: (_, __, ___) => Container(
                          color: const Color(0xFFD0D0D0),
                          child:
                          const Icon(Icons.person, size: 80, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 220,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                                bottom: Radius.circular(24)),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.5) // less black
                              ],
                            ),
                          ),
                        ),
                      ),
                      // overlays for swipe
                      if (_swipeDir == _SwipeDirection.right && _overlayOpacity > 0)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                              const Color(0xFF4CAF50).withOpacity(_overlayOpacity * 0.4),
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      if (_swipeDir == _SwipeDirection.left && _overlayOpacity > 0)
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color:
                              const Color(0xFFF44336).withOpacity(_overlayOpacity * 0.4),
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      // LIKE / NOPE stamps
                      if (_swipeDir == _SwipeDirection.right && _overlayOpacity > 0.3)
                        Positioned(
                          top: 40,
                          left: 24,
                          child: Transform.rotate(
                            angle: -0.3,
                            child: Opacity(
                                opacity: ((_overlayOpacity - 0.3) / 0.7).clamp(0, 1),
                                child: _stamp('LIKE', const Color(0xFF4CAF50))),
                          ),
                        ),
                      if (_swipeDir == _SwipeDirection.left && _overlayOpacity > 0.3)
                        Positioned(
                          top: 40,
                          right: 24,
                          child: Transform.rotate(
                            angle: 0.3,
                            child: Opacity(
                                opacity: ((_overlayOpacity - 0.3) / 0.7).clamp(0, 1),
                                child: _stamp('NOPE', const Color(0xFFF44336))),
                          ),
                        ),
                      // Heart icon
                      if (_swipeDir == _SwipeDirection.right && _overlayOpacity > 0.5)
                        Positioned(
                          top: 80,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Opacity(
                              opacity: ((_overlayOpacity - 0.5) / 0.5).clamp(0, 1),
                              child: const Icon(Icons.favorite,
                                  color: Color(0xFFFF4D6D), size: 100),
                            ),
                          ),
                        ),
                      // Profile info
                      Positioned(
                        bottom: 20,
                        left: 20,
                        right: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${widget.profile.name} ${widget.profile.age}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: -0.3,
                                  ),
                                ),
                                if (widget.profile.isVerified) ...[
                                  const SizedBox(width: 6),
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFF2196F3),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  ),
                                ]
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.white70, size: 14),
                                const SizedBox(width: 4),
                                Text(
                                  widget.profile.distance,
                                  style: const TextStyle(
                                      color: Colors.white70, fontSize: 13),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stamp(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 28,
          fontWeight: FontWeight.w900,
          letterSpacing: 2,
        ),
      ),
    );
  }
}

enum _SwipeDirection { left, right }
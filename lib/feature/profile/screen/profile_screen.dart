import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final PageController _planController = PageController();
  int _currentPlan = 0;

  final List<Map<String, dynamic>> _plans = [
    {
      'badge': 'Sparkly',
      'badgeColors': [Color(0xFFFFCC33), Color(0xFFFFAA00)],
      'borderColor': Color(0xFFFFDD88),
      'shadowColor': Color(0xFFFFAA00),
      'goldColor': Color(0xFFFFAA00),
      'features': [
        'See who likes you',
        'Top picks',
        'Free super likes',
      ],
    },
    {
      'badge': 'Bondly',
      'badgeColors': [Color(0xFFFFCC33), Color(0xFFFFAA00)], // ✅ same gold
      'borderColor': Color(0xFFFFDD88),                      // ✅ same border
      'shadowColor': Color(0xFFFFAA00),                      // ✅ same shadow
      'goldColor': Color(0xFFFFAA00),                        // ✅ same gold text
      'features': [
        'Priority likes',
        'Message before match',
        'See who likes you',
      ],
    },
    {
      'badge': 'Foreverly',
      'badgeColors': [Color(0xFFFFCC33), Color(0xFFFFAA00)], // ✅ same gold
      'borderColor': Color(0xFFFFDD88),                      // ✅ same border
      'shadowColor': Color(0xFFFFAA00),                      // ✅ same shadow
      'goldColor': Color(0xFFFFAA00),                        // ✅ same gold text
      'features': [
        'Unlimited likes',
        'Unlimited Rewinds',
        'Passport',
      ],
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF0F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildProfileSection(),
              const SizedBox(height: 6),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Complete your profile to be seen by more people!',
                  style: TextStyle(fontSize: 12.5, color: Color(0xFF888888)),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),

              // ── Add Photos Banner ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF3E0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.photo_library_outlined,
                            color: Color(0xFFFFAA33), size: 24),
                      ),
                      const SizedBox(width: 12),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Add at least 4 photos',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Get up to 2x more likes with 6 pics',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF888888)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // ── 3 Action Cards ──
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    _buildActionCard(
                      icon: Icons.favorite_border,
                      iconColor: const Color(0xFFBB3399),
                      topText: '0 Super Likes',
                      bottomText: 'GET MORE',
                      showPlus: true,
                    ),
                    const SizedBox(width: 10),
                    _buildActionCard(
                      icon: Icons.rocket_launch_outlined,
                      iconColor: const Color(0xFF9944CC),
                      topText: 'My Boosts',
                      bottomText: 'GET MORE',
                      showPlus: true,
                    ),
                    const SizedBox(width: 10),
                    _buildActionCard(
                      icon: Icons.account_balance_wallet_outlined,
                      iconColor: const Color(0xFF888888),
                      topText: '',
                      bottomText: 'My Wallet',
                      showPlus: false,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // ── Swipeable Plan Cards ──
              SizedBox(
                height: 340,
                child: PageView.builder(
                  controller: _planController,
                  itemCount: _plans.length,
                  onPageChanged: (i) => setState(() => _currentPlan = i),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: _buildPlanCard(_plans[index]),
                    );
                  },
                ),
              ),

              // ── Dot Indicators ──
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_plans.length, (i) {
                  final isActive = i == _currentPlan;
                  final color = _plans[i]['badgeColors'][1] as Color;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 20 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: isActive ? color : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  Widget _buildPlanCard(Map<String, dynamic> plan) {
    final List<Color> badgeColors = plan['badgeColors'];
    final Color borderColor = plan['borderColor'];
    final Color shadowColor = plan['shadowColor'];
    final Color goldColor = plan['goldColor'];
    final List<String> features = List<String>.from(plan['features']);
    final String badge = plan['badge'];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: shadowColor.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // ── Badge top-right ──
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: badgeColors),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome,
                        color: Colors.white, size: 13),
                    const SizedBox(width: 5),
                    Text(
                      '✦ $badge',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── StayBea Logo ──
                Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFFFEEF5),
                      ),
                      child: const Icon(Icons.favorite,
                          color: Color(0xFFCC3399), size: 18),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: 'STAY',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF2D2D2D),
                                  letterSpacing: 0.5,
                                ),
                              ),
                              TextSpan(
                                text: 'BEA',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFFCC3399),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          'Love without the lies',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF999999),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                // ── Table Header ──
                Row(
                  children: [
                    const Expanded(
                      flex: 5,
                      child: Text(
                        "What's Included",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Center(
                        child: Text(
                          'Free',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: Center(
                        child: Text(
                          'Gold',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: goldColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),
                const Divider(color: Color(0xFFF2F2F2), thickness: 1),

                // ── Feature Rows ──
                ...features.map((f) => _buildFeatureRow(f, goldColor)),


              ],
            ),
          ),
          Spacer(),

          // ── Upgrade Button ──
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: badgeColors),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.workspace_premium,
                      color: Colors.white, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Upgrade',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  Widget _buildFeatureRow(String feature, Color goldColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              feature,
              style: const TextStyle(fontSize: 13, color: Color(0xFF555555)),
            ),
          ),
          // Free — red shield
          SizedBox(
            width: 50,
            child: Center(
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFEEEE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.shield,
                    color: Color(0xFFCC2222), size: 18),
              ),
            ),
          ),
          // Gold — green check
          SizedBox(
            width: 50,
            child: Center(
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Color(0xFFEEFFEE),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle,
                    color: Color(0xFF22AA44), size: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────
  Widget _buildProfileSection() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 118,
              height: 118,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFCC3399).withOpacity(0.18),
                    blurRadius: 18,
                    spreadRadius: 4,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 114,
              height: 114,
              child: CircularProgressIndicator(
                value: 0.62,
                strokeWidth: 5,
                backgroundColor: Colors.grey.shade200,
                valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFFCC3399)),
              ),
            ),
            Container(
              width: 98,
              height: 98,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: ClipOval(
                child: Image.network(
                  'https://randomuser.me/api/portraits/women/44.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: const Color(0xFFEECCDD),
                    child: const Icon(Icons.person,
                        size: 50, color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFCC3399),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFCC3399).withOpacity(0.4),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Text(
                  '62%',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Tanishka',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
              ),
            ),
            SizedBox(width: 6),
            Icon(Icons.verified, color: Colors.blue, size: 22),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
          decoration: BoxDecoration(
            color: const Color(0xFFCC3399),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFCC3399).withOpacity(0.35),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.edit, size: 14, color: Colors.white),
              SizedBox(width: 6),
              Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  // ─────────────────────────────────────────
  Widget _buildActionCard({
    required IconData icon,
    required Color iconColor,
    required String topText,
    required String bottomText,
    required bool showPlus,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 8),
            if (topText.isNotEmpty)
              Text(
                topText,
                style: const TextStyle(
                  fontSize: 11.5,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 8),
            Container(height: 1, color: const Color(0xFFF0F0F0)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  bottomText,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: showPlus
                        ? const Color(0xFFBB3399)
                        : const Color(0xFF777777),
                  ),
                ),
                if (showPlus) ...[
                  const SizedBox(width: 4),
                  Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: const Color(0xFFBB3399), width: 1.5),
                    ),
                    child: const Icon(Icons.add,
                        size: 10, color: Color(0xFFBB3399)),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
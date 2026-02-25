import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDF0F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),

              // ── Profile Avatar + Ring ──
              _buildProfileSection(),

              const SizedBox(height: 6),

              // ── Complete Profile Text ──
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Text(
                  'Complete your profile to be seen by more people!',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Color(0xFF888888),
                  ),
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
                        child: const Icon(
                          Icons.photo_library_outlined,
                          color: Color(0xFFFFAA33),
                          size: 24,
                        ),
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
                              fontSize: 12,
                              color: Color(0xFF888888),
                            ),
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

              // ── Gold Plan Card ──
              _buildGoldPlanCard(),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────
  Widget _buildProfileSection() {
    return Column(
      children: [
        // Ring + Avatar
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 112,
              height: 112,
              child: CircularProgressIndicator(
                value: 0.62,
                strokeWidth: 4.5,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Color(0xFFCC3399),
                ),
              ),
            ),
            ClipOval(
              child: Image.network(
                'https://randomuser.me/api/portraits/women/44.jpg',
                width: 94,
                height: 94,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 94,
                  height: 94,
                  color: const Color(0xFFEECCDD),
                  child: const Icon(Icons.person, size: 50, color: Colors.white),
                ),
              ),
            ),
            // 62% badge
            Positioned(
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: const Color(0xFFCC3399),
                  borderRadius: BorderRadius.circular(20),
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

        const SizedBox(height: 12),

        // Name + Verified
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Tanishka',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D2D2D),
              ),
            ),
            SizedBox(width: 6),
            Icon(Icons.verified, color: Colors.blue, size: 22),
          ],
        ),

        const SizedBox(height: 10),

        // Edit Profile button - FILLED pink/purple
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
          decoration: BoxDecoration(
            color: const Color(0xFFCC3399),
            borderRadius: BorderRadius.circular(22),
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
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFEEEEEE), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 28),
            const SizedBox(height: 6),
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
            Container(height: 1, color: const Color(0xFFEEEEEE)),
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
                  const SizedBox(width: 3),
                  Container(
                    width: 15,
                    height: 15,
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

  // ─────────────────────────────────────────
  Widget _buildGoldPlanCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFFFDD88), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            // ── Sparkly badge top-right ──
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 7),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFFFCC33), Color(0xFFFFAA00)],
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(14),
                      bottomLeft: Radius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.auto_awesome,
                          color: Colors.white, size: 13),
                      SizedBox(width: 4),
                      Text(
                        'Sparkly',
                        style: TextStyle(
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFFEEF5),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Color(0xFFCC3399),
                          size: 17,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: 'STAY',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF2D2D2D),
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                TextSpan(
                                  text: 'BEA',
                                  style: TextStyle(
                                    fontSize: 16,
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

                  const SizedBox(height: 16),

                  // ── Table header ──
                  Row(
                    children: const [
                      Expanded(
                        flex: 4,
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
                        width: 52,
                        child: Center(
                          child: Text(
                            'Free',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF2D2D2D),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 52,
                        child: Center(
                          child: Text(
                            'Gold',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFFFFAA00),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  _buildFeatureRow('See who likes you'),
                  _buildFeatureRow('Top picks'),
                  _buildFeatureRow('Free super likes'),

                  const SizedBox(height: 14),
                ],
              ),
            ),

            // ── Upgrade Button ──
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFFFDD55), Color(0xFFFFAA00)],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
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
                        color: Colors.white, size: 18),
                    SizedBox(width: 8),
                    Text(
                      'Upgrade',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              feature,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF555555),
              ),
            ),
          ),
          // Free - red shield icon
          SizedBox(
            width: 52,
            child: Center(
              child: Icon(
                Icons.shield,
                color: const Color(0xFFCC2222),
                size: 22,
              ),
            ),
          ),
          // Gold - green check icon
          SizedBox(
            width: 52,
            child: Center(
              child: Icon(
                Icons.check_circle,
                color: const Color(0xFF22AA44),
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
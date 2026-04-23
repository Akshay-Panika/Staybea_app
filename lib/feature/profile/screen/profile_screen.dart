import 'package:flutter/material.dart';
import 'package:staybea_app/core/constant/App_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _safetyMode = false;
  int _selectedTab = 1; // Dating selected by default

  static const Color primaryPink = Color(0xFFB5144F);
  static const Color lightPink = Color(0xFFF8E8EE);
  static const Color cardBg = Colors.white;
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF888888);
  static const Color borderGrey = Color(0xFFEEEEEE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Column(
          children: [
            // Top Tab Bar
            // _buildTopTabBar(),
            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Profile Avatar + Progress
                    _buildAvatarSection(),
                    const SizedBox(height: 12),
                    // Name
                    _buildNameSection(),
                    const SizedBox(height: 8),
                    // Edit Profile Button
                    _buildEditProfileButton(),
                    const SizedBox(height: 8),
                    // Complete profile text
                    const Text(
                      'Complete your profile to be seen by more people!',
                      style: TextStyle(
                        fontSize: 13,
                        color: textGrey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Voice Intro Banner
                    _buildVoiceIntroBanner(),
                    const SizedBox(height: 16),
                    // Action Cards Row
                    _buildActionCards(),
                    const SizedBox(height: 16),
                    // AI Avatar Studio Card
                    _buildAIAvatarCard(),
                    const SizedBox(height: 16),
                    // Premium / Upgrade Card
                    _buildPremiumCard(),
                    const SizedBox(height: 16),
                    // Profile Menu Section
                    _buildProfileMenuSection(),
                    const SizedBox(height: 16),
                    // Settings Menu Section
                    _buildSettingsMenuSection(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopTabBar() {
    final tabs = ['Marriage', 'Dating', 'Mature Dating'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(tabs.length, (index) {
          final isSelected = index == _selectedTab;
          return GestureDetector(
            onTap: () => setState(() => _selectedTab = index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    tabs[index],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected ? textDark : textGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (isSelected)
                    Container(
                      height: 2,
                      width: 40,
                      decoration: BoxDecoration(
                        color: primaryPink,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAvatarSection() {
    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        children: [
          // Circular progress ring
          Positioned.fill(
            child: CircularProgressIndicator(
              value: 0.62,
              strokeWidth: 4,
              backgroundColor: borderGrey,
              valueColor: const AlwaysStoppedAnimation<Color>(primaryPink),
            ),
          ),
          // Avatar
          Padding(
            padding: const EdgeInsets.all(6),
            child: ClipOval(
              child: Container(
                color: const Color(0xFFE8C8D0),
                child: const Icon(Icons.person, size: 80, color: Color(0xFF7B4F5C)),
              ),
            ),
          ),
          // 62% label
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderGrey),
              ),
              child: const Text(
                '62%',
                style: TextStyle(
                  fontSize: 11,
                  color: textDark,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Tanishka',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: textDark,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1DA1F2),
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(3),
          child: const Icon(Icons.check, size: 12, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildEditProfileButton() {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.edit, size: 14, color: primaryPink),
      label: const Text(
        'Edit Profile',
        style: TextStyle(color: primaryPink, fontSize: 13, fontWeight: FontWeight.w500),
      ),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: primaryPink),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
    );
  }

  Widget _buildVoiceIntroBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: borderGrey),
      ),
      child: Row(
        children: [
          const Icon(Icons.mic_none, color: primaryPink, size: 20),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Add Voice Intro to reach 100%',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: textDark,
              ),
            ),
          ),
          const Icon(Icons.chevron_right, color: textGrey, size: 20),
        ],
      ),
    );
  }

  Widget _buildActionCards() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _actionCard(Icons.favorite_border, 'Super Likes', true),
          const SizedBox(width: 12),
          _actionCard(Icons.rocket_launch_outlined, 'My Boosts', true),
          const SizedBox(width: 12),
          _actionCard(Icons.account_balance_wallet_outlined, 'My Wallet', false),
        ],
      ),
    );
  }

  Widget _actionCard(IconData icon, String label, bool hasAdd) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.secondary.withOpacity(.6)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Icon(icon, size: 28, color: primaryPink),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: textDark,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAIAvatarCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: lightPink,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.auto_awesome, color: primaryPink, size: 20),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AI Avatar Studio',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: textDark,
                    ),
                  ),
                  Text(
                    'Generate high-end editorial avatars',
                    style: TextStyle(fontSize: 11, color: textGrey),
                  ),
                ],
              ),
            ],
          ),
          const Divider(height: 24, color: borderGrey),
          Row(
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Safety Mode',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: textDark,
                      ),
                    ),
                    Text(
                      'AI-enhanced privacy filters',
                      style: TextStyle(fontSize: 11, color: textGrey),
                    ),
                  ],
                ),
              ),
              Switch(
                value: _safetyMode,
                onChanged: (v) => setState(() => _safetyMode = v),
                activeColor: primaryPink,
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.auto_fix_high, size: 16, color: primaryPink),
              label: const Text(
                'Manage or Create Avatar',
                style: TextStyle(color: primaryPink, fontSize: 13),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: primaryPink),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderGrey),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              // Header with logo
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
                child: Row(
                  children: [
                    // STAYBEA logo text
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: 'STAY',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: textDark,
                            ),
                          ),
                          WidgetSpan(
                            child: Icon(Icons.favorite, color: primaryPink, size: 18),
                          ),
                          TextSpan(
                            text: 'BEA',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: textDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Table header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        "What's Included",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: textDark,
                        ),
                      ),
                    ),
                    SizedBox(width: 60, child: Center(child: Text('Free', style: TextStyle(fontSize: 12, color: textGrey)))),
                    SizedBox(width: 60, child: Center(child: Text('Gold', style: TextStyle(fontSize: 12, color: Color(0xFFB8860B), fontWeight: FontWeight.w600)))),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              _premiumRow('See who likes you'),
              _premiumRow('Top picks'),
              _premiumRow('Free super likes'),
              const SizedBox(height: 16),
              // Upgrade button
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin:Alignment.topCenter,
                    end:Alignment.bottomCenter,
                    colors: [Color(0xFFD97FA4), Color(0xFFA54275)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.workspace_premium, color: Colors.white, size: 18),
                  label: const Text(
                    'Upgrade',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
            ],
          ),
          // Premium badge top right
          Positioned(
            top: -1,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin:Alignment.topCenter,
                  end:Alignment.bottomCenter,
                  colors: [Color(0xFFD97FA4), Color(0xFFA54275)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.auto_awesome, color: Colors.white, size: 13),
                  SizedBox(width: 4),
                  Text(
                    'Premium',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
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

  Widget _premiumRow(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: const TextStyle(fontSize: 13, color: textDark)),
          ),
          SizedBox(
            width: 60,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF0F0),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.block, color: Color(0xFFCC0000), size: 14),
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        children: [
          _menuItem(Icons.person_outline, 'My Profile & Bio', 'Edit details, photos and preferences', null),
          _divider(),
          _menuItem(Icons.favorite_border, 'Forever Love Programme', '3-year journey tracking', '5 Lakh Status', isStatus: true),
          _divider(),
          _menuItem(Icons.loyalty_outlined, 'Loyalty Management', null, '• Active Commitments  • 3 Proposals  • 12 Requests', isSmallStatus: true),
          _divider(),
          _menuItem(Icons.shield_outlined, 'Trust Centre', 'Manage reliability score & badges', null),
        ],
      ),
    );
  }

  Widget _buildSettingsMenuSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderGrey),
      ),
      child: Column(
        children: [
          _menuItem(Icons.person_outline, 'Membership Plans', 'Upgrade or manage subscription', null),
          _divider(),
          _menuItem(Icons.settings_outlined, 'Account Settings', 'Privacy, Notifications, Security', null),
          _divider(),
          _menuItem(Icons.help_outline, 'Help & Support', 'FAQ, Chat with Support', null),
          _divider(),
          _menuItem(Icons.logout, 'Logout', 'Sign out of your account', null, isLogout: true),
        ],
      ),
    );
  }

  Widget _menuItem(
      IconData icon,
      String title,
      String? subtitle,
      String? trailing, {
        bool isStatus = false,
        bool isSmallStatus = false,
        bool isLogout = false,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isLogout ? const Color(0xFFFFF0F0) :AppColors.secondary.withOpacity(.1),
            borderRadius: BorderRadius.circular(10)
            ),
            child: Icon(icon, size: 18, color: isLogout ? primaryPink : AppColors.secondary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isLogout ? primaryPink : textDark,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: isLogout ? primaryPink.withOpacity(0.7) : textGrey,
                    ),
                  ),
                if (isSmallStatus && trailing != null)
                  Text(
                    trailing,
                    style: const TextStyle(fontSize: 10, color: textGrey),
                  ),
              ],
            ),
          ),
          if (isStatus && trailing != null)
            Text(
              trailing,
              style: const TextStyle(
                fontSize: 11,
                color: primaryPink,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }

  Widget _divider() => const Divider(height: 1, thickness: 1, color: borderGrey, indent: 16, endIndent: 16);
}
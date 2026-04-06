import 'package:flutter/material.dart';
import 'package:staybea_app/core/constant/app_color.dart';
import 'package:staybea_app/core/widget/custom_button.dart';

class BoostOption {
  final String quantity;
  final String label;
  final String price;
  final String? saveBadge;
  final String? tag;

  const BoostOption({
    required this.quantity,
    required this.label,
    required this.price,
    this.saveBadge,
    this.tag,
  });
}

const Color kPrimary = Color(0xFFAD2F6D);
const Color kPrimaryLight = Color(0xFFF8EEF4);
const Color kBadgeBg = Color(0xFFAD2F6D);
const Color kPopularBg = Color(0xFF888888);
const Color kSaveBg = Color(0xFFEDD9EC);
const Color kSaveText = Color(0xFFAD2F6D);
const Color kDivider = Color(0xFFE0E0E0);
const Color kSubtext = Color(0xFF888888);

final _boostOptions = [
  const BoostOption(
    quantity: '20',
    label: 'Boosts',
    price: '₹175.00/ea',
    saveBadge: 'Save 51%',
    tag: 'Best value',
  ),
  const BoostOption(
    quantity: '10',
    label: 'Boosts',
    price: '₹215.00/ea',
    saveBadge: 'Save 40%',
    tag: 'Popular',
  ),
  const BoostOption(
    quantity: '03',
    label: 'Boosts',
    price: '₹356.00/ea',
  ),
];

final _primetimeOptions = [
  const BoostOption(
    quantity: '05',
    label: 'Primetime Boost',
    price: '₹1,160.00/ea',
    saveBadge: 'Save 25%',
  ),
  const BoostOption(
    quantity: '03',
    label: 'Primetime Boost',
    price: '₹1,366.60/ea',
    saveBadge: 'Save 12%',
  ),
  const BoostOption(
    quantity: '01',
    label: 'Primetime Boost',
    price: '₹1,550.00',
  ),
];

final _superOptions = [
  const BoostOption(
    quantity: '12',
    label: 'Hours',
    price: '₹11,100.00',
    saveBadge: 'Save 21%',
    tag: 'Best value',
  ),
  const BoostOption(
    quantity: '06',
    label: 'Hours',
    price: '₹5,900.00',
    saveBadge: 'Save 21%',
    tag: 'Popular',
  ),
  const BoostOption(
    quantity: '03',
    label: 'Hours',
    price: '₹3,500.00',
  ),
];

class GetBoostScreen extends StatefulWidget {
  const GetBoostScreen({super.key});

  @override
  State<GetBoostScreen> createState() => _GetBoostScreenState();
}

class _GetBoostScreenState extends State<GetBoostScreen> {
  int _selectedTab = 0;
  int _selectedOptionIndex = 0;

  final _tabs = ['Boost', 'Primetime', 'Super'];

  List<BoostOption> get _currentOptions {
    switch (_selectedTab) {
      case 0:
        return _boostOptions;
      case 1:
        return _primetimeOptions;
      case 2:
        return _superOptions;
      default:
        return _boostOptions;
    }
  }

  String get _continueButtonText {
    switch (_selectedTab) {
      case 0:
        return 'Continue for ₹2,150.00 total';
      case 1:
        return 'Continue for ₹4,100.00 total';
      case 2:
        return 'Unlock super Boost';
      default:
        return 'Continue';
    }
  }

  String get _boostTitle {
    switch (_selectedTab) {
      case 0:
        return 'Boost';
      case 1:
        return 'Primetime Boost';
      case 2:
        return 'Super Boost';
      default:
        return 'Boost';
    }
  }

  String get _boostSubtitle {
    switch (_selectedTab) {
      case 0:
        return 'Be a top profile in your area for 30 minutes to get more likes.';
      case 1:
        return 'We boost you when the most users are active, so you\'re seen by more potential matches.';
      case 2:
        return 'Super boost keeps you front and Center for longer, giving you more opportunity to connect.';
      default:
        return '';
    }
  }

  IconData get _boostIcon {
    switch (_selectedTab) {
      case 0:
        return Icons.bolt;
      case 1:
        return Icons.access_time_filled;
      case 2:
        return Icons.flash_on;
      default:
        return Icons.bolt;
    }
  }

  Color get _iconBgColor {
    switch (_selectedTab) {
      case 0:
        return const Color(0xFF7C3AED);
      case 1:
        return const Color(0xFF9B3CB7);
      case 2:
        return const Color(0xFF4F46E5);
      default:
        return const Color(0xFF7C3AED);
    }
  }

  @override
  Widget build(BuildContext context) {
    final options = _currentOptions;
    final isSuper = _selectedTab == 2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top Bar ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios,
                        size: 20, color: Colors.black87),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Get Boost',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // ── Tab Bar ──────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _TabBar(
                tabs: _tabs,
                selectedIndex: _selectedTab,
                onTabSelected: (i) => setState(() {
                  _selectedTab = i;
                  _selectedOptionIndex = 0;
                }),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Boost header row
                    Row(
                      children: [
                        _AvatarWithIcon(
                          iconData: _boostIcon,
                          bgColor: _iconBgColor,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _boostTitle,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _boostSubtitle,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: kSubtext,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Options
                    ...List.generate(options.length, (i) {
                      final opt = options[i];
                      final isSelected = _selectedOptionIndex == i;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _BoostOptionCard(
                          option: opt,
                          isSelected: isSelected,
                          onTap: () =>
                              setState(() => _selectedOptionIndex = i),
                        ),
                      );
                    }),

                    // OR + Premium (not on Super tab)
                    if (!isSuper) ...[
                      const SizedBox(height: 4),
                      _OrDivider(),
                      const SizedBox(height: 16),
                      _PremiumRow(),
                    ],

                    // Super-only note
                    if (isSuper) ...[
                      const SizedBox(height: 8),
                      Center(
                        child: Text(
                          'For subscribers only',
                          style: TextStyle(
                            fontSize: 13,
                            color: kSubtext,
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                  tColor: Colors.white,
                  bColor: AppColors.secondary,
                  text: _continueButtonText,
                  onTap: () {

                  },),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Tab Bar Widget
// ─────────────────────────────────────────────

class _TabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;

  const _TabBar({
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final selected = selectedIndex == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: selected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: selected
                      ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    )
                  ]
                      : [],
                ),
                child: Center(
                  child: Text(
                    tabs[i],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                      selected ? FontWeight.w600 : FontWeight.w400,
                      color: selected ? Colors.black87 : kSubtext,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Avatar with Icon overlay
// ─────────────────────────────────────────────

class _AvatarWithIcon extends StatelessWidget {
  final IconData iconData;
  final Color bgColor;

  const _AvatarWithIcon({required this.iconData, required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 56,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: const NetworkImage(
              'https://randomuser.me/api/portraits/women/44.jpg',
            ),
            backgroundColor: Colors.grey[200],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: Icon(iconData, color: Colors.white, size: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Boost Option Card
// ─────────────────────────────────────────────

class _BoostOptionCard extends StatelessWidget {
  final BoostOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const _BoostOptionCard({
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasBestValue = option.tag == 'Best value';
    final isPopular = option.tag == 'Popular';

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: isSelected ? kPrimary : kDivider,
                width: isSelected ? 1 : 1,
              ),
            ),
            child: Row(
              children: [
                // Quantity + label
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          option.quantity,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          option.label,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    if (option.saveBadge != null) ...[
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: kSaveBg,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          option.saveBadge!,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: kSaveText,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),

                const Spacer(),

                // Price
                Text(
                  option.price,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? kPrimary : Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Tag badge (Best value / Popular)
          if (option.tag != null)
            Positioned(
              top: -10,
              right: 12,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isSelected ? kPrimary : kDivider,
                  // color: hasBestValue ? kBadgeBg : kPopularBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  option.tag!,
                  style:  TextStyle(
                    color:  isSelected ? Colors.white:Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// OR Divider
// ─────────────────────────────────────────────

class _OrDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: kDivider, thickness: 1)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            'OR',
            style: TextStyle(
              fontSize: 13,
              color: kSubtext,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Expanded(child: Divider(color: kDivider, thickness: 1)),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Get Premium Row
// ─────────────────────────────────────────────

class _PremiumRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Get Premium',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 2),
              Text(
                '1 free boost per month',
                style: TextStyle(
                  fontSize: 13,
                  color: kSubtext,
                ),
              ),
            ],
          ),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: kPrimary, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          ),
          child: const Text(
            'Select',
            style: TextStyle(
              color: kPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
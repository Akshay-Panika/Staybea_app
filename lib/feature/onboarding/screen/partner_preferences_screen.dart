import 'package:flutter/material.dart';

const _pink = Color(0xFFAD3B6E);
const _cardBorder = Color(0xFFE8E8E8);
const _labelColor = Color(0xFF9E9E9E);
const _valueColor = Color(0xFF212121);

class PartnerPreferencesScreen extends StatefulWidget {
  const PartnerPreferencesScreen({super.key});

  @override
  State<PartnerPreferencesScreen> createState() =>
      _PartnerPreferencesScreenState();
}

class _PartnerPreferencesScreenState extends State<PartnerPreferencesScreen> {
  double _maxDistance = 10;
  RangeValues _ageRange = const RangeValues(27, 29);
  RangeValues _heightRange = const RangeValues(66, 73);

  String _inchesToFeet(double inches) {
    final ft = inches.round() ~/ 12;
    final i = inches.round() % 12;
    return "$ft'$i\"";
  }

  final List<String> _advancedPrefs = [
    'Has Bio',
    'Interests',
    'Looking For',
    'Languages',
    'Zodiac',
    'Education',
    'Occupation',
    'Communication Style',
    'Love Style',
    'Pets',
    'Diet',
    'Drinking',
    'Smoking',
    'Workout',
    'Social Media',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: const BackButton(color: Colors.black87),
        title: const Text(
          'Partner preferences',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey.shade200),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _sectionHeader('Basic Preference'),
          _simpleCard(
            child: _prefRowInner(
              label: 'Verification Level',
              value: 'Premium High...',
              onTap: () {},
            ),
          ),
          const SizedBox(height: 10),
          _simpleCard(
            child: _prefRowInner(
              label: 'Location',
              value: 'Same City',
              onTap: () {},
            ),
          ),
          const SizedBox(height: 10),
          _simpleCard(child: _distanceSliderInner()),
          const SizedBox(height: 10),
          _simpleCard(
            child: _prefRowInner(
              label: 'Interested In',
              value: 'Men',
              onTap: () {},
            ),
          ),
          const SizedBox(height: 10),
          _simpleCard(child: _ageSliderInner()),
          const SizedBox(height: 10),
          _simpleCard(child: _heightSliderInner()),
          const SizedBox(height: 14),
          _upgradeBanner(),
          _sectionHeader('Advance Preference'),
          ...List.generate(_advancedPrefs.length, (i) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _simpleCard(child: _lockedRowInner(_advancedPrefs[i])),
            );
          }),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _simpleCard({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _cardBorder, width: 1),
      ),
      child: child,
    );
  }

  Widget _prefRowInner({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(fontSize: 13, color: _labelColor)),
            Row(
              children: [
                Text(value,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: _valueColor)),
                const SizedBox(width: 2),
                const Icon(Icons.chevron_right,
                    size: 16, color: Colors.black45),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _distanceSliderInner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Maximum distance',
                  style: TextStyle(fontSize: 13, color: _labelColor)),
              Text('${_maxDistance.round()} Km',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: _valueColor)),
            ],
          ),
          const SizedBox(height: 4),
          SliderTheme(
            data: _sliderTheme(context),
            child: Slider(
              value: _maxDistance,
              min: 1,
              max: 100,
              onChanged: (v) => setState(() => _maxDistance = v),
            ),
          ),
        ],
      ),
    );
  }

  Widget _ageSliderInner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Age',
              style: TextStyle(fontSize: 13, color: _labelColor)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Min ${_ageRange.start.round()} yrs',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _valueColor)),
              Text('Max ${_ageRange.end.round()} yrs',
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _valueColor)),
            ],
          ),
          SliderTheme(
            data: _rangeSliderTheme(context),
            child: RangeSlider(
              values: _ageRange,
              min: 18,
              max: 80,
              onChanged: (v) => setState(() => _ageRange = v),
            ),
          ),
        ],
      ),
    );
  }

  Widget _heightSliderInner() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Height',
              style: TextStyle(fontSize: 13, color: _labelColor)),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Min ${_inchesToFeet(_heightRange.start)}",
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _valueColor)),
              Text("Max ${_inchesToFeet(_heightRange.end)}",
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: _valueColor)),
            ],
          ),
          SliderTheme(
            data: _rangeSliderTheme(context),
            child: RangeSlider(
              values: _heightRange,
              min: 48,
              max: 96,
              onChanged: (v) => setState(() => _heightRange = v),
            ),
          ),
        ],
      ),
    );
  }

  Widget _upgradeBanner() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _cardBorder, width: 1),
      ),
      child: Column(
        children: [
          const Text(
            'Upgrade to access advance preference filters',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: _pink, width: 1.5),
              foregroundColor: _pink,
              shape: const StadiumBorder(),
              padding:
              const EdgeInsets.symmetric(horizontal: 36, vertical: 10),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Upgrade',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: _pink),
            ),
          ),
        ],
      ),
    );
  }

  Widget _lockedRowInner(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 13, color: _labelColor)),
          Icon(Icons.lock_outline_rounded,
              size: 18, color: Colors.grey.shade400),
        ],
      ),
    );
  }

  SliderThemeData _sliderTheme(BuildContext context) {
    return SliderTheme.of(context).copyWith(
      activeTrackColor: _pink,
      inactiveTrackColor: const Color(0xFFE0E0E0),
      thumbColor: _pink,
      overlayColor: _pink.withOpacity(0.12),
      trackHeight: 3,
      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 8),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
    );
  }

  SliderThemeData _rangeSliderTheme(BuildContext context) {
    return SliderTheme.of(context).copyWith(
      activeTrackColor: _pink,
      inactiveTrackColor: const Color(0xFFE0E0E0),
      thumbColor: _pink,
      overlayColor: _pink.withOpacity(0.12),
      trackHeight: 3,
      rangeThumbShape:
      const RoundRangeSliderThumbShape(enabledThumbRadius: 8),
      overlayShape: const RoundSliderOverlayShape(overlayRadius: 16),
    );
  }
}
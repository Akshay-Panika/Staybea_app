import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class Religion extends StatefulWidget {
  const Religion({super.key});

  @override
  State<Religion> createState() => _ReligionState();
}

class _ReligionState extends State<Religion> {
  String? _selectedReligion;
  String? _selectedCommunity;

  final List<String> _religions = [
    'Hindu',
    'Muslim',
    'Christian',
    'Sikh',
    'Buddhist',
    'Jain',
    'Zoroastrian',
    'Jewish',
    'Other',
    'No Religion',
  ];

  final Map<String, List<String>> _communityMap = {
    'Hindu': [
      'Brahmin', 'Kshatriya', 'Vaishya', 'Shudra',
      'Rajput', 'Maratha', 'Lingayat', 'Other',
    ],
    'Muslim': [
      'Sunni', 'Shia', 'Sufi', 'Other',
    ],
    'Christian': [
      'Catholic', 'Protestant', 'Orthodox', 'Baptist', 'Other',
    ],
    'Sikh': [
      'Jat Sikh', 'Khatri', 'Arora', 'Ramgarhia', 'Other',
    ],
    'Buddhist': [
      'Theravada', 'Mahayana', 'Vajrayana', 'Other',
    ],
    'Jain': [
      'Digambara', 'Shvetambara', 'Other',
    ],
    'Zoroastrian': ['Parsi', 'Irani', 'Other'],
    'Jewish': ['Ashkenazi', 'Sephardi', 'Mizrahi', 'Other'],
    'Other': ['Other'],
    'No Religion': ['Not Applicable'],
  };

  List<String> get _communities =>
      _selectedReligion != null ? (_communityMap[_selectedReligion] ?? []) : [];

  void _showBottomSheet({
    required BuildContext context,
    required String title,
    required List<String> options,
    required String? selected,
    required ValueChanged<String> onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(ctx),
                      child: const Icon(Icons.close, size: 20, color: Colors.black54),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              // Options list
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.4,
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: options.length,
                  itemBuilder: (_, index) {
                    final option = options[index];
                    final isSelected = option == selected;
                    return InkWell(
                      onTap: () {
                        onSelected(option);
                        Navigator.pop(ctx);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.grey.shade100
                              : Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              option,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle_rounded,
                                size: 18,
                                color: Colors.black87,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: appSize.height * 0.02),

          Text(
            "Religion",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          SizedBox(height: appSize.height * 0.02),

          // Religion
          Text(
            "Religion",
            style: TextStyle(
              fontSize: appSize.mediumText,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Select Religion",
            selected: _selectedReligion,
            onTap: () => _showBottomSheet(
              context: context,
              title: "Select Religion",
              options: _religions,
              selected: _selectedReligion,
              onSelected: (val) {
                setState(() {
                  _selectedReligion = val;
                  _selectedCommunity = null; // reset community
                });
              },
            ),
          ),

          const SizedBox(height: 20),

          // Community
          Text(
            "Community",
            style: TextStyle(
              fontSize: appSize.mediumText,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Select Community",
            selected: _selectedCommunity,
            enabled: _selectedReligion != null,
            onTap: _selectedReligion == null
                ? null
                : () => _showBottomSheet(
              context: context,
              title: "Select Community",
              options: _communities,
              selected: _selectedCommunity,
              onSelected: (val) {
                setState(() => _selectedCommunity = val);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({
    required String hint,
    String? selected,
    VoidCallback? onTap,
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: enabled ? Colors.white : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selected ?? hint,
              style: TextStyle(
                fontSize: 14,
                color: selected != null ? Colors.black87 : Colors.grey.shade400,
              ),
            ),
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 18,
                color: enabled ? Colors.grey.shade500 : Colors.grey.shade300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
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
  bool _showReligion = false;
  bool _showCommunity = false;

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

          _buildExpandableField(
            label: "Religion",
            hint: "Select Religion",
            value: _selectedReligion,
            isOpen: _showReligion,
            onTap: () {
              setState(() {
                _showReligion = !_showReligion;
                _showCommunity = false; // close other
              });
            },
            items: _religions,
            onSelect: (val) {
              setState(() {
                _selectedReligion = val;
                _selectedCommunity = null;
                _showReligion = false;
                _showCommunity = true; // auto open community
              });
            },
          ),

          const SizedBox(height: 20),

          _buildExpandableField(
            label: "Community",
            hint: "Select Community",
            value: _selectedCommunity,
            isOpen: _showCommunity,
            enabled: _selectedReligion != null,
            onTap: () {
              if (_selectedReligion != null) {
                setState(() {
                  _showCommunity = !_showCommunity;
                  _showReligion = false;
                });
              }
            },
            items: _communities,
            onSelect: (val) {
              setState(() {
                _selectedCommunity = val;
                _showCommunity = false;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableField({
    required String label,
    required String hint,
    required String? value,
    required bool isOpen,
    required VoidCallback onTap,
    required List<String> items,
    required Function(String) onSelect,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),

        /// Main Box
        GestureDetector(
          onTap: enabled ? onTap : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: enabled ? Colors.white : Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? hint,
                    style: TextStyle(
                      fontSize: 14,
                      color: value != null
                          ? Colors.black87
                          : Colors.grey.shade400,
                    ),
                  ),
                ),
                Icon(
                  isOpen
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: enabled
                      ? Colors.grey.shade500
                      : Colors.grey.shade300,
                )
              ],
            ),
          ),
        ),

        /// Expand List
        if (isOpen)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: items.map((item) {
                final isSelected = value == item;

                return InkWell(
                  onTap: () => onSelect(item),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            style:  TextStyle(fontSize: 14,color: isSelected ? Colors.black:Colors.black54),
                          ),
                        ),

                        /// 🔘 Radio UI
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? Colors.pink
                                  : Colors.grey,
                              width: 1.5,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.pink,
                              ),
                            ),
                          )
                              : null,
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
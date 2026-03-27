import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class DreamsAndFuturePlans extends StatefulWidget {
  const DreamsAndFuturePlans({super.key});

  @override
  State<DreamsAndFuturePlans> createState() => _DreamsAndFuturePlansState();
}

class _DreamsAndFuturePlansState extends State<DreamsAndFuturePlans> {
  final int _minSelection = 3;
  final int _maxSelection = 5;
  final Set<String> _selected = {};

  // Image ke according updated list
  final List<Map<String, dynamic>> _plans = [
    {'label': 'Spiritual travel', 'icon': Icons.temple_hindu}, // Ya emoji use kar sakte hain
    {'label': 'Travel across India', 'icon': Icons.map},
    {'label': 'Start a small business', 'icon': Icons.business_center},
    {'label': 'Learn a new hobby', 'icon': Icons.lightbulb_outline},
    {'label': 'Adopt a pet', 'icon': Icons.pets},
    {'label': 'Volunteer work', 'icon': Icons.handshake},
    {'label': 'Other', 'icon': Icons.eco}, // 'Other' ke liye leaf icon
  ];

  void _toggleSelection(String label) {
    setState(() {
      if (_selected.contains(label)) {
        _selected.remove(label);
      } else if (_selected.length < _maxSelection) {
        _selected.add(label);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           SizedBox(height: appSize.height*0.02),

          // Updated Title as per image
           Text(
            "Dreams & Future Plans",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
         6.height,

          // Updated Subtitle
          Text(
            "Select $_minSelection to $_maxSelection plans to get better matches.",
            style: TextStyle(
              fontSize: appSize.mediumText,
              color: Colors.grey.shade600,
            ),
          ),

          SizedBox(height: appSize.height*0.02),

          // Grid - Image mein 2 columns dikh rahe hain
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _plans.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columns as per image
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              childAspectRatio: 1.4, // Card shape adjust karne ke liye
            ),
            itemBuilder: (context, index) {
              final item = _plans[index];
              final label = item['label'] as String;
              final icon = item['icon'] as IconData;
              final isSelected = _selected.contains(label);

              return GestureDetector(
                onTap: () => _toggleSelection(label),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFFB33771) // Image ka purple/pink border
                          : Colors.grey.shade200,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        icon,
                        size: 28,
                        color: isSelected ? const Color(0xFFB33771) : Colors.brown.shade400,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? const Color(0xFFB33771) : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),
          // Selection Counter
          Center(
            child: Text(
              "${_selected.length} / $_maxSelection selected",
              style: TextStyle(
                fontSize: 13,
                color: _selected.length >= _minSelection
                    ? Colors.green.shade600
                    : Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
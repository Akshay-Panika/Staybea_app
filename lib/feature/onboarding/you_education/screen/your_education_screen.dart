import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import 'package:staybea_app/core/widget/app_expandable_field.dart';

import '../../../../core/widget/app_input_field.dart';

class YourEducationScreen extends StatefulWidget {
  const YourEducationScreen({super.key});

  @override
  State<YourEducationScreen> createState() => _YourEducationScreenState();
}

class _YourEducationScreenState extends State<YourEducationScreen> {
  String? _selectedEducation;
  final TextEditingController _collegeController = TextEditingController();
  bool _showEducation = false;

  final List<String> _educationOptions = [
    'High School',
    'Some College',
    'Associate Degree',
    'Bachelor\'s Degree',
    'Master\'s Degree',
    'Doctoral Degree (PhD)',
    'Professional Degree (MD, JD)',
    'Diploma / Certificate',
    'Other',
  ];

  @override
  void dispose() {
    _collegeController.dispose();
    super.dispose();
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

          // Title
          Text(
            "Your Education",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          SizedBox(height: appSize.height * 0.02),

          // Highest Education
          AppExpandableField(
            label: "Your highest education",
            hint: 'Your education',
            value: _selectedEducation,
            isOpen: _showEducation,
            onTap: () {
              setState(() {
                _showEducation = !_showEducation;
              });
            },
            items: _educationOptions,
            onSelect: (val) {
              setState(() {
                _selectedEducation = val;
                _showEducation = false;
              });
            },
          ),

          const SizedBox(height: 20),

          AppInputField(
            label: 'College',
            controller: _collegeController,
            hint: 'College you attended',
            keyboardType: TextInputType.name,
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  /// Reusable expandable field like Location widget
  Widget _buildExpandableField({
    required String label,
    required String? value,
    required bool isOpen,
    required VoidCallback? onTap,
    required List<String> items,
    required AppSize appSize,
    required Function(String) onSelect,
    bool enabled = true,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:  TextStyle(
            fontSize: appSize.mediumText,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: enabled ? onTap : null,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: enabled ? Colors.white : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value ?? "Select $label",
                    style: TextStyle(
                      fontSize: appSize.mediumText,
                      color:
                      value != null ? Colors.black87 : Colors.grey.shade400,
                    ),
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: enabled ? Colors.grey.shade600 : Colors.grey.shade300,
                )
              ],
            ),
          ),
        ),
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
                            style: TextStyle(
                               fontSize: appSize.mediumText,
                                color: isSelected ? Colors.black : Colors.black54),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: isSelected ? Colors.pink : Colors.grey),
                          ),
                          child: isSelected
                              ? const Center(
                            child: CircleAvatar(
                              radius: 4,
                              backgroundColor: Colors.pink,
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
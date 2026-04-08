import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class WorkDetails extends StatefulWidget {
  const WorkDetails({super.key});

  @override
  State<WorkDetails> createState() => _WorkDetailsState();
}

class _WorkDetailsState extends State<WorkDetails> {
  String? _selectedIncomeSource;
  String? _selectedWorkingWith;
  bool _showIncomeSource = false;
  bool _showWorkingWith = false;

  final List<String> _incomeSources = [
    'Up to INR 1 lakh',
    'INR 1 lakh to 2 lakh',
    'INR 2 lakh to 4 lakh',
    'INR 4 lakh to 7 lakh',
    'INR 10 lakh to 15 lakh',
    'INR 15 lakh to 20 lakh',
    'INR 20 lakh to 30 lakh',
    'INR 30 lakh to 50 lakh',
    'INR 50 lakh to 75 lakh',
  ];

  final List<String> _workingWithOptions = [
    'Private Company',
    'Government / Public sector',
    'Defense / Civil services',
    'Business / Self employed',
    'Not working',
  ];

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: appSize.height * 0.02),

          // Title
          Text(
            "Your work details",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: appSize.height * 0.02),

          // Annual Income Dropdown
          _buildExpandableField(
            label: "Annual income",
            value: _selectedIncomeSource,
            isOpen: _showIncomeSource,
            onTap: () {
              setState(() {
                _showIncomeSource = !_showIncomeSource;
                _showWorkingWith = false;
              });
            },
            items: _incomeSources,
            onSelect: (val) {
              setState(() {
                _selectedIncomeSource = val;
                _showIncomeSource = false;
              });
            },
          ),

          const SizedBox(height: 20),

          // Working With Dropdown
          _buildExpandableField(
            label: "Working with",
            value: _selectedWorkingWith,
            isOpen: _showWorkingWith,
            onTap: () {
              setState(() {
                _showWorkingWith = !_showWorkingWith;
                _showIncomeSource = false;
              });
            },
            items: _workingWithOptions,
            onSelect: (val) {
              setState(() {
                _selectedWorkingWith = val;
                _showWorkingWith = false;
              });
            },
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildExpandableField({
    required String label,
    required String? value,
    required bool isOpen,
    required VoidCallback? onTap,
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
                      fontSize: 14,
                      color: value != null ? Colors.black87 : Colors.grey.shade400,
                    ),
                  ),
                ),
                Icon(
                  isOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: enabled ? Colors.grey.shade600 : Colors.grey.shade300,
                ),
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            item,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.black54,
                            ),
                          ),
                        ),
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: isSelected ? Colors.pink : Colors.grey),
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
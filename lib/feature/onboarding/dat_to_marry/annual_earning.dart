import 'package:flutter/material.dart';

import '../../../core/utils/app_size.dart';

class AnnualEarning extends StatefulWidget {
  const AnnualEarning({super.key});

  @override
  State<AnnualEarning> createState() => _AnnualEarningState();
}

class _AnnualEarningState extends State<AnnualEarning> {
  // Selections
  final _companyController = TextEditingController();

  String? _selectedIncome;
  String? _selectedWorkingWith;
  String? _selectedWorkingAs;

  // Toggle states
  bool _showIncome = false;
  bool _showWorkingWith = false;
  bool _showWorkingAs = false;

  final List<String> _incomeSources = [
    'Up to INR 1 lakh',
    'INR 1 lakh to 2 lakh',
    'INR 2 lakh to 4 lakh',
    'INR 4 lakh to 7 lakh',
    'INR 10 lakh to 15 lakh',
  ];

  final List<String> _workingWithOptions = [
    'Private Company',
    'Government / Public sector',
    'Defense / Civil services',
    'Business / Self employed',
    'Not working',
  ];

  final List<String> _workingAsOptions = [
    'Software Engineer',
    'Product Manager',
    'UI/UX Designer',
    'Graphic Designer',
  ];

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Annual earning",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildExpandableField(
              label: "Annual income",
              value: _selectedIncome,
              isOpen: _showIncome,
              items: _incomeSources,
              onTap: () => setState(() {
                _showIncome = !_showIncome;
                _showWorkingWith = false;
                _showWorkingAs = false;
              }),
              onSelect: (val) => setState(() {
                _selectedIncome = val;
                _showIncome = false;
              }),
            ),

            const SizedBox(height: 32),

            // --- Section: Your work details ---
            const Text(
              "Your work details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Working With
            _buildExpandableField(
              label: "Working with",
              value: _selectedWorkingWith,
              isOpen: _showWorkingWith,
              items: _workingWithOptions,
              onTap: () => setState(() {
                _showWorkingWith = !_showWorkingWith;
                _showIncome = false;
                _showWorkingAs = false;
              }),
              onSelect: (val) => setState(() {
                _selectedWorkingWith = val;
                _showWorkingWith = false;
              }),
            ),

            const SizedBox(height: 20),

            // Working As
            _buildExpandableField(
              label: "Working as",
              value: _selectedWorkingAs,
              isOpen: _showWorkingAs,
              items: _workingAsOptions,
              onTap: () => setState(() {
                _showWorkingAs = !_showWorkingAs;
                _showIncome = false;
                _showWorkingWith = false;
              }),
              onSelect: (val) => setState(() {
                _selectedWorkingAs = val;
                _showWorkingAs = false;
              }),
            ),

            const SizedBox(height: 20),

            // Company Field
            _buildInputField(
              label: 'Company',
              controller: _companyController,
              hint: 'Your company',
              icon: Icons.business_outlined,
              keyboardType: TextInputType.name,
              appSize: appSize,
            ),
          ],
        ),
      ),
    );
  }

  // Your provided helper method
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
                    value ?? "Your $label", // Adjusted to match screenshot style
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

  // Standard TextField for the Company field
  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required AppSize appSize,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style:  TextStyle(
              fontSize: appSize.mediumText,
              fontWeight: FontWeight.w500,
              color: Colors.black87
          ),
        ),
        5.height,
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFB3B3B3), width: 0.6),

          ),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style:  TextStyle(
              fontSize: appSize.mediumText,
              fontWeight: FontWeight.w400,
              color: Color(0xFF1A1A2E),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: appSize.mediumText,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w400,
              ),
              // prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }}
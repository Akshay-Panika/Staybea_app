import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class FinancialSituation extends StatefulWidget {
  const FinancialSituation({super.key});

  @override
  State<FinancialSituation> createState() => _FinancialSituationState();
}

class _FinancialSituationState extends State<FinancialSituation> {
  String? _selectedIncomeSource;
  final TextEditingController _incomeController = TextEditingController();
  bool _showIncomeSource = false;

  final List<String> _incomeSources = [
    'Salaried Employee',
    'Self Employed',
    'Business Owner',
    'Freelancer',
    'Student',
    'Retired',
    'Homemaker',
    'Not Employed',
    'Other',
  ];

  bool get _hasIncomeSource => _selectedIncomeSource != null;

  @override
  void dispose() {
    _incomeController.dispose();
    super.dispose();
  }

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
            "Financial Situation",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          SizedBox(height: appSize.height * 0.02),

          // Income Source Field
          _buildExpandableField(
            label: "Income Source",
            value: _selectedIncomeSource,
            isOpen: _showIncomeSource,
            onTap: () {
              setState(() {
                _showIncomeSource = !_showIncomeSource;
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

          // Annual Income Field
          const Text(
            "Annual Income (Optional)",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _incomeController,
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
            decoration: InputDecoration(
              hintText: "Enter your annual income",
              hintStyle: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade400,
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade400, width: 1),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
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
                      color:
                      value != null ? Colors.black87 : Colors.grey.shade400,
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
                    padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
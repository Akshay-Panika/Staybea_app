import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class Lifestyle extends StatefulWidget {
  const Lifestyle({super.key});

  @override
  State<Lifestyle> createState() => _LifestyleState();
}

class _LifestyleState extends State<Lifestyle> {
  String? _selectedSmoke;
  String? _selectedDrink;
  String? _selectedDiet;

  bool _showSmoke = false;
  bool _showDrink = false;
  bool _showDiet = false;

  final List<String> _smokeOptions = [
    'Non Smoker',
    'Light Smoker',
    'Moderate Smoker',
    'Heavy Smoker',
    'Trying to Quit',
  ];

  final List<String> _drinkOptions = [
    'Non Drinker',
    'Social Drinker',
    'Moderate Drinker',
    'Heavy Drinker',
    'Trying to Quit',
  ];

  final List<String> _dietOptions = [
    'Vegetarian',
    'Non Vegetarian',
    'Vegan',
    'Eggetarian',
    'Jain',
    'Halal',
    'Kosher',
    'Other',
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
            "Lifestyle",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          SizedBox(height: appSize.height * 0.02),

          // Smoke
          _buildExpandableField(
            label: "Do you smoke?",
            value: _selectedSmoke,
            isOpen: _showSmoke,
            onTap: () {
              setState(() {
                _showSmoke = !_showSmoke;
                _showDrink = false;
                _showDiet = false;
              });
            },
            items: _smokeOptions,
            onSelect: (val) {
              setState(() {
                _selectedSmoke = val;
                _showSmoke = false;
              });
            },
          ),

          const SizedBox(height: 20),

          // Drink
          _buildExpandableField(
            label: "Do you drink?",
            value: _selectedDrink,
            isOpen: _showDrink,
            onTap: () {
              setState(() {
                _showDrink = !_showDrink;
                _showSmoke = false;
                _showDiet = false;
              });
            },
            items: _drinkOptions,
            onSelect: (val) {
              setState(() {
                _selectedDrink = val;
                _showDrink = false;
              });
            },
          ),

          const SizedBox(height: 20),

          // Diet
          _buildExpandableField(
            label: "Diet",
            value: _selectedDiet,
            isOpen: _showDiet,
            onTap: () {
              setState(() {
                _showDiet = !_showDiet;
                _showSmoke = false;
                _showDrink = false;
              });
            },
            items: _dietOptions,
            onSelect: (val) {
              setState(() {
                _selectedDiet = val;
                _showDiet = false;
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
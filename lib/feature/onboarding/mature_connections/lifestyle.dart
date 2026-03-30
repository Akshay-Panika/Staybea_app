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
              Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
                      child: const Icon(Icons.close,
                          size: 20, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
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
                            horizontal: 20, vertical: 14),
                        color: isSelected
                            ? Colors.grey.shade100
                            : Colors.white,
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
           SizedBox(height: appSize.height*0.02),

          // Title
           Text(
            "Lifestyle",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),

          SizedBox(height: appSize.height*0.02),

          // Do you smoke?
          _buildLabel("Do you smoke?"),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Do you smoke?",
            selected: _selectedSmoke,
            onTap: () => _showBottomSheet(
              context: context,
              title: "Do you smoke?",
              options: _smokeOptions,
              selected: _selectedSmoke,
              onSelected: (val) => setState(() => _selectedSmoke = val),
            ),
          ),

          const SizedBox(height: 20),

          // Do you Drink?
          _buildLabel("Do you Drink?"),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Do you Drink?",
            selected: _selectedDrink,
            onTap: () => _showBottomSheet(
              context: context,
              title: "Do you Drink?",
              options: _drinkOptions,
              selected: _selectedDrink,
              onSelected: (val) => setState(() => _selectedDrink = val),
            ),
          ),

          const SizedBox(height: 20),

          // Diet
          _buildLabel("Diet"),
          const SizedBox(height: 8),
          _buildDropdownField(
            hint: "Select Diet",
            selected: _selectedDiet,
            onTap: () => _showBottomSheet(
              context: context,
              title: "Diet",
              options: _dietOptions,
              selected: _selectedDiet,
              onSelected: (val) => setState(() => _selectedDiet = val),
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
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
          color: Colors.white,
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
                color: selected != null
                    ? Colors.black87
                    : Colors.grey.shade400,
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
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
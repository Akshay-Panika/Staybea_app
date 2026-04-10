import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import 'package:staybea_app/core/widget/app_expandable_field.dart';

class YourLifestyleScreen extends StatefulWidget {
  const YourLifestyleScreen({super.key});

  @override
  State<YourLifestyleScreen> createState() => _YourLifestyleScreenState();
}

class _YourLifestyleScreenState extends State<YourLifestyleScreen> {
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
          AppExpandableField(
            label: "Do you smoke?",
            hint: "Do you smoke?",
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
          AppExpandableField(
            label: "Do you drink?",
            hint: "Do you drink?",
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
          AppExpandableField(
            label: "Diet",
            hint: "Select Diet",
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
}
import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import 'package:staybea_app/core/widget/app_expandable_field.dart';

class YourWorkScreen extends StatefulWidget {
  const YourWorkScreen({super.key});

  @override
  State<YourWorkScreen> createState() => _YourWorkScreenState();
}

class _YourWorkScreenState extends State<YourWorkScreen> {
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
          AppExpandableField(
            label: "Annual income",
            hint: 'Your Annual income',
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
          AppExpandableField(
            label: "Working with",
            hint: "You working with",
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
}
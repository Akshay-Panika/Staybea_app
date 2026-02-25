import 'package:flutter/material.dart';

class GenderStepWidget extends StatefulWidget {
  const GenderStepWidget({super.key});

  @override
  State<GenderStepWidget> createState() => _GenderStepWidgetState();
}

class _GenderStepWidgetState extends State<GenderStepWidget> {
  String _selectedGender = "Man";

  final genders = [
    "Man",
    "Women",
    "Non-Binary",
    "Prefer not to say",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Select Your Gender",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(height: 10),

        ...genders.map((gender) {
          final isSelected = _selectedGender == gender;

          return InkWell(
            onTap: () {
              setState(() => _selectedGender = gender);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
              color: isSelected
                  ? Colors.grey.shade50
                  : Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      gender,
                      style: TextStyle(
                        fontSize: 18,
                        color: isSelected ? Colors.blue : Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check, color: Colors.blue)
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

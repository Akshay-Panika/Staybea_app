import 'package:flutter/material.dart';

class SexualStepWidget extends StatefulWidget {
  const SexualStepWidget({super.key});

  @override
  State<SexualStepWidget> createState() => _SexualStepWidgetState();
}

class _SexualStepWidgetState extends State<SexualStepWidget> {
  String _selectedOrientation = "Straight";

  final options = [
    "Straight",
    "Gay",
    "Lesbian",
    "Bisexual",
    "Asexual",
    "Demisexual",
    "Pansexual",
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Select your Sexual Orientation ?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        const SizedBox(height: 10),

        ...options.map((item) {
          final isSelected = _selectedOrientation == item;

          return InkWell(
            onTap: () {
              setState(() => _selectedOrientation = item);
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
                      item,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                  if (isSelected)
                    const Icon(Icons.check, color: Colors.blue),
                ],
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}

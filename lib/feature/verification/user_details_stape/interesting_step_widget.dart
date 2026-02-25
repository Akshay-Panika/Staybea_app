import 'package:flutter/material.dart';
import 'package:staybea_app/core/constant/App_color.dart';

class InterestingStepWidget extends StatefulWidget {
  const InterestingStepWidget({super.key});

  @override
  State<InterestingStepWidget> createState() => _InterestingStepWidgetState();
}

class _InterestingStepWidgetState extends State<InterestingStepWidget> {

  String _selectedInterest = "Women";

  final items = [
    {
      "title": "Women",
      "image": "assets/auth/women.png",
      "color": const Color(0xFFF9F3FE),
    },
    {
      "title": "Man",
      "image": "assets/auth/man.png",
      "color": const Color(0xFFFFFBED),
    },
    {
      "title": "Everyone",
      "image": "assets/auth/everyone.png",
      "color": const Color(0xFFFFEDDC),
    },
  ];


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Who are you interesting in seeing for an Date ?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),

          ...items.map((item) {
            final isSelected = _selectedInterest == item["title"];

            return GestureDetector(
              onTap: () {
                setState(() => _selectedInterest = item["title"] as String);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 90,
                decoration: BoxDecoration(
                  color: item["color"] as Color,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: isSelected ? Colors.grey:Colors.transparent,width: 0.3)
                ),
                child: Row(
                  children: [
                    Image.asset(
                      item["image"] as String,
                      height: 70,
                    ),
                    const Spacer(),
                    Text(
                      item["title"] as String,
                      style:  TextStyle(
                        fontSize: 18,
                        color: isSelected? AppColors.primary:Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

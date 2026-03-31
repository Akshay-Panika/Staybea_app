import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class YouLove extends StatefulWidget {
  const YouLove({super.key});

  @override
  State<YouLove> createState() => _YouLoveState();
}

class _YouLoveState extends State<YouLove> {
  final List<String> communicationOptions = [
    "Poetry",
    "Sneakers",
    "Freelancing",
    "Photography",
    "Choir",
    "Cosplay",
    "Content Creation",
    "Vintage Fashion",
    "Investing",
    "Signing",
    "Language Exchange",
    "Writing",
    "Literature",
    "NFTs",
    "Tattoos",
    "Painting",
    "Upcycling",
    "Entrepreneurship",
    "Acapella",
    "Musical Instrument",
    "Musical Writing",
  ];

  final List<String> _selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Things You Love.",
            style: TextStyle(fontSize: appSize.largeText, fontWeight: FontWeight.w700),
          ),
          6.height,
          Text(
            "List up to 10 interests to get better matches.",
            style: TextStyle(fontSize: appSize.mediumText, color: Colors.grey),
          ),
          SizedBox(height: appSize.height * 0.02),

          /// CREATIVITY CARD
          _mattersCard(
            icon: "💬",
            title: "Creativity",
            options: communicationOptions,
            selectedValues: _selectedInterests,
            onSelect: (val) {
              setState(() {
                if (_selectedInterests.contains(val)) {
                  _selectedInterests.remove(val);
                } else {
                  if (_selectedInterests.length < 10) {
                    _selectedInterests.add(val);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("You can select up to 10 interests only")),
                    );
                  }
                }
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _mattersCard({
    required String icon,
    required String title,
    required List<String> options,
    required List<String> selectedValues,
    required Function(String) onSelect,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF3EDF7),
            Colors.white,
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 20)),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: options.map((option) {
              final isSelected = selectedValues.contains(option);
              return GestureDetector(
                onTap: () => onSelect(option),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.pink : Colors.grey.shade300,
                    ),
                    // color: isSelected ? Colors.pink.shade100 : Colors.white,
                  ),
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.pink.shade800 : Colors.black87,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
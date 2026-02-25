import 'package:flutter/material.dart';

class LifestyleWidget extends StatefulWidget {
  const LifestyleWidget({super.key});

  @override
  State<LifestyleWidget> createState() => _LifestyleWidgetState();
}

class _LifestyleWidgetState extends State<LifestyleWidget> {
  final drinkOptions = [
    "Not for me",
    "Newly teetotal",
    "Sober curious",
    "On special occasions",
    "Socially, at the weekend",
    "Most nights",
  ];

  final smokeOptions = [
    "Social Smoker",
    "Smoker with drinking",
    "Non-smoker",
    "Smoker",
    "Trying to quit",
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Let’s Talk Lifestyle",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            "Habits meet harmony. You go first.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          /// DRINK CARD
          _lifestyleCard(
            icon: "🍾",
            title: "How often do you drink?",
            options: drinkOptions,
          ),

          const SizedBox(height: 16),

          /// SMOKE CARD
          _lifestyleCard(
            icon: "🚬",
            title: "How often do you smoke?",
            options: smokeOptions,
          ),
        ],
      ),
    );
  }
  Widget _lifestyleCard({
    required String icon,
    required String title,
    required List<String> options,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          Color(0xFFF3EDF7),
          Colors.white,
        ])
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
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: options
                .map(
                  (e) => Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.white,
                ),
                child: Text(
                  e,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            )
                .toList(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class LookingStepWidget extends StatefulWidget {
  const LookingStepWidget({super.key});

  @override
  State<LookingStepWidget> createState() => _LookingStepWidgetState();
}

class _LookingStepWidgetState extends State<LookingStepWidget> {
  final items = [
    {"title": "Looking for marriage", "emoji": "❤️"},
    {"title": "Long terms but short term ok", "emoji": "😍"},
    {"title": "Short-term but long-term ok", "emoji": "🥂"},
    {"title": "Short term fun", "emoji": "🌟"},
    {"title": "New friends", "emoji": "🤝"},
    {"title": "Still figuring it", "emoji": "🙄"},
  ];

  int? selectedIndex; // optional: for UI highlight

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What are you Looking for ?",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = items[index];

              return GestureDetector(
                onTap: () {
                  print("Selected index: $index");
                  setState(() {
                    selectedIndex = index; // optional: for UI highlight
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? const Color(0xFFA54275).withOpacity(0.2)
                        : const Color(0xFFFFF5FF),
                    borderRadius: BorderRadius.circular(20),
                    border: selectedIndex == index
                        ? Border.all(color: const Color(0xFFA54275), width: 1)
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        item['emoji']!,
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item['title']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class YouMatters extends StatefulWidget {
  const YouMatters({super.key});

  @override
  State<YouMatters> createState() => _YouMattersState();
}

class _YouMattersState extends State<YouMatters> {
  final communicationOptions = [
    "I stay WhatsApp all day",
    "Big time texter",
    "Phone caller",
    "Video chatter",
    "I’m slow to answer on whatsapp",
    "Bad texter",
    "Better in person",
  ];

  final loveOptions = [
    "Thoughtful gestures",
    "Presents",
    "Touch",
    "Compliments",
    "Time together",
  ];

  // Track selected options
  final List<String> _selectedCommunication = [];
  final List<String> _selectedLove = [];

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "The real you matters.",
            style: TextStyle(fontSize: appSize.largeText, fontWeight: FontWeight.w700),
          ),
          6.height,
          Text(
            "Don’t hold back. The right person will appreciate you",
            style: TextStyle(fontSize: appSize.mediumText, color: Colors.grey),
          ),
          SizedBox(height: appSize.height * 0.02),

          /// COMMUNICATION CARD
          _mattersCard(
            icon: "💬",
            title: "What’s your communication style?",
            options: communicationOptions,
            selectedValues: _selectedCommunication,
            onSelect: (val) {
              setState(() {
                _selectedCommunication.contains(val)
                    ? _selectedCommunication.remove(val)
                    : _selectedCommunication.add(val);
              });
            },
          ),

          const SizedBox(height: 16),

          /// LOVE LANGUAGE CARD
          _mattersCard(
            icon: "💗",
            title: "How do you receive love",
            options: loveOptions,
            selectedValues: _selectedLove,
            onSelect: (val) {
              setState(() {
                _selectedLove.contains(val)
                    ? _selectedLove.remove(val)
                    : _selectedLove.add(val);
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
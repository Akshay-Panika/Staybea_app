import 'package:flutter/material.dart';

class MattersWidget extends StatefulWidget {
  const MattersWidget({super.key});

  @override
  State<MattersWidget> createState() => _MattersWidgetState();
}

class _MattersWidgetState extends State<MattersWidget> {

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "The real you matters.",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            "Don’t hold back. The right person will appreciate you",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 20),

          /// COMMUNICATION CARD
          _mattersCard(
            icon: "💬",
            title: "What’s your communication style?",
            options: communicationOptions,
          ),

          const SizedBox(height: 16),

          /// LOVE LANGUAGE CARD
          _mattersCard(
            icon: "💗",
            title: "How do you receive love",
            options: loveOptions,
          ),
        ],
      ),
    );
  }
  Widget _mattersCard({
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

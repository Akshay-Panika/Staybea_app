import 'package:flutter/material.dart';

class AboutYourselfWidget extends StatelessWidget {
  const AboutYourselfWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Share more about yourself",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          const Text(
            "Write a bio and a prompt to help your profile stand out spark conversations.",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 24),

          /// About me card
          _infoCard(
            title: "About me",
            subtitle: "Add more Information to stand out your profile",
            onTap: () {},
          ),

          const SizedBox(height: 20),

          /// Prompt card
          _infoCard(
            title: "Choose a Prompt to Answer",
            subtitle: "Add more Information to stand out your profile",
            onTap: () {},
          ),
        ],
      ),
    );
  }
  Widget _infoCard({
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text(subtitle,
                  style: const TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),

        /// plus button
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 34,
              width: 34,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFA54275),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
          ),
        )
      ],
    );
  }
}

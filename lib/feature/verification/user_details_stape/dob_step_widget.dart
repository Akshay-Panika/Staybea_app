import 'package:flutter/material.dart';

class DobStepWidget extends StatelessWidget {
  const DobStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE ROW
          Row(
            children: const [
              Text("🎂", style: TextStyle(fontSize: 28)),
              SizedBox(width: 8),
              Text(
                "Your b-day?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// INPUT BOXES
          Row(
            children: [
              _dobBox("DD"),
              const SizedBox(width: 12),
              _dobBox("MM"),
              const SizedBox(width: 12),
              Expanded(child: _dobBox("YYYY")),
            ],
          ),

          const SizedBox(height: 16),

          /// DESCRIPTION
          const Text(
            "Give a chance to your partner she will wish you on your moment",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

Widget _dobBox(String hint) {
  return Container(
    width: hint == "YYYY" ? double.infinity : 80,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: TextField(
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hint,
        border: InputBorder.none,
      ),
    ),
  );
}
import 'package:flutter/material.dart';

class NameStepWidget extends StatelessWidget {
  const NameStepWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// TITLE
          Row(
            children: const [
              Icon(Icons.star, size: 32, color: Colors.amber),
              SizedBox(width: 8),
              Text(
                "What's your name?",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// TEXTFIELD
          TextField(
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            decoration: const InputDecoration(
              hintText: "Enter Your Name",
              isDense: true,                 // height kam
              contentPadding: EdgeInsets.zero, // padding remove
              border: InputBorder.none,
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ),

          const SizedBox(height: 6),

          /// UNDERLINE
          Container(
            height: 1,
            width: double.infinity,
            color: Colors.grey.shade400,
          ),

          const SizedBox(height: 18),

          /// DESCRIPTION
          const Text(
            "Decide what your partner should call you",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}

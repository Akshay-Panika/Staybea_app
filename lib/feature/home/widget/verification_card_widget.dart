import 'package:flutter/material.dart';

class VerificationCardWidget extends StatelessWidget {
  final double progress; // 0.0 → 1.0

  const VerificationCardWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF1F1F1),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// -------- CIRCLE PROGRESS --------
          SizedBox(
            width: 42,
            height: 42,
            child: Stack(
              alignment: Alignment.center,
              children: [

                CircularProgressIndicator(
                  value: 1,
                  strokeWidth: 5,
                  color: Colors.grey.shade300,
                ),

                CircularProgressIndicator(
                  value: progress,
                  color: Colors.blue,
                  strokeWidth: 5,
                ),

                const Icon(
                  Icons.verified_user_outlined,
                  size: 18,
                  color: Colors.blue,
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),

          /// -------- PERCENT --------
          Text(
            "${(progress * 100).toInt()}%",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
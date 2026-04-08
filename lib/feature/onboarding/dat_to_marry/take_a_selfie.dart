import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class TakeASelfie extends StatefulWidget {
  const TakeASelfie({super.key});

  @override
  State<TakeASelfie> createState() => _TakeASelfieState();
}

class _TakeASelfieState extends State<TakeASelfie> {
  // Added the missing state variable
  bool _biometricConsent = false;

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    final tips = [
      (Icons.sentiment_satisfied_alt_outlined, 'Show your face clearly'),
      (Icons.wb_sunny_outlined, 'Use good lighting'),
      (Icons.camera_alt_outlined, 'Look straight at the camera'),
      (Icons.face_retouching_off_outlined, 'Remove sunglasses & hats'),
    ];

    // Using SingleChildScrollView prevents "RenderBox was not laid out" errors
    // when the keyboard opens or on smaller screen sizes.
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: appSize.height * 0.02),

          // Camera icon placeholder
          Center(
            child: GestureDetector(
              onTap: () {
                // TODO: Link your _clickImage() function here
              },
              child: Container(
                width: appSize.height * 0.15,
                height: appSize.height * 0.15,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: const Center(
                  child: Icon(
                    Icons.crop_free_rounded,
                    size: 48,
                    color: Colors.black87,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: appSize.height * 0.03),

          // Title Section
          Text(
            "Take a selfie",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Take a selfie to verify your identity.",
            style: TextStyle(
              fontSize: appSize.mediumText,
              color: Colors.grey.shade600,
            ),
          ),

          SizedBox(height: appSize.height * 0.03),

          // Tips card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: tips.map((tip) {
                final isLast = tip == tips.last;
                return Column(
                  children: [
                    Row(
                      children: [
                        Icon(tip.$1, size: 22, color: Colors.black87),
                        const SizedBox(width: 14),
                        Text(
                          tip.$2,
                          style: TextStyle(
                            fontSize: appSize.mediumText,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    if (!isLast)
                      Divider(
                        height: 24,
                        color: Colors.grey.shade200,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),

          SizedBox(height: appSize.height * 0.05),

          // Consent Section
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    activeColor: const Color(0xFFA54275), // Matching your app theme color
                    value: _biometricConsent,
                    onChanged: (val) {
                      setState(() {
                        _biometricConsent = val ?? false;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    side: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "I consent to Bureau to process and store my biometrics data to verify my identity and prevent fraud.",
                    style: TextStyle(
                      fontSize: appSize.mediumText,
                      color: Colors.black87,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
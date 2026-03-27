import 'package:flutter/material.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import '../../../core/constant/app_icon.dart';
import 'mobile_number_verify_screen.dart';

class SelectLanguageScreen extends StatefulWidget {
  const SelectLanguageScreen({super.key});

  @override
  State<SelectLanguageScreen> createState() =>
      _SelectLanguageScreenState();
}

class _SelectLanguageScreenState extends State<SelectLanguageScreen> {

  int selectedIndex = 0;

  final List<Map<String, String>> languages = [
    {"title": "English", "subtitle": "English"},
    {"title": "Hindi", "subtitle": "हिंदी"},
    {"title": "Marathi", "subtitle": "मराठी"},
    {"title": "Gujarati", "subtitle": "ગુજરાતી"},
    {"title": "Tamil", "subtitle": "தமிழ்"},
    {"title": "Urdu", "subtitle": "اردو"},
    {"title": "Malayalam", "subtitle": "മലയാളം"},
  ];

  Widget languageTile(int index) {
    final lang = languages[index];
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding:
        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? AppColors.secondary
                : Colors.grey.shade300,
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              lang["title"]!,
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              lang["subtitle"]!,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Please select a language to proceed.",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 20),

              // Dynamic List
              ...List.generate(
                  languages.length,
                      (index) => languageTile(index)),

              const Spacer(),

              _socialButton(
                iconPath: AppIcon.phone,
                text: "Next",
                onTap: () {
                  print("Selected: ${languages[selectedIndex]["title"]}");

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MobileNumberVerifyScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton({
    required String iconPath,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFFA54275),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.primary),
        ),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
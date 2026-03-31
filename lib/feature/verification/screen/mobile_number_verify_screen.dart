import 'package:flutter/material.dart';
import '../../google/translation_service.dart';
import 'otp_verify_screen.dart';

class MobileNumberVerifyScreen extends StatelessWidget {
  const MobileNumberVerifyScreen({super.key});

  Future<Map<String, String>> getTranslations() async {
    final t = TranslationService();

    return {
      "back": await t.translate("Back"),
      "title": await t.translate(
          "Fill your mobile number, we connect you with our services."),
      "hint": await t.translate("Phone number"),
      "desc": await t.translate(
          "We’ll text you a code to verify you’re really you. Message and data rates may apply."),
      "btn": await t.translate("Verify Number"),
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: getTranslations(),
      builder: (context, snapshot) {

        /// 🔄 Loader
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final t = snapshot.data!;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),

                /// 🔙 Back
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.arrow_back),
                        const SizedBox(width: 10),
                        Text(
                          t["back"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Title
                Text(
                  t["title"]!,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 40),

                /// Phone Input
                Row(
                  children: [
                    Column(
                      children: [
                        const Text(
                          '+91',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        ),
                        Container(
                          height: 1,
                          width: 50,
                          color: Colors.grey,
                        ),
                      ],
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: t["hint"],
                              border: InputBorder.none,
                              isCollapsed: true,
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                          Container(height: 1, color: Colors.grey),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Description
                Text(
                  t["desc"]!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const Spacer(),

                /// Button
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const OtpVerifyScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA54275),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        t["btn"]!,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
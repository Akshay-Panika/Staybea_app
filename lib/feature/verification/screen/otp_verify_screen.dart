import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'location_allow_screen.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {

  final List<TextEditingController> controllers =
  List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
  List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    for (var f in focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  Widget otpBox(int index) {
    return SizedBox(
      width: 45,
      child: TextField(
        controller: controllers[index],
        focusNode: focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: "",
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.zero, // spacing 0
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            // next field
            if (index < 5) {
              FocusScope.of(context).requestFocus(focusNodes[index + 1]);
            } else {
              focusNodes[index].unfocus();
            }
          } else {
            // back field on delete
            if (index > 0) {
              FocusScope.of(context).requestFocus(focusNodes[index - 1]);
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),

            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back),
                        SizedBox(width: 10),
                        Text(
                          'Back',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Text(
              'Enter Your Verification Code',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),

            const Text(
              '+91 898207770',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),

            const SizedBox(height: 40),

            /// 🔥 OTP BOXES
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => otpBox(index)),
            ),

            const SizedBox(height: 40),

            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  const TextSpan(
                    text:
                    "Still not get verification code? No worries, let’s try again ",
                  ),
                  TextSpan(
                    text: "Resend",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        // resend logic
                      },
                  ),
                ],
              ),
            ),

            const Spacer(),

            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LocationAllowScreen(),));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFA54275),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Text(
                    'Verify OTP',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
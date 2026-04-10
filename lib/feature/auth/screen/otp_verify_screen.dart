import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import '../../../core/widget/app_button.dart';
import '../../google/translation_service.dart';
import '../../location/screen/location_allow_screen.dart';

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

  /// 🔥 Translation Future
  Future<Map<String, String>> getTranslations() async {
    final t = TranslationService();

    return {
      "back": await t.translate("Back"),
      "title": await t.translate("Enter Your Verification Code"),
      "desc": await t.translate(
          "Still not get verification code? No worries, let’s try again "),
      "resend": await t.translate("Resend"),
      "btn": await t.translate("Verify OTP"),
    };
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
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 5) {
              FocusScope.of(context)
                  .requestFocus(focusNodes[index + 1]);
            } else {
              focusNodes[index].unfocus();
            }
          } else {
            if (index > 0) {
              FocusScope.of(context)
                  .requestFocus(focusNodes[index - 1]);
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return FutureBuilder<Map<String, String>>(
      future: getTranslations(),
      builder: (context, snapshot) {

        /// 🔄 Loader (no glitch)
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
                        Icon(Icons.arrow_back_ios,size: appSize.mediumText,color: Colors.grey,),
                        // const SizedBox(width: 10),
                        Text(
                          t["back"]!,
                          style:  TextStyle(
                            fontSize: appSize.mediumText,
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
                  style:  TextStyle(
                      fontSize: appSize.largeText, fontWeight: FontWeight.w700),
                ),

                 Text(
                  '+91 898207770',
                  style: TextStyle(
                      fontSize: appSize.mediumText,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey),
                ),

                const SizedBox(height: 40),

                /// OTP Boxes
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children:
                  List.generate(6, (index) => otpBox(index)),
                ),

                const SizedBox(height: 40),

                /// Resend Text
                RichText(
                  text: TextSpan(
                    style:  TextStyle(
                      fontSize: appSize.smallText,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(text: t["desc"]),
                      WidgetSpan(child: SizedBox(width: 5)),
                      TextSpan(
                        text: t["resend"],
                        style:  TextStyle(
                          color: AppColors.secondary,
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

                /// Button
                AppButton(
                  text: t["btn"]!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            LocationAllowScreen(),
                      ),
                    );
                  },
                  bColor: AppColors.secondary,
                  tColor: Colors.white,
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
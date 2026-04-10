import 'package:flutter/material.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import 'package:staybea_app/core/constant/app_icon.dart';
import 'package:staybea_app/core/utils/app_logo.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import '../../../core/widget/app_button.dart';
import '../../google/translation_service.dart';
import 'number_verify_screen.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  Future<Map<String, String>> getTranslations() async {
    final t = TranslationService();

    return {
      "terms": await t.translate(
          "By tapping ‘Continue’ you agree to our Terms. Learn how we process your data in your Privacy Policy and Cookies Policy"),
      "phoneBtn":
      await t.translate("Continue with Phone Number"),
    };
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    return FutureBuilder<Map<String, String>>(
      future: getTranslations(),
      builder: (context, snapshot) {

        /// 🔄 Loader
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final t = snapshot.data!;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [

                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _imageCard(
                                  height: 150,
                                  img:
                                  'assets/auth/auth_img1.jpg'),
                              const SizedBox(height: 10),
                              Expanded(
                                  child: _imageCard(
                                      img:
                                      'assets/auth/auth_img3.jpg')),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              _imageCard(
                                  height: 250,
                                  img:
                                  'assets/auth/auth_img2.jpg'),
                              const SizedBox(height: 10),
                              Expanded(
                                  child: _imageCard(
                                      img:
                                      'assets/auth/auth_img4.jpg')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                 60.height,

                  /// 🔥 Logo
                  Image.asset(AppLogo.appLogo, height: 40),

                  30.height,

                  /// 🌐 Translated Terms Text
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                   child: Column(
                     children: [
                       Text(
                         t["terms"]!,
                         textAlign: TextAlign.center,
                         style:  TextStyle(
                             fontSize: appSize.mediumText,
                             color: Colors.black87),
                       ),

                       50.height,


                       /// 📱 Button
                       AppButton(
                         text:  t["phoneBtn"]!,
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (_) =>
                               const NumberVerifyScreen(),
                             ),
                           );
                         },
                         bColor: AppColors.secondary,
                         tColor: Colors.white,
                         borderRadius:20,
                       ),
                     ],
                   ),
                 ),

                  50.height,

                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _imageCard({double? height, String? img}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: AssetImage(img.toString()),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

}
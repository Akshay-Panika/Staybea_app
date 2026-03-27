import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import 'package:staybea_app/core/constant/app_icon.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:staybea_app/core/utils/app_logo.dart';

import 'mobile_number_verify_screen.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({super.key});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {


  GoogleSignInAccount? _googleUser;
  Map<String, dynamic>? _facebookUser;

  /// Google Auth
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  Future<void> _signInWithGoogle() async {
    try {
      final user = await _googleSignIn.signIn();
      if (user == null) {
        print("Google login cancelled");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Google login cancelled")),
        );
        return;
      }

      setState(() => _googleUser = user);

      // Print user data
      print("Google user: $user");
      print("Name: ${user.displayName}");
      print("Email: ${user.email}");
      print("Photo URL: ${user.photoUrl}");
    } catch (e) {
      print("Google Sign-In Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Error: $e")),
      );
    }
  }

  /// Facebook Auth
  Future<void> _signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.instance.getUserData();
        setState(() => _facebookUser = userData);

        print("Facebook user data: $_facebookUser");
      } else if (result.status == LoginStatus.cancelled) {
        print("Facebook login cancelled by user");
      } else {
        print("Facebook login failed: ${result.message}");
      }
    } catch (e) {
      print("Facebook Sign-In Error: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                spacing: 10,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              _imageCard(height: 150, img: 'assets/auth/auth_img1.jpg'), // fixed height
                              const SizedBox(height: 10),
                              Expanded(child: _imageCard(img: 'assets/auth/auth_img3.jpg')), // flexible
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              _imageCard(height: 250, img: 'assets/auth/auth_img2.jpg'),
                              const SizedBox(height: 10),
                              Expanded(child: _imageCard(img: 'assets/auth/auth_img4.jpg')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      const SizedBox(height: 22),
                      Image.asset(AppLogo.appLogo,height: 40,),


                      const SizedBox(height: 14),

                      /// TERMS TEXT
                      const Text(
                        "By tapping ‘Continue’ you agree to our Terms.\n"
                            "Learn how we process your data in your\n"
                            "Privacy Policy and Cookies Policy",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      SizedBox(height: 50,),
                      // _socialButton(
                      //  iconPath: AppIcon.google,
                      //   text: "Continue with Google",
                      //   onTap: _signInWithGoogle,
                      // ),
                      // const SizedBox(height: 12),
                      // _socialButton(
                      //   iconPath: AppIcon.facebook,
                      //   text: "Continue with Facebook",
                      //   onTap: _signInWithFacebook,
                      // ),
                      const SizedBox(height: 12),
                      _socialButton(
                        iconPath: AppIcon.phone,
                        text: "Continue with Phone Number",
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:  (context) => MobileNumberVerifyScreen(),));
                        },
                      ),
                      SizedBox(height: 50,)
                    ],
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _imageCard({double? height, String? img}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(image: AssetImage(img.toString()),fit: BoxFit.cover)
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
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: AppColors.primary),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconPath,
              height: 22,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style:  TextStyle(fontSize: 16,fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}


class ThreeDotsLoader extends StatefulWidget {
  const ThreeDotsLoader({super.key});

  @override
  State<ThreeDotsLoader> createState() => _ThreeDotsLoaderState();
}

class _ThreeDotsLoaderState extends State<ThreeDotsLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 20,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) {
          return Row(

            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(3, (index) {
              double delay = index * 0.2;
              double value = (_controller.value + delay) % 1;

              /// bounce curve
              double offset = (value < 0.5)
                  ? value * 12
                  : (1 - value) * 12;

              return Transform.translate(
                offset: Offset(0, -offset),
                child: const CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.black,
                ),
              );
            }),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

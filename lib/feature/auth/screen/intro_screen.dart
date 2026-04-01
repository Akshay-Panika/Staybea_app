import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:staybea_app/core/constant/App_color.dart';
import 'package:staybea_app/core/utils/app_size.dart';
import 'language_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, dynamic>> pages = [
    {
      "img": "assets/intro/intro1.json",
      "title": "Date to Marry",
      "description":
      "Find your true life partner. Every step is genuine, verified, and built on trust — because forever starts here.",
    },
    {
      "img": "assets/intro/intro2.json",
      "title": "Meaningful Connections",
      "description":
      "Explore genuine connections at your own pace. Meet real people, spark chemistry, and enjoy the journey of love.",
    },
    {
      "img": "assets/intro/Intro3.json",
      "title": "Your Perfect Match Awaits",
      "description":
      "Deep, experienced companionship for life's next chapter. Build heartfelt bonds that stand the test of time.",
    },
  ];

  void nextPage() {
    if (currentIndex < pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      goToVerification();
    }
  }

  void skip() => goToVerification();

  void goToVerification() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const LanguageScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);
    final isLast = currentIndex == pages.length - 1;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              onPageChanged: (i) => setState(() => currentIndex = i),
              itemBuilder: (context, index) {
                final data = pages[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // ── Illustration Area ──────────────────────
                    Container(
                      height: appSize.height * 0.50,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(24),
                        child: Lottie.asset(
                          data['img'] as String,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) =>  Center(
                            child: Icon(Icons.favorite_rounded,
                                size: 100, color: AppColors.secondary),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 36),

                    // ── Title ──────────────────────────────────
                    Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        data['title'] as String,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: appSize.extraLargeText,
                          fontWeight: FontWeight.bold,
                          color: AppColors.secondary,
                          height: 1.2,
                        ),
                      ),
                    ),

                   14.height,

                    // ── Description ────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 36),
                      child: Text(
                        data['description'] as String,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          fontSize: appSize.mediumText,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade600,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            // ── Skip button (top-right) ─────────────────────────
            if (currentIndex < pages.length - 1)
              Positioned(
                top: 12,
                right: 20,
                child: GestureDetector(
                  onTap: skip,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Skip",
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

            // ── Bottom Controls ──────────────────────────────────
            Positioned(
              bottom: 36,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Dot Indicators
                    Row(
                      children: List.generate(
                        pages.length,
                            (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: currentIndex == i ? 24 : 8,
                          decoration: BoxDecoration(
                            color: currentIndex == i
                                ? AppColors.secondary
                                : AppColors.secondary.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),

                    // Arrow / Done button
                    GestureDetector(
                      onTap: nextPage,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 52,
                        width: isLast ? 130 : 52,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.secondary.withOpacity(0.35),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Center(
                          child: isLast
                              ? Text(
                            "Done",
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          )
                              : const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
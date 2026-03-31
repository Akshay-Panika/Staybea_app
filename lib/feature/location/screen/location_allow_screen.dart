import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../google/translation_service.dart';
import '../controller/location_controller.dart';
import '../../onboarding/screen/onboarding_screen.dart';

class LocationAllowScreen extends StatefulWidget {
  const LocationAllowScreen({super.key});

  @override
  State<LocationAllowScreen> createState() =>
      _LocationAllowScreenState();
}

class _LocationAllowScreenState extends State<LocationAllowScreen> with SingleTickerProviderStateMixin {

  final LocationController controller = Get.put(LocationController());

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// 🔥 Translation Future
  Future<Map<String, String>> getTranslations() async {
    final t = TranslationService();

    return {
      "title": await t.translate(
          "Allow your location to help find people near you. Where are you from?"),
      "subtitle": await t.translate(
          "Set your real-time location to see who’s in your area or beyond"),
      "allow": await t.translate("Allow"),
      "skip": await t.translate("Skip"),
    };
  }

  @override
  Widget build(BuildContext context) {
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
          body: SafeArea(
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 50),

                  /// Title
                  Text(
                    t["title"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Subtitle
                  Text(
                    t["subtitle"]!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  Expanded(
                    child: Center(
                      child: SizedBox(
                        width: 300,
                        height: 300,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [

                            /// 🔥 Animated circles
                            AnimatedBuilder(
                              animation: _scaleAnimation,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: child,
                                );
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  circle(260, 0.3),
                                  circle(200, 0.5),
                                  circle(140, 1),
                                  const Icon(
                                    Icons.location_on_outlined,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),

                            /// Avatars
                            positionedAvatar(
                                "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
                                -90,
                                -70),
                            positionedAvatar(
                                "https://images.unsplash.com/photo-1438761681033-6461ffad8d80",
                                80,
                                -60),
                            positionedAvatar(
                                "https://images.unsplash.com/photo-1544005313-94ddf0286df2",
                                -90,
                                60),
                            positionedAvatar(
                                "https://images.unsplash.com/photo-1524504388940-b1c1722653e1",
                                80,
                                70),
                            positionedAvatar(
                                "https://images.unsplash.com/photo-1517841905240-472988babdf9",
                                0,
                                110),
                          ],
                        ),
                      ),
                    ),
                  ),

                  /// Allow Button
                  Obx(() {
                    return controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : InkWell(
                      onTap: () async {
                        await controller.fetchLocation();

                        if (controller
                            .isLocationLoaded.value) {
                          Get.to(() =>
                          const OnboardingScreen());
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        height: 55,
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFA54275),
                          borderRadius:
                          BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            t["allow"]!,
                            style: const TextStyle(
                                color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 12),

                  /// Skip Button
                  InkWell(
                    onTap: () {
                      Get.to(() =>
                      const OnboardingScreen());
                    },
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                        BorderRadius.circular(30),
                        border: Border.all(
                            color: Colors.grey.shade200),
                      ),
                      child: Center(
                        child: Text(
                          t["skip"]!,
                          style: const TextStyle(
                            color: Color(0xFFA54275),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// 🔵 Circle UI
  Widget circle(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
        const Color(0xFFEED6E0).withOpacity(opacity),
      ),
    );
  }

  /// 👤 Avatar
  Widget positionedAvatar(
      String image, double x, double y) {
    return Positioned(
      left: 130 + x,
      top: 130 + y,
      child: CircleAvatar(
        radius: 22,
        backgroundColor: Colors.white,
        backgroundImage: NetworkImage(image),
      ),
    );
  }
}
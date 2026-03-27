import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:staybea_app/feature/verification/screen/user_details_screen.dart';

import '../../location/controller/location_controller.dart';
import '../../onboarding/screen/onboarding_screen.dart';

class LocationAllowScreen extends StatefulWidget {
   LocationAllowScreen({super.key});

  @override
  State<LocationAllowScreen> createState() => _LocationAllowScreenState();
}

class _LocationAllowScreenState extends State<LocationAllowScreen>
    with SingleTickerProviderStateMixin {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              const SizedBox(height: 50),


              const Text(
                "Allow Your Location To Help the partner So, Where are you from ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 16),

              const Text(
                "set up your real time location to see who’s in your area or beyond",
                textAlign: TextAlign.center,
                style: TextStyle(
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

                        /// 🔥 ONLY CIRCLES ANIMATION
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

                              Container(
                                width: 260,
                                height: 260,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFEED6E0).withOpacity(.3),
                                ),
                              ),

                              Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFEED6E0).withOpacity(.5),
                                ),
                              ),

                              Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color(0xFFEED6E0),
                                ),
                              ),

                              const Icon(Icons.location_on_outlined,
                                  size: 40, color: Colors.grey),
                            ],
                          ),
                        ),

                        /// ❌ AVATARS (STATIC - NO ANIMATION)
                        positionedAvatar("https://images.unsplash.com/photo-1494790108377-be9c29b29330", -90, -70),
                        positionedAvatar("https://images.unsplash.com/photo-1438761681033-6461ffad8d80", 80, -60),
                        positionedAvatar("https://images.unsplash.com/photo-1544005313-94ddf0286df2", -90, 60),
                        positionedAvatar("https://images.unsplash.com/photo-1524504388940-b1c1722653e1", 80, 70),
                        positionedAvatar("https://images.unsplash.com/photo-1517841905240-472988babdf9", 0, 110),
                      ],
                    ),
                  ),
                ),
              ),

              Obx(() {
              return controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : InkWell(
                onTap: () async {
                  await controller.fetchLocation();

                  if (controller.isLocationLoaded.value) {
                    Get.to(() => OnboardingScreen());
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: const Color(0xFFA54275),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Allow",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            }),

              const SizedBox(height: 12),

              InkWell(
                child: Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: const Center(
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          color: Color(0xFFA54275),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OnboardingScreen(),));
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget positionedAvatar(String image, double x, double y) {
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
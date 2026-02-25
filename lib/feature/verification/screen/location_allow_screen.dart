import 'package:flutter/material.dart';
import 'package:staybea_app/feature/verification/screen/user_details_screen.dart';

class LocationAllowScreen extends StatelessWidget {
  const LocationAllowScreen({super.key});

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
                    width: 260,
                    height: 300,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [

                        /// OUTER CIRCLE
                        Container(
                          width: 260,
                          height: 260,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFEED6E0).withOpacity(.3),
                          ),
                        ),

                        /// MIDDLE
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFEED6E0).withOpacity(.5),
                          ),
                        ),

                        /// INNER
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFEED6E0),
                          ),
                        ),

                        /// LOCATION ICON
                        const Icon(Icons.location_on_outlined,
                            size: 40, color: Colors.grey),

                        /// AVATARS
                        positionedAvatar(
                          "https://images.unsplash.com/photo-1494790108377-be9c29b29330",
                          -90,
                          -70,
                        ),
                        positionedAvatar(
                          "https://images.unsplash.com/photo-1438761681033-6461ffad8d80",
                          80,
                          -60,
                        ),
                        positionedAvatar(
                          "https://images.unsplash.com/photo-1544005313-94ddf0286df2",
                          -90,
                          60,
                        ),
                        positionedAvatar(
                          "https://images.unsplash.com/photo-1524504388940-b1c1722653e1",
                          80,
                          70,
                        ),
                        positionedAvatar(
                          "https://images.unsplash.com/photo-1517841905240-472988babdf9",
                          0,
                          110,
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              InkWell(
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
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsScreen(),));
                },
              ),

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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetailsScreen(),));
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
import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class SeeingForADate extends StatefulWidget {
  const SeeingForADate({super.key});

  @override
  State<SeeingForADate> createState() => _SeeingForADateState();
}

class _SeeingForADateState extends State<SeeingForADate> {

  int selectedIndex = 0; // ✅ Default first selected

  @override
  Widget build(BuildContext context) {

    AppSize appSize = AppSize(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          Text(
            "Who are you interested in seeing\nfor a Date ?",
            style: TextStyle(
              fontSize: appSize.largeText,
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: appSize.height * 0.03),

          _buildCard(
            index: 0,
            title: "Women",
            image: "assets/auth/women.png",
            color: const Color(0xFFF1ECF7),
          ),

          SizedBox(height: appSize.height * 0.02),

          _buildCard(
            index: 1,
            title: "Man",
            image: "assets/auth/man.png",
            color: const Color(0xFFF5F1E6),
          ),

          SizedBox(height: appSize.height * 0.02),

          _buildCard(
            index: 2,
            title: "Everyone",
            image: "assets/auth/everyone.png",
            color: const Color(0xFFF2E2D6),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required int index,
    required String title,
    required String image,
    required Color color,
  }) {

    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index; // ✅ update selection
        });
      },
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: isSelected ? Colors.pink : Colors.transparent, // ✅ highlight
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              height: 70,
            ),

            const Spacer(),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.pink : Colors.black, // ✅ text highlight
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: const [
                    Text(
                      "Identify",
                      style: TextStyle(
                        color: Color(0xFFA54275),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Color(0xFFA54275),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
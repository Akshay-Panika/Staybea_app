import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:staybea_app/core/constant/App_color.dart';

class Connectionshimmer extends StatelessWidget {
  const Connectionshimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),

          /// Title shimmer
          _shimmerBox(
            width: double.infinity,
            height: 28,
            radius: 8,
          ),

          const SizedBox(height: 30),

          /// Cards
          _cardShimmer(),
          const SizedBox(height: 16),
          _cardShimmer(),
          const SizedBox(height: 16),
          _cardShimmer(),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _cardShimmer() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _shimmerBox(width: 80, height: 80, radius: 12),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _shimmerBox(width: 120, height: 14, radius: 6),
                const SizedBox(height: 10),
                _shimmerBox(width: 150, height: 10, radius: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    required double radius,
  }) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
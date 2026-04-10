import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class HealthShimmer extends StatelessWidget {
  const HealthShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: appSize.height * 0.02),

            _shimmerBox(width: 160, height: 24),

            SizedBox(height: appSize.height * 0.01),

            _shimmerBox(width: 200, height: 16),

            SizedBox(height: appSize.height * 0.02),

            _shimmerLabel(),
            const SizedBox(height: 8),
            _shimmerDropdown(),

            const SizedBox(height: 30),
            _shimmerLabel(),
            const SizedBox(height: 8),
            _shimmerInput(),

            const SizedBox(height: 30),
            _shimmerLabel(),
            const SizedBox(height: 8),
            _shimmerInput(),
          ],
        ),
      ),
    );
  }

  Widget _shimmerLabel() {
    return _shimmerBox(width: 120, height: 16);
  }

  Widget _shimmerDropdown() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );
  }

  Widget _shimmerInput() {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
    );
  }

  Widget _shimmerBox({required double width, required double height}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
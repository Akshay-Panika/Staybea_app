import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class LifestyleShimmer extends StatelessWidget {
  const LifestyleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    AppSize appSize = AppSize(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: appSize.height * 0.02),

                // ── Title ─────────────────────────────────────────
                _shimmerBox(width: 220, height: 28),
                const SizedBox(height: 10),

                // ── Subtitle line 1 ───────────────────────────────
                _shimmerBox(width: double.infinity, height: 16),
                const SizedBox(height: 6),
                // ── Subtitle line 2 ───────────────────────────────
                _shimmerBox(width: 50, height: 16),

                SizedBox(height: appSize.height * 0.025),
              ],
            ),
          ),

          // ── Card 1: communication (7 chips) ───────────────
          _shimmerCard(rows: [
            [180, 140],   // I stay on WhatsApp all day | Big time texter
            [120, 140],   // Phone caller | Video chatter
            [220],        // I'm slow to answer on WhatsApp
            [120, 150],   // Bad texter | Better in person
          ]),

          const SizedBox(height: 16),

          // ── Card 2: love language (5 chips) ───────────────
          _shimmerCard(rows: [
            [160, 100, 80],  // Thoughtful gestures | Presents | Touch
            [120, 130],      // Compliments | Time together
          ]),

          const SizedBox(height: 16),

          // ── Card 3: education (4+ chips) ──────────────────
          _shimmerCard(rows: [
            [110, 120],   // High school | Trade school
            [180, 150],   // Currently at university | Bachelor's degree
          ]),
        ],
      ),
    );
  }

  /// [rows] — each row is a list of chip widths
  Widget _shimmerCard({required List<List<double>> rows}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon + Title row ────────────────────────────────
            Row(
              children: [
                _shimmerBox(width: 30, height: 30, radius: 8),
                const SizedBox(width: 10),
                _shimmerBox(width: 190, height: 18),
              ],
            ),
            const SizedBox(height: 16),

            // ── Chip rows ───────────────────────────────────────
            ...rows.map(
                  (rowWidths) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Wrap(
                  spacing: 10,
                  children: rowWidths.map((w) => _shimmerChip(w)).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _shimmerChip(double width) {
    return Container(
      height: 38,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white, // ✅ white chips on lavender card
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _shimmerBox({
    required double width,
    required double height,
    double radius = 8,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
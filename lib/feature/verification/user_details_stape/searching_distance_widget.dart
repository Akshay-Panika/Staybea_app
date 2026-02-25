import 'package:flutter/material.dart';
import 'package:staybea_app/core/constant/App_color.dart';

class SearchingDistanceWidget extends StatefulWidget {
  const SearchingDistanceWidget({super.key});

  @override
  State<SearchingDistanceWidget> createState() => _SearchingDistanceWidgetState();
}

class _SearchingDistanceWidgetState extends State<SearchingDistanceWidget> {
  double _distance = 13;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "How far are you searching for a partner?",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Distance preference",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${_distance.round()} km",
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          /// Slider with heart thumb
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 5,
              activeTrackColor: Colors.red,
              inactiveTrackColor: Colors.grey.withOpacity(0.16),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 0),
              thumbShape: HeartSliderThumb(),
              thumbColor: Colors.red,
              // Custom heart thumb
            ),
            child: Slider(
              value: _distance,
              min: 1,
              max: 100,
              divisions: 99,
              label: "${_distance.round()} km",
              onChanged: (value) {
                setState(() {
                  _distance = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Slider Thumb with Heart Icon
class HeartSliderThumb extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(30, 30);

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter? labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final heartIcon = Icons.favorite;
    final iconPainter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(heartIcon.codePoint),
        style: TextStyle(
          fontSize: 30,
          fontFamily: heartIcon.fontFamily,
          package: heartIcon.fontPackage,
          color: sliderTheme.thumbColor ?? Colors.red,
        ),
      ),
      textDirection: textDirection,
    );

    iconPainter.layout();
    iconPainter.paint(
        canvas, center - Offset(iconPainter.width / 2, iconPainter.height / 2));
  }
}
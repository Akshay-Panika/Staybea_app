import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppSize {
  final double width;
  final double height;
  final bool isLandscape;

  // 🔤 Text Sizes
  final double smallText;
  final double mediumText;
  final double largeText;
  final double extraLargeText;

  AppSize(BuildContext context)
      : width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height,
        isLandscape =
            MediaQuery.of(context).orientation == Orientation.landscape,

  // 📱 Responsive text sizes (based on screen width)
        smallText = MediaQuery.of(context).size.width * 0.03,
        mediumText = MediaQuery.of(context).size.width * 0.04,
        largeText = MediaQuery.of(context).size.width * 0.05,
        extraLargeText = MediaQuery.of(context).size.width * 0.06;
}

extension SizeBox on num{
  SizedBox get height => SizedBox(height: toDouble());
  SizedBox get width => SizedBox(width: toDouble());
}
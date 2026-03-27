import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final Color? bColor;
  final Color? tColor;
  final double height;
  final double borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,
    this.bColor,
    this.tColor,
    this.height = 50,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bColor ?? Colors.grey.shade300,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: isLoading
            ? const SizedBox(
          height: 26,
          width: 26,
          child: CircularProgressIndicator(
            strokeWidth:4,
            color: Colors.white,
          ),
        )
            : Text(
          text,
          style:  TextStyle(
            color: tColor ??  Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
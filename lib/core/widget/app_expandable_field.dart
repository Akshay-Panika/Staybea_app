import 'package:flutter/material.dart';
import 'package:staybea_app/core/utils/app_size.dart';

class AppExpandableField extends StatefulWidget {
  final String label;
  final String hint;
  final String? value;
  final bool isOpen;
  final VoidCallback onTap;
  final List<String> items;
  final Function(String) onSelect;

  final bool isDOB;
  final bool enabled;
  final Color? selectedColor;
  final Color? radioActiveColor;
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;
  final TextStyle? hintStyle;
  final TextStyle? itemStyle;
  final EdgeInsets? contentPadding;
  final EdgeInsets? itemPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const AppExpandableField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.isOpen,
    required this.onTap,
    required this.items,
    required this.onSelect,
    this.isDOB = false,
    this.enabled = true,
    this.selectedColor,
    this.radioActiveColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.labelStyle,
    this.valueStyle,
    this.hintStyle,
    this.itemStyle,
    this.contentPadding,
    this.itemPadding,
    this.prefixIcon,
    this.suffixIcon,
  });

  @override
  State<AppExpandableField> createState() => _AppExpandableFieldState();
}

class _AppExpandableFieldState extends State<AppExpandableField> {
  String? _tempSelected; // ← 200ms ke liye temporarily selected item track karta hai

  Future<void> _handleSelect(String item) async {
    // Step 1: Color highlight karo
    setState(() => _tempSelected = item);

    // Step 2: 200ms wait karo
    await Future.delayed(const Duration(milliseconds: 300));

    // Step 3: Parent ko notify karo (jo isOpen = false karega)
    widget.onSelect(item);

    // Step 4: Reset
    if (mounted) setState(() => _tempSelected = null);
  }

  @override
  Widget build(BuildContext context) {
    final appSize = AppSize(context);
    final effectiveBorderColor = widget.borderColor ?? const Color(0xFFB3B3B3);
    final effectiveBorderWidth = widget.borderWidth ?? 0.6;
    final effectiveBorderRadius = widget.borderRadius ?? 14.0;
    final effectiveRadioColor = widget.radioActiveColor ?? Colors.pink;
    final effectiveSelectedBg = widget.selectedColor ?? Colors.pink.shade50;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Label ───────────────────────────────────────
        Text(
          widget.label,
          style: widget.labelStyle ??
              TextStyle(
                fontSize: appSize.mediumText,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),

        // ── Main Box ─────────────────────────────────────
        Stack(
          children: [
            GestureDetector(
              onTap: widget.enabled ? widget.onTap : null,
              child: Container(
                padding: widget.contentPadding ??
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                  color: widget.enabled ? Colors.white : Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(effectiveBorderRadius),
                  border: Border.all(
                    color: widget.enabled
                        ? effectiveBorderColor
                        : Colors.grey.shade200,
                    width: effectiveBorderWidth,
                  ),
                ),
                child: Row(
                  children: [
                    if (widget.prefixIcon != null) ...[
                      widget.prefixIcon!,
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Text(
                        widget.value ?? widget.hint,
                        style: widget.value != null
                            ? (widget.valueStyle ??
                            TextStyle(
                              fontSize: appSize.mediumText,
                              color: Colors.black,
                            ))
                            : (widget.hintStyle ??
                            TextStyle(
                              fontSize: appSize.mediumText,
                              color: Colors.grey.shade400,
                            )),
                      ),
                    ),
                    widget.suffixIcon ??
                        Icon(
                          widget.isOpen
                              ? Icons.arrow_drop_down_circle_outlined
                              : Icons.arrow_drop_down_circle_outlined,
                          color: widget.enabled
                              ? Colors.grey
                              : Colors.grey.shade300,
                        ),
                  ],
                ),
              ),
            ),

            if (widget.isOpen && widget.items.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(effectiveBorderRadius),
                  border: Border.all(
                    color: effectiveBorderColor,
                    width: effectiveBorderWidth,
                  ),
                ),
                child: Column(
                  children: widget.items.map((item) {
                    // _tempSelected — 200ms highlight
                    // widget.value  — already selected
                    final isSelected = _tempSelected == item || widget.value == item;

                    return InkWell(
                      onTap: () => _handleSelect(item),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        // color: isSelected
                        //     ? effectiveSelectedBg        // ✅ pink bg on select
                        //     : Colors.transparent,
                        padding: widget.itemPadding ??
                            const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item,
                                style: widget.itemStyle ??
                                    TextStyle(
                                      fontSize: appSize.mediumText,
                                      color: isSelected ? Colors.black : Colors.black54,
                                      fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                                    ),
                              ),
                            ),

                            AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: isSelected
                                      ? effectiveRadioColor
                                      : Colors.grey,
                                  width: 1.5,
                                ),
                              ),
                              child: isSelected
                                  ? Center(
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: effectiveRadioColor,
                                  ),
                                ),
                              )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
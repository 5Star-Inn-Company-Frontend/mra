import 'package:flutter/material.dart';
import 'package:mra/constant/app_colors.dart';

class BusyButton extends StatelessWidget {
  const BusyButton({
    required this.title,
    required this.onTap,
    this.disabled = false,
    this.color = AppColors.plugPrimaryColor,
    this.textColor = AppColors.white,
    this.width,
    this.height,
    this.borderRadius,
    super.key,
  });
  final String title;
  final Color? color;
  final Color? textColor;
  final double? width;
  final double? height;
  final VoidCallback onTap;
  final bool disabled;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        height: height ?? 48,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(5),
          color: disabled ? color?.withOpacity(0.3) : color,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w900),
          ),
        ),
      ),
    );
  }
}

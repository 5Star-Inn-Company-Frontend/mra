import 'package:flutter/material.dart';

Widget customBbox({
  final double? height,
  final double? width,
  final Color? color,
  final BorderRadius? radius,
  final BoxShape? shapes,
  final Widget? widget,
  final Color? shadowcolor,
  final Color? borderColor,
  final Function()? onPressed,
  final LinearGradient? gradient,
}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: gradient,
        color: color,
        borderRadius: radius,
        shape: shapes ?? BoxShape.rectangle,
        boxShadow: [
          BoxShadow(
            color: shadowcolor ?? Colors.transparent,
            offset: Offset(3, 3),
            blurRadius: 15,
          ),
        ],
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 2,
        ),
      ),
      child: widget,
    ),
  );
}

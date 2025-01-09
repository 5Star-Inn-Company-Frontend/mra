import 'package:flutter/material.dart';
import 'package:mra/constant/app_colors.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Center(
          child: Icon(
        Icons.arrow_back_ios_new,
        color: AppColors.white,
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mra/constant/text.dart';
import 'package:mra/utils/ui_helpers.dart';

class PasswordSuccess extends StatelessWidget {
  const PasswordSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/images/Sucess.png",
            width: screenWidth(context) * 0.24,
          ),
          TextBold(
            "Congratulations your password has been set Successfully",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}

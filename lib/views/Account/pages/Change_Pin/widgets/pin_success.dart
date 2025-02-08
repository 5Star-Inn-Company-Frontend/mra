import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/constant/text.dart';

class ChangePinSuccess extends StatelessWidget {
  const ChangePinSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(30, 20, 30, 10),
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            "assets/images/insurance.png",
            width: 200.w,
          ),
          TextBold(
            "Congratulations your Account Pin has been set Successfully",
            fontSize: 20,
            fontWeight: FontWeight.w500,
          )
        ],
      ),
    );
  }
}

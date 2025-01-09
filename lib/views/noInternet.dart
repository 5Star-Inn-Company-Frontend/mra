import 'package:flutter/material.dart';

import 'package:mra/constant/app_colors.dart';
import 'package:mra/constant/text.dart';
import 'package:mra/utils/widget/gap.dart';

class NoInternet extends StatelessWidget {
  const NoInternet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          children: [
            const Gap(20),
            Image.asset("assets/images/noInternet.png"),
            TextBold(
              "No Internet Connection available!!",
              textAlign: TextAlign.center,
              fontSize: 24,
            )
          ],
        ),
      ),
    );
  }
}

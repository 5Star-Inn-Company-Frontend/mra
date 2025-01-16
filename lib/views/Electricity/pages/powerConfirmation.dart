import 'package:flutter/material.dart';

import 'package:mra/constant/fonts.dart';
import 'package:mra/constant/text.dart';
import 'package:mra/core/navigators/router_names.dart';
import 'package:mra/res/import/import.dart';
import 'package:mra/utils/ui_helpers.dart';
import 'package:mra/views/Electricity/changeNotifier/power_notifier.dart';
import 'package:provider/provider.dart';

class PowerSuccessConfirmation extends StatelessWidget {
  const PowerSuccessConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    final powerNotifier = Provider.of<PowerProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: TextBold(
                "Electricity Transferred",
                textAlign: TextAlign.center,
                fontSize: 26,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const Gap(20),
            Center(
              child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'You have successfully ',
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontFamily: AppFonts.poppins,
                          fontSize: 15),
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'transferred ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        const TextSpan(
                            text: 'Electricity to ',
                            style: TextStyle(fontWeight: FontWeight.w300)),
                        TextSpan(
                            text:
                                '${powerNotifier.provider} - ${powerNotifier.Number.toString()}',
                            style: const TextStyle(fontWeight: FontWeight.w600))
                      ])),
            ),
            Gap(screenHeight(context) * 0.2),
            CustomButtonWithIconRight(
              onPressed: () {
                Navigator.pushNamed(context, Routes.wrapper);
              },
              title: 'Continue',
              gradient: gradient2,
            ),
          ],
        ),
      ),
    );
  }
}

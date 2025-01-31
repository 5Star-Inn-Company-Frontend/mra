import 'package:mra/constant/fonts.dart';
import 'package:mra/res/import/import.dart';

class CableConfirmation extends StatelessWidget {
  const CableConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    final cableNotifier = Provider.of<CableProvider>(context, listen: true);
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
                "Cable Transferred",
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
                            text: 'Cable Tv to ',
                            style: TextStyle(fontWeight: FontWeight.w300)),
                        TextSpan(
                            text:
                                '${cableNotifier.code} - ${cableNotifier.phoneNumber.toString()}',
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

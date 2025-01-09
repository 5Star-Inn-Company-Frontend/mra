import 'package:mra/res/import/import.dart';

class TransferSuccessful extends StatelessWidget {
  final String? amountTransferred;
  final String? receiver;
  const TransferSuccessful({super.key, this.amountTransferred, this.receiver});

  @override
  Widget build(BuildContext context) {
    return ResponsiveScreen(
      mobile: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Align(
                    alignment: Alignment.topLeft,
                    child: Icon(
                      Icons.arrow_back_ios_sharp,
                    ),
                  ),
                ),
                const SizedBox.square(dimension: 338),
                MyText(
                  title: 'Transfer Successful',
                  fonts: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 26,
                    color: plugTetTextColor,
                  ),
                  align: TextAlign.center,
                ),
                AppVerticalSpacing.verticalSpacingE,
                MyText(
                  title:
                      'You have successfully transferred $amountTransferred to $receiver',
                  fonts: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: const Color.fromRGBO(58, 58, 58, 0.8),
                  ),
                  align: TextAlign.center,
                ),
                AppVerticalSpacing.verticalSpacingXXL,
                CustomButtonWithIconRight(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => const Transfer()));
                  },
                  title: 'Continue',
                  textColor: plugWhite,
                  textSize: 24,
                  gradient: gradient2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

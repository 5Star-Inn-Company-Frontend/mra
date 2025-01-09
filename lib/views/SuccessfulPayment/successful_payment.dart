import 'package:mra/res/import/import.dart';

class SuccessfulPayment extends StatelessWidget {
  final String title;
  const SuccessfulPayment({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back_ios_sharp,
                  ),
                ),
              ),
              AppVerticalSpacing.verticalSpacingXXL,
              MyText(
                title: '$title Transferred',
                weight: FontWeight.w700,
                size: 26,
              ),
              MyText(
                title:
                    'You have successfully transferred $title to GOTV  Jolli - 1234567890',
                weight: FontWeight.w700,
                size: 15,
                align: TextAlign.center,
                color: plugTetTextColor,
              ),
              AppVerticalSpacing.verticalSpacingXS,
              CustomButtonWithIconRight(
                onPressed: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => DashBoard()));
                },
                title: 'Continue',
                gradient: gradient2,
              ),
              AppVerticalSpacing.verticalSpacingXS,
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:mra/utils/widget/appbar_two.dart';

import '../../../../res/import/import.dart';

class EnterPin extends StatelessWidget {
  final String title;
  EnterPin({super.key, required this.title});
  
  final pinController1 = TextEditingController();
  final pinController2 = TextEditingController();
  final pinController3 = TextEditingController();
  final pinController4 = TextEditingController();
  
  String enteredPin = "";
  
  void _pinChanged(context) {
    enteredPin = pinController1.text +
        pinController2.text +
        pinController3.text +
        pinController4.text;
    if (enteredPin.length == 4) {
      checkPinAndNavigate(enteredPin, context);
    }
  }

  Future<void> checkPinAndNavigate(String enteredPin, context) async {
    String correctPin = "1234";
    if (enteredPin == correctPin) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessfulPayment(
            title: title,
          )
        ),
      );
    } else {
      // handle incorrect pin
      Flushbar(
        message: "Incorrect Pin, try again. ",
        flushbarStyle: FlushbarStyle.GROUNDED,
        isDismissible: true,
        flushbarPosition: FlushbarPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PlugAppBarTwo(title: ''),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: MyText(
                title: 'Enter your PIN',
                size: 32,
                weight: FontWeight.w700,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  pinFied(
                    controller: pinController1,
                    onchanged: (value) {
                      _pinChanged(context);
                    },
                    onSubmit: (value) {
                      checkPinAndNavigate(enteredPin, context);
                    },
                  ),
                  AppHorizontalSpacing.horizontalSpacingS,
                  pinFied(
                    controller: pinController2,
                    onchanged: (value) {
                      _pinChanged(context);
                    },
                    onSubmit: (value) {
                      checkPinAndNavigate(enteredPin, context);
                    },
                  ),
                  AppHorizontalSpacing.horizontalSpacingS,
                  pinFied(
                    controller: pinController3,
                    onchanged: (value) {
                      _pinChanged(context);
                    },
                    onSubmit: (value) {
                      checkPinAndNavigate(enteredPin, context);
                    },
                  ),
                  AppHorizontalSpacing.horizontalSpacingS,
                  pinFied(
                    controller: pinController4,
                    onchanged: (value) {
                      _pinChanged(context);
                    },
                    onSubmit: (value) {
                      checkPinAndNavigate(enteredPin, context);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:mra/res/import/import.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Airtime/model/airtimePayment.dart';

class AirtimePin extends StatefulWidget {
  const AirtimePin({super.key});

  @override
  State<AirtimePin> createState() => _AirtimePinState();
}

class _AirtimePinState extends State<AirtimePin> {
  OtpFieldController otpController = OtpFieldController();

  @override
  void initState() {
    OtpFieldController otpController = OtpFieldController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDataProvider>(context, listen: true);
    final airtimePaymentNotifier = Provider.of<AirtimeProvider>(context, listen: true);

    return Scaffold(
      appBar: PlugAppBarTwo(title: ''),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: Column(
          children: [
            TextBold(
              "Enter your PIN",
              fontSize: 32,
              fontWeight: FontWeight.w700,
            ),
            Gap(screenHeight(context) * 0.06),
            OTPTextField(
              controller: otpController,
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 40,
              style: TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onChanged: (value) {
                print(value);
              },
              onCompleted: (pin) async {
                otpController.clear();
                // print(user.userData!.transactionPin);
                // if (pin == user.userData?.transactionPin) {
                if (pin == "1234") {
                  airtimePaymentNotifier.setPinAuth(true);

                  airtimePaymentNotifier.purchaseAirtime(
                      AirtimePayment(
                          amount: airtimePaymentNotifier.rechargeAmount,
                          number: airtimePaymentNotifier.phoneNumber,
                          provider: airtimePaymentNotifier.provider,
                          reference: airtimePaymentNotifier.refId),
                      context);
                } else {
                  Flushbar(
                    duration: Duration(seconds: 2),
                    message: "Wrong Transaction Pin, try again.",
                  ).show(context);
                }
                print("Completed: " + pin);
              },
            )
          ],
        ),
      )),
    );
  }
}

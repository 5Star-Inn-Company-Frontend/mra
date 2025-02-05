import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:mra/res/import/import.dart';
import 'package:mra/utils/widget/appbar_two.dart';

class PowerPin extends StatefulWidget {
  const PowerPin({super.key});

  @override
  State<PowerPin> createState() => _PowerPinState();
}

class _PowerPinState extends State<PowerPin> {
  OtpFieldController otpController = OtpFieldController();

  @override
  void initState() {
    OtpFieldController otpController = OtpFieldController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserDataProvider>(context, listen: true);
    final powerNotifier = Provider.of<PowerProvider>(context, listen: true);

    return Scaffold(
      appBar: const PlugAppBarTwo(title: 'Electricity'),
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
              length: 5,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 40,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onChanged: (value) {
                print(value);
              },
              onCompleted: (pin) async {
                otpController.clear();
                // print(user.userData!.data!.transactionPin);
                // if (pin == user.userData?.data?.transactionPin) {
                if (pin == "12345") {
                  powerNotifier.setPinAuth(true);
                  // print('"code": ${powerNotifier.code}');

                  await powerNotifier.purchasePower(
                    PowerPayment(
                      networkID: powerNotifier.networkID!,
                      type: powerNotifier.meterType!,
                      phone: powerNotifier.meterNumber.toString(),
                      amount: powerNotifier.rechargeAmount!,
                    ),
                    context
                  );

                  print('${powerNotifier.networkID} ${powerNotifier.meterType} ${powerNotifier.meterNumber} ${powerNotifier.rechargeAmount}');
                } else {
                  Flushbar(
                    duration: const Duration(seconds: 2),
                    message: "Wrong Transaction Pin, try again.",
                  ).show(context);
                }
                // print("Completed: " + pin);
              },
            )
          ],
        ),
      )),
    );
  }
}

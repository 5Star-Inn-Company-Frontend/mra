import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:mra/res/import/import.dart';
import 'package:mra/utils/widget/appbar_two.dart';

class CablePin extends StatefulWidget {
  const CablePin({super.key});

  @override
  State<CablePin> createState() => _CablePinState();
}

class _CablePinState extends State<CablePin> {
  OtpFieldController otpController = OtpFieldController();

  @override
  void initState() {
    OtpFieldController otpController = OtpFieldController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserDataProvider>(context, listen: true);
    final cableNotifier = Provider.of<CableProvider>(context, listen: true);

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
              length: 5,
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
                // print(user.userData!.data!.transactionPin);
                // if (pin == user.userData?.data?.transactionPin) {
                if (pin == "12345") {
                  cableNotifier.setPinAuth(true);
                  print(cableNotifier.refId);

                  await cableNotifier.purchaseCable(
                    CablePayment(
                      networkID: cableNotifier.networkId!,
                      phone: cableNotifier.phone!,
                    ),
                    context                        
                  );

                  // print("Cable Payment: ${cableNotifier.networkId} - ${cableNotifier.phone}");

                } else {
                  Flushbar(
                    duration: const Duration(seconds: 2),
                    message: "Wrong Transaction Pin, try again.",
                  ).show(context);
                }
                print("Completed: $pin");
              },
            )
          ],
        ),
      )),
    );
  }
}

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:mra/constant/text.dart';
import 'package:mra/utils/ui_helpers.dart';
import 'package:mra/utils/widget/gap.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Data/changeNotifier/data_notifier.dart';
import 'package:provider/provider.dart';

class DataPin extends StatefulWidget {
  const DataPin({super.key});

  @override
  State<DataPin> createState() => _DataPinState();
}

class _DataPinState extends State<DataPin> {
  OtpFieldController otpController = OtpFieldController();

  @override
  void initState() {
    OtpFieldController otpController = OtpFieldController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserDataProvider>(context, listen: true);
    final dataNotifier = Provider.of<DataProvider>(context, listen: true);
    
    return Scaffold(
      appBar: const PlugAppBarTwo(title: 'Data'),
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
                if (pin == '12345') {
                  dataNotifier.setPinAuth(true);
                  dataNotifier.purchaseData(
                    DataPayment(
                      networkID: dataNotifier.networkID!,
                      phone: dataNotifier.phone!,
                    ),
                    context
                  );
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

import 'dart:convert';
import 'dart:math';
import 'package:mra/res/import/import.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Transfer/model/account_transfer.dart';
import 'package:mra/views/Transfer/model/beneficiary.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';

class ConfirmDetail extends StatefulWidget {
  final String recipient;
  final String account;
  final String amount;
  final String description;
  const ConfirmDetail(
      {super.key,
      required this.recipient,
      required this.account,
      required this.amount,
      required this.description});

  @override
  State<ConfirmDetail> createState() => _ConfirmDetailState();
}

class _ConfirmDetailState extends State<ConfirmDetail> {
  bool isChecked = false;

  bool isVerified = false;

  String? confirmPin;

  final _pinController = TextEditingController();

  // Map<String, dynamic> beneficiary = {
  //   'name': 'John Doe',
  //   'accountNumber': '1234567890',
  //   'bankName': 'ABC Bank',
  //   'bankCode': '1234'
  // };

  final storage = const FlutterSecureStorage();

  Future<Beneficiary> saveBeneficiaryDetails(Beneficiary beneficiary) async {
    if (isChecked == true) {
      await storage.write(key: 'beneficiary', value: json.encode(beneficiary));
    }
    return Beneficiary(
        name: null, accountNumber: null, bankName: null, bankCode: null);
  }

  @override
  void initState() {
    super.initState();
    final TextEditingController _pinController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final transferData = Provider.of<TransferNotifier>(context, listen: true);
    final userData = Provider.of<UserDataProvider>(context, listen: true);

    return ResponsiveScreen(
      mobile: Scaffold(
        appBar: const PlugAppBarTwo(title: "Confirm Detail"),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Confirm_Infos(
                  title: 'Transfer to',
                  subTitle: transferData.acctName.toString(),
                  accountNo: transferData.acctNo,
                ),
                Confirm_Infos(
                  title: 'Amount',
                  subTitle: transferData.amount.toString(),
                ),
                const Confirm_Infos(
                  title: 'Rate N',
                  subTitle: '0.0',
                ),
                Confirm_Infos(
                  title: 'Description',
                  subTitle: transferData.description.toString(),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70.0),
                  child: PinCodeFields(
                    length: 4,
                    activeBorderColor: AppColors.plugPrimaryColor,
                    borderColor: Colors.blueGrey,
                    controller: _pinController,
                    obscureText: true,
                    obscureCharacter: "*",
                    onComplete: (pin) {
                      print(pin);
                      _pinController.clear();
                      // if (pin == userData.userData?.data?.transactionPin) {
                      //   setState(() {
                      //     _pinController.clear();
                      //     isVerified = true;
                      //     confirmPin = pin;
                      //   });
                      //   transferData.setPinAuth(true);
                      // } else {
                      //   _pinController.clear();
                      //   Flushbar(
                      //     message: 'Pin is not correct',
                      //     isDismissible: true,
                      //     duration: const Duration(seconds: 3),
                      //     backgroundColor: Colors.red,
                      //   ).show(context);
                      // }
                    },
                  ),
                ),

                AppVerticalSpacing.verticalSpacingN,
                Align(
                  alignment: Alignment.center,
                  child: MyText(
                    title: 'Enter your Transaction Pin',
                    fonts: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: plugAshColor,
                    ),
                  ),
                ),

                Row(
                  children: [
                    Checkbox(
                      value: isChecked,
                      onChanged: (newValue) {
                        isChecked = newValue!;
                        setState(() {});
                      },
                    ),
                    MyText(
                      onTap: () {
                        isChecked = !isChecked;
                        setState(() {});
                      },
                      title: 'Save as beneficiary',
                      fonts: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: plugBlack,
                      ),
                    ),
                  ],
                ),

                AppVerticalSpacing.verticalSpacingL,
                CustomButtonWithIconRight(
                  onPressed: () async {
                    // if (confirmPin.toString() == userData.transactionPin.toString()) {
                    //   final amount = int.parse(transferData.amount.toString());
                    //   final random = Random();
                    //   final refId = 'ref${random.nextInt(999999999)}d';
                    //   transferData.sendTransfer(
                    //       AccountTransfer(
                    //           accountNumber: transferData.acctNo,
                    //           bankCode: transferData.bankCode,
                    //           amount: amount,
                    //           narration: transferData.description,
                    //           reference: refId,
                    //           pin: confirmPin,
                    //           accountName: transferData.acctName),
                    //       context);
                    // } else {
                    //   Flushbar(
                    //     message: 'Pin is not correct',
                    //     isDismissible: true,
                    //     duration: const Duration(seconds: 3),
                    //     backgroundColor: Colors.red,
                    //   ).show(context);
                    // }
                    saveBeneficiaryDetails(
                      Beneficiary(
                        name: transferData.acctName,
                        accountNumber: transferData.acctNo,
                        bankName: transferData.bank,
                        bankCode: transferData.bankCode
                      )
                    );
                  },
                  title: 'Send Money',
                  textColor: plugWhite,
                  textSize: 24,
                  gradient: const LinearGradient(
                    colors: [Color.fromARGB(255, 39, 4, 167), Color.fromARGB(255, 57, 5, 243)],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Confirm_Infos extends StatelessWidget {
  const Confirm_Infos({
    super.key,
    required this.title,
    required this.subTitle,
    this.accountNo,
  });

  final String title;
  final String? accountNo;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                  title: title,
                  fonts: GoogleFonts.poppins(),
                  color: plugBlack,
                  weight: FontWeight.w400,
                  size: 16),
              Column(
                children: [
                  MyText(
                    title: subTitle,
                    fonts: GoogleFonts.poppins(),
                    color: plugBlack,
                    weight: FontWeight.w400,
                    size: 16,
                  ),
                  accountNo == null
                      ? const SizedBox.shrink()
                      : MyText(
                          title: accountNo,
                          fonts: GoogleFonts.poppins(),
                          color: plugBlack,
                          weight: FontWeight.w400,
                          size: 16,
                        ),
                ],
              ),
            ],
          ),
          AppVerticalSpacing.verticalSpacingN,
          const Divider(thickness: 3),
          AppVerticalSpacing.verticalSpacingN,
        ],
      ),
    );
  }
}

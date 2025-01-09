import 'dart:convert';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Transfer/bank_verification_data.dart';
import 'package:mra/views/Transfer/constants/textField.dart';
import 'package:mra/views/Transfer/model/beneficiary.dart';
import 'package:mra/views/Transfer/model/verifybankAccount.dart';
import '../../../res/import/import.dart';

class Transfer extends StatefulWidget {
  final String? bankCode;
  final String? bankname;
  const Transfer({super.key, this.bankCode, this.bankname});

  @override
  State<Transfer> createState() => _TransferState();
}

class _TransferState extends State<Transfer> {
  List amount = <int>[500, 2000, 5000, 10000,];

  TextEditingController amountController = TextEditingController();
  TextEditingController recipientController = TextEditingController();
  TextEditingController accountNumController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int? selectedIndex;

  bool isCustomer = false;

  String? beneficiaryName;

  bool _isLoading = false;

  final storage = const FlutterSecureStorage();

  Future<Beneficiary> fetchBeneficiary() async {
    final beneficiaryJson = await storage.read(key: 'beneficiary');
    if (beneficiaryJson != null) {
      Map<String, dynamic> beneficiary = json.decode(beneficiaryJson);
      setState(() {
        beneficiaryName = beneficiary['name'];
      });
    } else {
      print('Beneficiary details not found.');
    }
    return Beneficiary(
      name: null, accountNumber: null, bankName: null, bankCode: null)
    ;
  }

  @override
  void initState() {
    super.initState();
    fetchBeneficiary();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDataProvider>(context, listen: true);
    final wallet = user.walletData?.data?.map((e) => e.balance);
    String balance = wallet?.first.toString() ?? '';
    
    // final availableAmount = double.parse(balance);
    final formattedAmount = "\u{20A6}${double.parse(balance).toStringAsFixed(2).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},")}";
    final transferData = Provider.of<TransferNotifier>(context, listen: true);

    return ResponsiveScreen(
      mobile: Scaffold(
        appBar: const PlugAppBarTwo(title: "Transfer to bank"),
        body: SingleChildScrollView(
          child: Column(
            children: [
              customBbox(
                height: 32,
                width: MediaQuery.of(context).size.width,
                color: const Color(0XFFFFE2C6),
                widget: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      MyText(
                        title: 'Account Balance:',
                        color: plugAshColor,
                        weight: FontWeight.w500,
                        size: 14,
                      ),

                      const Gap(5),
                      MyText(
                        title: formattedAmount,
                        color: plugTextColor,
                        weight: FontWeight.w500,
                        size: 14,
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      title: 'Bank Name',
                      weight: FontWeight.w500,
                      size: 14,
                      color: plugAshColor,
                    ),

                    AppVerticalSpacing.verticalSpacingS,
                    HomeScreenCustomTextFormField(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SelectBank())
                        );
                      },
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      obscureText: false,
                      readonly: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            customBbox(
                              height: 43,
                              width: 43,
                              shapes: BoxShape.circle,
                              color: const Color(0xffFFE9D7),
                              widget: Image.asset(
                                'assets/images/bank.png',
                              ),
                            ),
                            MyText(
                              title: transferData.bank ?? 'Please Select bank',
                              weight: FontWeight.w500,
                              size: 14,
                              color: const Color(0xff505050),
                            ),
                            AppHorizontalSpacing.horizontalSpacingXL,
                            const Icon(
                              Icons.chevron_right,
                              color: plugSecondaryTextColor,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                      maxLines: 3,
                    ),
                    
                    Gap(screenHeight(context) * 0.03),
                    TextSemiBold(
                      "Bank Account Number",
                      color: const Color(0xff797878),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),

                    const Gap(3),
                    TextFormField(
                      enabled: _isLoading ? false : true,
                      controller: accountNumController,
                      keyboardType: TextInputType.number,
                      onChanged: (val) {
                        if (accountNumController.text.length == 10) {
                          verifyAcct(
                            VerifyBankAccount(
                              accountNumber: accountNumController.text,
                              bankCode: transferData.bankCode
                            )
                          );
                        }
                      },
                      decoration: textInputDecoration.copyWith(hintText: '2229227625'),
                    ),

                    Visibility(
                      visible: _isLoading,
                      child: const LinearProgressIndicator(
                        color: AppColors.plugPrimaryColor,
                      )
                    ),

                    Gap(screenHeight(context) * 0.03),
                    TextSemiBold(
                      "Recipient",
                      color: const Color(0xff797878),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),

                    const Gap(3),
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.plugPrimaryColor.withOpacity(0.5),
                          width: 1.0
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextFormField(
                        enabled: false,
                        controller: recipientController,
                        decoration: textInputDecoration,
                      ),
                    ),

                    Gap(screenHeight(context) * 0.03),
                    TextSemiBold(
                      "Amount",
                      color: const Color(0xff797878),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),

                    const Gap(3),
                    TextFormField(
                      controller: amountController,
                      decoration: textInputDecoration,
                      keyboardType: TextInputType.number,
                    ),

                    AppVerticalSpacing.verticalSpacingN,
                    SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: amount.length,
                        itemBuilder: (ctx, i) => Padding(
                          padding: const EdgeInsets.only(right: 29.0),
                          child: InkWell(
                            onTap: () {
                              selectedIndex = i;
                              amountController.text = amount[i].toString();

                              setState(() {});
                            },
                            child: customBbox(
                              width: 71,
                              height: 40,
                              color: selectedIndex == i ? plugLightOrangeColor : Colors.transparent,
                              radius: BorderRadius.circular(20),
                              borderColor: selectedIndex == i ? Colors.transparent : plugLightAshColor,
                              widget: Center(
                                child: MyText(
                                  title: '\u{20A6}${amount[i].toString()}',
                                  color: selectedIndex == i ? plugBlack : plugAshColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    Gap(screenHeight(context) * 0.03),
                    TextSemiBold(
                      "Description",
                      color: const Color(0xff797878),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),

                    const Gap(3),
                    TextFormField(
                      controller: descriptionController,
                      decoration: textInputDecoration,
                    ),

                    AppVerticalSpacing.verticalSpacingL,
                    CustomButtonWithIconRight(
                      onPressed: () {
                        transferData.setTransferData(
                          descriptionController.text,
                          accountNumController.text,
                          recipientController.text,
                          amountController.text
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ConfirmDetail(
                              recipient: recipientController.text,
                              account: accountNumController.text,
                              amount: amountController.text,
                              description: descriptionController.text
                            )
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
                    AppVerticalSpacing.verticalSpacingL,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<VerifyBankAccount> verifyAcct(VerifyBankAccount verify) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    try {
      final response = await ApiService.dio.post(
        '/bank-validate',
        data: json.encode(verify.toJson()),
        options: Options(headers: {'Authorization': 'Bearer $token'})
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        if (response.data['success'] == true) {
          if (response.data['data'] == null) {
            final parsedResponse = json.decode(verifiedAcctresponse);
            final data = parsedResponse['data'];
            setState(() {
              recipientController.text = data;
            });
          } else {
            final data = response.data['data'];
            setState(() {
              recipientController.text = data;
            });
          }
        }
      } else {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } on DioException catch (e) {
      if (DioExceptionType.badResponse == e.type ||
          DioExceptionType.connectionError == e.type ||
          DioExceptionType.receiveTimeout == e.type ||
          DioExceptionType.connectionTimeout == e.type) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
        Flushbar(
          message: 'Unable to complete request, try again',
          duration: const Duration(seconds: 2),
        ).show(context);
      }
    }
    return VerifyBankAccount(accountNumber: null, bankCode: null);
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Airtime/model/airtimePayment.dart';
import 'package:mra/views/Airtime/model/airtimeProvider.dart';
import 'package:mra/views/Airtime/service/airtime_service.dart';

import '../../../res/import/import.dart';

class Airtime extends StatefulWidget {
  const Airtime({super.key});

  @override
  State<Airtime> createState() => _AirtimeState();
}

class _AirtimeState extends State<Airtime> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  int currentIndex = 0;

  AirtimeProviders? providersData;

  late Future<AirtimeProviders?> futureProvider;

  final _formKey = GlobalKey<FormState>();

  // bool _isDisabled = true;

  bool isLoading = false;
  String provider = "MTN";

  // String? _errorMsg;

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  @override
  void initState() {
    getContacts();

    super.initState();
    futureProvider = loadAirtimeProvider();
  }

  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      return await FastContacts.getAllContacts();
    }
    setState(() {});
    return [];
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDataProvider>(context, listen: true);
    final airtimeNotifier = Provider.of<AirtimeProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PlugAppBarTwo(title: "Airtime"),
      body: ResponsiveScreen(
        mobile: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                    minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: 'Select Network Provider',
                          size: 14,
                          color: plugSecondaryTextColor,
                        ),
                        AppVerticalSpacing.verticalSpacingS,
                        SizedBox(
                          height: 80,
                          width: double.maxFinite,
                          child: FutureBuilder(
                            future: futureProvider,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.data!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          currentIndex = index;
                                          provider = snapshot.data?.data?[index]
                                                  .provider ??
                                              'MTN';
                                        });
                                        print(snapshot.data?.data?[index].provider);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.all(8.0),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5.0, horizontal: 8.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.5,
                                                color: currentIndex == index
                                                    ? AppColors.plugPrimaryColor
                                                    : AppColors.white),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color: currentIndex == index
                                                ? AppColors.primaryBrown
                                                : AppColors.white,
                                            // color: AppColors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: const Color(0xff525151)
                                                    .withOpacity(0.3),
                                                offset: const Offset(4, 4),
                                                blurRadius: 15,
                                              ),
                                            ]),
                                        child: Image.asset(
                                          snapshot.data!.data![index]
                                              .providerLogoUrl
                                              .toString(),
                                          width: 50,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              }
                              return const Center(
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: AppColors.plugPrimaryColor,
                                ),
                              );
                            },
                          ),
                        ),
                        AppVerticalSpacing.verticalSpacingXL,
                        Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  title: 'Mobile Number',
                                  size: 14,
                                  color: plugSecondaryTextColor,
                                  weight: FontWeight.w400,
                                ),
                                AppVerticalSpacing.verticalSpacingS,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: const Color(0xffF5F5F5),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                  'assets/images/naijaimg.png'),
                                              AppHorizontalSpacing
                                                  .horizontalSpacingS,
                                              MyText(
                                                title: '+234',
                                                color: plugBlack,
                                                size: 16,
                                              ),
                                              Expanded(
                                                child: CustomInAppTextFormField(
                                                  obscureText: false,
                                                  readonly: false,
                                                  fillColor:
                                                      const Color(0xffF5F5F5),
                                                  controller: phoneController,
                                                  validator: (val) {
                                                    if (val!.isEmpty ||
                                                        val.length < 10) {
                                                      return ("Input your 11 digits phone number");
                                                    }
                                                    return null;
                                                  },
                                                  hintText:
                                                      'Enter phone number',
                                                  textInputType: TextInputType.number,
                                                  textInputAction:
                                                      TextInputAction.done,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    AppHorizontalSpacing.horizontalSpacingS,
                                    InkWell(
                                      onTap: () {
                                        showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          builder: (context) => customBbox(
                                            color: plugWhite,
                                            radius: const BorderRadius.only(
                                              topLeft: Radius.circular(30),
                                              topRight: Radius.circular(30),
                                            ),
                                            widget: SizedBox(
                                              height: 400,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: FutureBuilder(
                                                  future: getContacts(),
                                                  builder: (context, snapshot) {
                                                    var contacts =
                                                        snapshot.data;
                                                    return snapshot.hasData
                                                        ? ListView.builder(
                                                            itemCount: contacts!
                                                                .length,
                                                            itemBuilder:
                                                                (context, i) {
                                                              Contact contact =
                                                                  snapshot
                                                                      .data![i];

                                                              phoneController
                                                                      .text =
                                                                  contact
                                                                      .phones[0]
                                                                      .number;
                                                              return InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    contact;
                                                                  });
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          20),
                                                                  child: Column(
                                                                    children: [
                                                                      AppVerticalSpacing
                                                                          .verticalSpacingD,
                                                                      Container(
                                                                        padding:
                                                                            const EdgeInsets.all(10),
                                                                        height:
                                                                            70,
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        child:
                                                                            Row(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            CircleAvatar(
                                                                              radius: 20,
                                                                              child: Icon(
                                                                                Icons.person,
                                                                                color: plugTetTextColor,
                                                                              ),
                                                                            ),
                                                                            AppHorizontalSpacing.horizontalSpacingS,
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                MyText(
                                                                                  title: contact.displayName,
                                                                                  size: 16,
                                                                                  color: plugBlack,
                                                                                  weight: FontWeight.w700,
                                                                                ),
                                                                                MyText(
                                                                                  title: contact.phones[0].number,
                                                                                  size: 16,
                                                                                  color: plugBlack,
                                                                                  weight: FontWeight.w700,
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const Divider(
                                                                        color: Color(
                                                                            0xffF5F5F5),
                                                                        thickness:
                                                                            2,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            })
                                                        : snapshot.hasError
                                                            ? Center(
                                                                child: MyText(
                                                                  title:
                                                                      'NO Contacts Available On this device',
                                                                  size: 24,
                                                                  weight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color:
                                                                      plugBlack,
                                                                ),
                                                              )
                                                            : Center(
                                                                child: MyText(
                                                                  title:
                                                                      'LOADING.....',
                                                                  size: 24,
                                                                  weight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color:
                                                                      plugBlack,
                                                                ),
                                                              );
                                                  }),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Image.asset(
                                          'assets/images/add_contacts.png'),
                                    ),
                                  ],
                                ),
                                AppVerticalSpacing.verticalSpacingM,
                                MyText(
                                  title: 'Amount (N)',
                                  size: 14,
                                  color: plugSecondaryTextColor,
                                  weight: FontWeight.w400,
                                ),
                                AppVerticalSpacing.verticalSpacingS,
                                CustomInAppTextFormField(
                                  controller: amountController,
                                  obscureText: false,
                                  readonly: false,
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return ("Input your desired amount");
                                    }
                                    return null;
                                  },
                                  fillColor: const Color(0xffF5F5F5),
                                  hintText: 'Enter Amount',
                                  textInputType: TextInputType.number,
                                  textInputAction: TextInputAction.done,
                                ),
                              ],
                            )),
                        Spacer(),
                        CustomButtonWithIconRight(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final amount =
                                  int.parse(amountController.text.trim());
                              final random = Random();
                              final refId = 'ref${random.nextInt(999999999)}d';

                              print(refId);

                              await airtimeNotifier.purchaseAirtime(
                                  AirtimePayment(
                                      amount: amount,
                                      number: phoneController.text,
                                      provider: provider,
                                      reference: refId),
                                  context);
                              airtimeNotifier.setProvider(provider);
                              airtimeNotifier.setRechargeAmount(amount);
                              airtimeNotifier
                                  .setPhoneNumber(phoneController.text);
                              airtimeNotifier.setRefId(refId);
                              // user.loadWallet(context);
                            }
                          },
                          title: airtimeNotifier.isPaymentLoading
                              ? "Processing"
                              : "Send",
                          gradient: gradient2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

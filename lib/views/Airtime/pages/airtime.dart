import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Airtime/model/airtimePayment.dart';
import 'package:mra/views/Airtime/model/airtime_provider_model.dart';
import 'package:mra/views/Airtime/service/airtime_service.dart';
import '../../../res/import/import.dart';

class Airtime extends StatefulWidget {
  const Airtime({super.key});

  @override
  State<Airtime> createState() => _AirtimeState();
}

class _AirtimeState extends State<Airtime> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  int currentIndex = 0;

  AirtimeProviderModel? providersData;
  late Future<AirtimeProviderModel?> futureAirtimeProvider;

  AirtimePayment? paymentData;
  late Future<AirtimePayment?> futurePaymentProvider;

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
    futureAirtimeProvider = loadAirtimeProvider();
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
    final airtimePaymentNotifier = Provider.of<AirtimeProvider>(context, listen: true);

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
                  minHeight: constraints.maxHeight
                ),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
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
                          height: 50.h,
                          width: double.maxFinite,
                          child: FutureBuilder(
                            future: futureAirtimeProvider,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data?.data.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          currentIndex = index;
                                          provider = snapshot.data?.data[index].network ?? 'MTN';
                                        });

                                        print(snapshot.data?.data[index].network);
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 8.0),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: currentIndex == index ? AppColors.plugPrimaryColor : AppColors.white
                                          ),
                                          shape: BoxShape.circle,
                                        ),
                                        child: CircleAvatar(
                                          radius: 30.r,
                                          backgroundImage: snapshot.data!.data[index].network == 'MTN'
                                          ? const AssetImage('assets/images/mtn.png')
                                          : snapshot.data!.data[index].network == 'GLO'
                                          ? const AssetImage('assets/images/bills/GLO-Airtime.jpg')
                                          : snapshot.data!.data[index].network == 'AIRTEL'
                                          ? const AssetImage('assets/images/bills/Airtel-Airtime.jpg')
                                          : snapshot.data!.data[index].network == '9MOBILE'
                                          ? const AssetImage('assets/images/bills/9mobile-Airtime.jpg')
                                          : null
                                          
                                        ),
                                      ),
                                      // child: Container(
                                      //   width: 60.w,
                                      //   margin: const EdgeInsets.all(8.0),
                                      //   decoration: BoxDecoration(
                                      //     border: Border.all(
                                      //       width: 1.5,
                                      //       color: currentIndex == index ? AppColors.plugPrimaryColor : AppColors.white
                                      //     ),
                                      //     shape: BoxShape.circle,
                                      //   ),
                                      //   child: snapshot.data!.data[index].network == 'MTN'
                                      //   ? Image.asset('assets/images/mtn.png')
                                      //   : snapshot.data!.data[index].network == 'GLO'
                                      //   ? Image.asset('assets/images/bills/GLO-Airtime.jpg', fit: BoxFit.fill,)
                                      //   : snapshot.data!.data[index].network == 'AIRTEL'
                                      //   ? Image.asset('assets/images/bills/Airtel-Airtime.jpg')
                                      //   : snapshot.data!.data[index].network == '9MOBILE'
                                      //   ? Image.asset('assets/images/bills/9mobile-Airtime.jpg')
                                      //   : SizedBox.shrink()
                                      // ),
                                    );
                                  },
                                );
                              } 
                              else if (snapshot.hasError) {
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
                              MyText(title: 'Mobile Number', size: 14, color: plugSecondaryTextColor, weight: FontWeight.w400,),

                              AppVerticalSpacing.verticalSpacingS,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: const Color(0xffF5F5F5),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset('assets/images/naijaimg.png'),
                                            
                                            AppHorizontalSpacing.horizontalSpacingS,
                                            MyText(title: '+234', color: plugBlack,size: 16,),
                                            
                                            Expanded(
                                              child: CustomInAppTextFormField(
                                                obscureText: false,
                                                readonly: false,
                                                fillColor: const Color(0xffF5F5F5),
                                                controller: phoneController,
                                                validator: (val) {
                                                  if (val!.isEmpty || val.length < 10) {
                                                    return ("Input your 11 digits phone number");
                                                  }
                                                  return null;
                                                },
                                                hintText: 'Enter phone number',
                                                textInputType: TextInputType.number,
                                                textInputAction: TextInputAction.done,
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
                                          radius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30),),
                                          widget: SizedBox(
                                            height: 400,
                                            width: MediaQuery.of(context).size.width,
                                            child: FutureBuilder(
                                              future: getContacts(),
                                              builder: (context, snapshot) {
                                                var contacts = snapshot.data;

                                                return snapshot.hasData
                                                ? ListView.builder(
                                                    itemCount: contacts!.length,
                                                    itemBuilder: (context, i) {
                                                      Contact contact = snapshot.data![i];
                                                      phoneController.text = contact.phones[0].number;

                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            contact;
                                                          });
                                                          Navigator.pop(context);
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 20),
                                                          child: Column(
                                                            children: [
                                                              AppVerticalSpacing.verticalSpacingD,
                                                              Container(
                                                                padding: const EdgeInsets.all(10),
                                                                height: 70,
                                                                width: MediaQuery.of(context).size.width,
                                                                child:
                                                                  Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    CircleAvatar(
                                                                      radius: 20,
                                                                      child: Icon(Icons.person, color: plugTetTextColor,),
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

                                                              const Divider(color: Color(0xffF5F5F5), thickness: 2,),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    })
                                                    : snapshot.hasError
                                                    ? Center(
                                                        child: MyText(
                                                          title: 'NO Contacts Available On this device',
                                                          size: 24, weight: FontWeight.w700, color: plugBlack,
                                                        ),
                                                      )
                                                    : Center(
                                                        child: MyText(
                                                          title: 'LOADING.....', size: 24, weight: FontWeight.w700, color: plugBlack,
                                                        ),
                                                      );
                                                }
                                              ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Image.asset('assets/images/add_contacts.png'),
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
                          )
                        ),
                        
                        Spacer(),
                        CustomButtonWithIconRight(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              final amount = int.parse(amountController.text.trim());
                              final random = Random();
                              final refId = 'ref${random.nextInt(999999999)}d';

                              print(refId);

                              await airtimePaymentNotifier.purchaseAirtime(
                                AirtimePayment(
                                  amount: amount, number: phoneController.text, provider: provider, reference: refId
                                ),
                                context
                              );
                              airtimePaymentNotifier.setProvider(provider);
                              airtimePaymentNotifier.setRechargeAmount(amount);
                              airtimePaymentNotifier.setPhoneNumber(phoneController.text);
                              airtimePaymentNotifier.setRefId(refId);
                              user.loadWallet(context);
                            }
                          },
                          title: airtimePaymentNotifier.isPaymentLoading ? "Processing" : "Send",
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

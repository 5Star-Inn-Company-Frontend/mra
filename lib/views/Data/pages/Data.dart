import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Airtime/model/airtime_provider_model.dart';
import 'package:mra/views/Airtime/service/airtime_service.dart';
import 'package:mra/views/Data/model/data_plans_model.dart';
import 'package:mra/views/Data/model/data_types_model.dart';
import 'package:mra/views/Data/pages/data_pin.dart';
import 'package:mra/views/Transfer/constants/textField.dart';
import '../../../res/import/import.dart';

class Data extends StatefulWidget {
  const Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  TextEditingController controller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int? selectedProviderIndex;
  int? selectedDataTypeIndex;

  int? selectedRadioTile;

  int? selectedPlanId;
  String? selectedPlanName;

  bool isVisible = false;
  bool isValid = true;

  String packageType = 'SME';
  String provider = "MTN";

  String _country = 'Nigeria';
  String _countryCode = '234';
  String? formattedCode;

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  late Future<DataTypesModel?> futureDataTypes;
  late Future<AirtimeProviderModel?> futureDataProvider;
  late Future<DataPlansModel?> futureDataPlans;

  Future<DataTypesModel?> loadDataTypes(String service) async {
    final token = await const FlutterSecureStorage().read(key: 'token');

    try {
      final response = await ApiService.dio.get(
        '/types-data/$service',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('data type: ${response.data}');
        return DataTypesModel.fromJson(response.data);
      }
    }  on DioException catch (e) {
      if (DioExceptionType.badResponse == e.type) {
        throw Exception('Unable to fetch data types');
      }
      if (DioExceptionType.connectionError == e.type ||
          DioExceptionType.connectionTimeout == e.type ||
          DioExceptionType.receiveTimeout == e.type ||
          DioExceptionType.sendTimeout == e.type) {
        throw Exception('Unable to make requests, try again');
      }
    }

    return null;
  }

  Future<DataPlansModel?> loadDataPlans(String service, String packageType) async {
    final token = await const FlutterSecureStorage().read(key: 'token');

    try {
      final response = await ApiService.dio.get(
        '/list-data/$service/$packageType',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return DataPlansModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (DioExceptionType.badResponse == e.type) {
        throw Exception('Unable to fetch Data Plans');
      }
      if (DioExceptionType.connectionError == e.type ||
          DioExceptionType.connectionTimeout == e.type ||
          DioExceptionType.receiveTimeout == e.type ||
          DioExceptionType.sendTimeout == e.type) {
        throw Exception('Unable to make requests, try again');
      }
    }

    return null;
  }

  Future<List<Contact>> getContacts() async {
    bool isGranted = await Permission.contacts.status.isGranted;
    if (!isGranted) {
      isGranted = await Permission.contacts.request().isGranted;
    }
    if (isGranted) {
      return await FastContacts.getAllContacts();
    }
    if (mounted) {
      setState(() {});
    }
    return [];
  }


  @override
  void initState() {
    super.initState();
    getContacts();
    selectedRadioTile;
    futureDataTypes = loadDataTypes(provider);
    futureDataProvider = loadAirtimeProvider();
    futureDataPlans = loadDataPlans(provider, packageType);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserDataProvider>(context, listen: true);
    final dataNotifier = Provider.of<DataProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PlugAppBarTwo(title: "Data"),
      body: ResponsiveScreen(
        mobile: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        MyText(
                          title: 'Select Network Provider',
                          size: 14,
                          color: plugSecondaryTextColor,
                        ),

                        AppVerticalSpacing.verticalSpacingS,
                        SizedBox(
                          height: 120.h,
                          width: double.maxFinite,
                          child: FutureBuilder(
                            future: futureDataProvider,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return GridView.builder(
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 5.0,
                                    mainAxisSpacing: 0.0,
                                    childAspectRatio: 0.7,
                                  ),
                                  itemCount: snapshot.data?.data.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedProviderIndex = index;
                                          provider = snapshot.data?.data[index].network ?? "MTN";
                                          futureDataTypes = loadDataTypes(provider);
                                        });

                                        print(snapshot.data?.data[index].network);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            width: 2,
                                            color: selectedProviderIndex == index ? AppColors.plugPrimaryColor : AppColors.white
                                          ),
                                          borderRadius: BorderRadius.circular(10)
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            snapshot.data!.data[index].network == 'MTN'
                                            ? Image.asset('assets/images/mtn.png')
                                            : snapshot.data!.data[index].network == 'GLO'
                                            ? Image.asset('assets/images/bills/GLO-Airtime.jpg')
                                            : snapshot.data!.data[index].network == 'AIRTEL'
                                            ? Image.asset('assets/images/bills/Airtel-Airtime.jpg')
                                            : snapshot.data!.data[index].network == '9MOBILE'
                                            ? Image.asset('assets/images/bills/9mobile-Airtime.jpg')
                                            : SizedBox.shrink(),

                                            Text(
                                              snapshot.data!.data[index].network,
                                              style: GoogleFonts.poppins(
                                                color: selectedProviderIndex == index ? AppColors.plugPrimaryColor : Colors.black,
                                                fontSize: 13.sp,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        )
                                      )
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

                        AppVerticalSpacing.verticalSpacingS,
                        MyText(
                          title: 'Mobile Number',
                          size: 14,
                          color: plugSecondaryTextColor,
                          weight: FontWeight.w400,
                        ),

                        AppVerticalSpacing.verticalSpacingS,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: IntlPhoneField(
                                      controller: phonecontroller,
                                      decoration: textInputDecoration.copyWith(
                                          hintText: '0000 0000 0000',
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          fillColor: Color(0xffF5F5F5),
                                          focusedErrorBorder:InputBorder.none
                                        ),
                                      initialCountryCode: 'NG',
                                      initialValue: '00000000000',
                                      autofocus: false,
                                      validator: (p0) {
                                        if (phonecontroller.text.length != 10 || phonecontroller.text.length != 11) {
                                          return ("Invalid phone number");
                                        }
                                        return null;
                                      },
                                      flagsButtonMargin: const EdgeInsets.only(left: 10),
                                      dropdownIconPosition: IconPosition.trailing,
                                      dropdownIcon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textPrimaryColor,),
                                      disableLengthCheck: true,
                                      textInputAction: TextInputAction.next,
                                      onChanged: (phone) {
                                        setState(() {
                                          _countryCode = phone.countryCode;
                                        });
                                      },
                                      onCountryChanged: (country) {
                                        setState(() {
                                          _country = country.name;
                                        });
                                      },
                                    ),
                                  ),
                                ],
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
                                      width: MediaQuery.of(context).size.width,
                                      child: FutureBuilder(
                                          future: getContacts(),
                                          builder: (context, snapshot) {
                                            if (snapshot.data == null) {
                                              return const Text(
                                                "No contacts found"
                                              );
                                            }
                                            var contacts = snapshot.data;
                                            return snapshot.hasData
                                                ? ListView.builder(
                                                    itemCount: contacts!.length,
                                                    itemBuilder: (context, i) {
                                                      Contact contact = snapshot.data![i];
                                                      controller.text = contact.phones[0].number;
                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {contact;});
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
                                                                child: Row(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    CircleAvatar(
                                                                      radius: 20,
                                                                      child: Icon(Icons.person, color:plugTetTextColor,),
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
                                                    }
                                                  )
                                                : snapshot.hasError
                                                ? Center(
                                                    child: MyText(
                                                      title:'No Contacts Available On this device',
                                                      size: 24,
                                                      weight: FontWeight.w700,
                                                      color: plugBlack,
                                                    ),
                                                  )
                                                : Center(
                                                    child: MyText(
                                                      title: 'LOADING.....',
                                                      size: 24,
                                                      weight:
                                                          FontWeight.w700,
                                                      color: plugBlack,
                                                    ),
                                                  );
                                          }),
                                    ),
                                  ),
                                );
                              },
                              child: Image.asset('assets/images/add_contacts.png'),
                            ),
                          ],
                        ),

                        AppVerticalSpacing.verticalSpacingN,
                        MyText(
                          title: 'Select Data Type',
                          fonts: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: plugTextColor,
                          ),
                        ),

                        Gap(10.h),
                        FutureBuilder<DataTypesModel?>(
                          future: futureDataTypes,
                          builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(child: Text('Error: ${snapshot.error}'));
                          } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
                            return Center(child: Text('No cable plans available'));
                          } else {
                            final dataTypes = snapshot.data!;
                            return SizedBox(
                              height: 75.h,
                              width: double.maxFinite,
                              child: GridView.count(
                                crossAxisCount: 3,
                                crossAxisSpacing: 3.0,
                                mainAxisSpacing: 3.0,
                                childAspectRatio: 3,
                                children: [
                                  for (var i = 0; i < dataTypes.data.length; i++)
                                    _buildDataTypesItem(dataTypes.data[i], i),
                                ],
                              ),
                            );
                          }}
                        ),
                        
                        Gap(10.h),
                        MyText(
                          title: 'Select Data Plan',
                          fonts: GoogleFonts.roboto(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: plugTextColor,
                          ),
                        ),

                        FutureBuilder(
                          future: futureDataPlans,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
                              return Center(child: Text('No data plans available'));
                            } else {
                              final dataPlans = snapshot.data!;
                              return Visibility(
                                visible: dataPlans.data.isNotEmpty ? true : false,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(parent: ScrollPhysics()),
                                  itemCount: dataPlans.data.length,
                                  itemBuilder: (context, index) {
                                    return RadioListTile(
                                      contentPadding: EdgeInsets.zero,
                                      value: index,
                                      groupValue: selectedRadioTile,
                                      title: TextSemiBold(
                                        dataPlans.data[index].name,
                                        textAlign: TextAlign.left,
                                      ),
                                      subtitle: TextSemiBold('Price: N${dataPlans.data[index].amount}'),
                                      onChanged: (value) {
                                        setSelectedRadioTile(value!);
                                        setState(() {
                                          selectedPlanId = dataPlans.data[index].id;
                                          selectedPlanName = dataPlans.data[index].name;
                                        });
                                        print(dataPlans.data[index].amount);
                                        print(selectedPlanId);
                                        print(selectedPlanName);
                                      },
                                      activeColor: AppColors.plugPrimaryColor,
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),

                        Gap(30.h),
                        CustomButtonWithIconRight(
                          onPressed: () async {
                            if (selectedRadioTile != null && phonecontroller.text.length != 10 || phonecontroller.text.length != 11 &&
                              _formKey.currentState!.validate()) {
                              final random = Random();
                              final refId = 'ref${random.nextInt(999999999)}d';

                              await dataNotifier.purchaseData(
                                DataPayment(
                                  networkID: selectedPlanId.toString(), phone: phonecontroller.text
                                ),
                                context
                              );
                              
                              dataNotifier.setDataPayment(
                                selectedPlanId.toString(),
                                phonecontroller.text,
                              );
                              dataNotifier.setNetworkID(selectedPlanId.toString());
                              dataNotifier.setPhone(phonecontroller.text);
                              dataNotifier.setReference(refId);
                              dataNotifier.setProvider(provider);
                              dataNotifier.setPlanName(selectedPlanName.toString());

                              user.loadWallet(context);

                              // await Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //     builder: (context) => const DataPin(),
                              //   ),
                              // );
                            } 
                            else if (selectedRadioTile == null) {
                              Flushbar(
                                message: 'Pls select a data plan, to continue',
                                duration: Duration(seconds: 3),
                                isDismissible: true,
                                backgroundColor: Colors.red,
                              ).show(context);
                            } 
                            else if (phonecontroller.text.length != 10 || phonecontroller.text.length != 11) {
                              Flushbar(
                                message: 'Input a valid phone number, to continue',
                                duration: Duration(seconds: 3),
                                isDismissible: true,
                                backgroundColor: Colors.red,
                              ).show(context);
                            }
                          },
                          // title: 'SEND',
                          title: dataNotifier.isPaymentLoading ? "Processing" : "Send",
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


  void _changeDataType(String selectedService, int index) {
    setState(() {
      packageType = selectedService;
      selectedDataTypeIndex = index;
      futureDataPlans = loadDataPlans(provider, packageType);
    });
  }

  _buildDataTypesItem(DataCategory dataCategory, int index) {
    return GestureDetector(
      onTap: () => _changeDataType(dataCategory.category, index),
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 5, right: 5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: selectedDataTypeIndex == index ? AppColors.plugPrimaryColor : AppColors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: MyText(
          title: dataCategory.category,
          size: 12,
          color: plugSecondaryTextColor,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}

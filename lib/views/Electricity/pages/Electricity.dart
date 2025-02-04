import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Electricity/model/powerPayment.dart';
import 'package:mra/views/Electricity/model/powerValidate.dart';
import 'package:mra/views/Electricity/model/power_provider_model.dart';
import 'package:mra/views/Electricity/model/power_validate_model.dart';
import 'package:mra/views/Electricity/services/power_service.dart';
import '../../../res/import/import.dart';

class Electricity extends StatefulWidget {
  const Electricity({super.key});

  @override
  State<Electricity> createState() => _ElectricityState();
}

class _ElectricityState extends State<Electricity> {
  final meterNo = TextEditingController();
  final TextEditingController customerName = TextEditingController();
  final TextEditingController amount = TextEditingController();

  int currentIndex = 0;
  final _formKey = GlobalKey<FormState>();

  int tvNumber = 0;

  int? subAmount; 
  String minAmount = "500";

  String powerCode = "ikeja-electric";

  bool isCustomer = false;

  bool _isLoading = false;

  // PowerProviderModel? providersData;
  late Future<PowerProviderModel?> futurePowerProvider;
  PowerValidateModel? _validatePowerSub;
  String provider = "IKEDC";
  int selectedProviderId = 1;


  @override
  void initState() {
    super.initState();
    futurePowerProvider = loadPowerProvider();
    provider = "IKEDC";
  }

  @override
  Widget build(BuildContext context) {
    final powerNotifier = Provider.of<PowerProvider>(context, listen: true);
    int limitAmount = int.parse(minAmount.toString());
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PlugAppBarTwo(
        title: 'Electricity',
        centerTitle: true,
      ),
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
                          title: 'Select Electricity Distributor',
                          size: 14,
                          color: plugSecondaryTextColor,
                        ),
  
                        Gap(10.h),
                        SizedBox(
                          height: 220,
                          width: double.maxFinite,
                          child: FutureBuilder<PowerProviderModel?>(
                              future: futurePowerProvider,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4, // Number of columns in the grid
                                      crossAxisSpacing: 10.0, // Spacing between columns
                                      mainAxisSpacing: 5.0, // Spacing between rows
                                      childAspectRatio: 0.7, // Aspect ratio  
                                    ),
                                    itemCount: snapshot.data!.data.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            currentIndex = index;
                                            provider = snapshot.data?.data[index].name ?? 'IKEDC';
                                            // minAmount = snapshot.data ?.data?[index].minAmount ?? '500';
                                            powerCode = snapshot.data?.data[index].code ?? "ikeja-electric";
                                            selectedProviderId = (snapshot.data?.data[index].id ?? 1);
                                          });
                                          print(snapshot.data?.data[index].name);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            border: Border.all(
                                              color: currentIndex == index ? AppColors.plugPrimaryColor : Colors.transparent,
                                              width: 2,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              snapshot.data!.data[index].code == 'ikeja-electric'
                                                ? Image.asset('assets/images/bills/Ikeja-Electric-Payment-PHCN.jpg')
                                                : snapshot.data!.data[index].code == 'eko-electric'
                                                ? Image.asset('assets/images/bills/Eko-Electric-Payment-PHCN.jpg')
                                                : snapshot.data!.data[index].code == 'kano-electric'
                                                ? Image.asset('assets/images/bills/Kano-Electric.jpg')
                                                : snapshot.data!.data[index].code == 'portharcourt-electric'
                                                ? Image.asset('assets/images/bills/Port-Harcourt-Electric.jpg')
                                                : snapshot.data!.data[index].code == 'jos-electric'
                                                ? Image.asset('assets/images/bills/Jos-Electric-JED.jpg')
                                                : snapshot.data!.data[index].code == 'ibadan-electric'
                                                ? Image.asset('assets/images/bills/IBEDC-Ibadan-Electricity-Distribution-Company.jpg')
                                                : snapshot.data!.data[index].code == 'kaduna-electric'
                                                ? Image.asset('assets/images/bills/Kaduna-Electric-KAEDCO.jpg')
                                                : snapshot.data!.data[index].code == 'abuja-electric'
                                                ? Image.asset('assets/images/bills/Abuja-Electric.jpg')
                                                // : snapshot.data!.data[index].code == 'enugu-electric'
                                                // ? Image.asset('assets/images/bills/9mobile-Airtime.jpg')
                                                : Container(),

                                              Text(
                                                snapshot.data!.data[index].name,
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 13.5.sp,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                } 
                                else if (snapshot.connectionState == ConnectionState.waiting) {
                                  return Center(child: CircularProgressIndicator());
                                }
                                else if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } 
                                else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
                                  return Center(child: Text('No cable plans available'));
                                }
                                else {
                                  return Text(
                                    'Something went wrong',
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 13.5.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }
                              },
                            ),
                        ),

                        Gap(30.h),
                        MyText(
                          title: 'Meter Number',
                          size: 14,
                          color: plugSecondaryTextColor,
                          weight: FontWeight.w400,
                        ),

                        Gap(10.h),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomInAppTextFormField(
                                obscureText: false,
                                readonly: false,
                                controller: meterNo,
                                fillColor: const Color(0xffF5F5F5),
                                hintText: 'Enter IUC number',
                                textInputType: TextInputType.number,
                                validator: (val) {
                                  if (val!.isEmpty && val.length >= 10) {
                                    return ("IUC number must be 10 characters");
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.done,
                                onchanged: (val) {
                                  if (_formKey.currentState!.validate() &&
                                      meterNo.text.length >= 10) {
                                    if (val!.isNotEmpty) {
                                      int intValue = int.parse(val.toString());
                                      if (intValue.toString().length >= 10) {
                                        setState(() {
                                          tvNumber = intValue;
                                        });
                                        // validateCableSub(intValue, "DSTV");
                                      }
                                    }
                                  } else {
                                    setState(() {
                                      isCustomer = false;
                                    });
                                  }
                                },
                              ),

                              Gap(screenHeight(context) * 0.02),
                              Visibility(
                                visible: isCustomer,
                                child: Column(
                                  children: [
                                    CustomInAppTextFormField(
                                      obscureText: false,
                                      controller: customerName,
                                      readonly: false,
                                      onchanged: (val) {
                                        if (val!.isNotEmpty) {
                                          int intValue = int.parse(val.toString());
                                          setState(() {
                                            subAmount = intValue;
                                          });
                                        }
                                      },
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return ('Input amount');
                                        }

                                        // if (val.toString() < minAmount) {

                                        // }
                                      },
                                      fillColor: const Color(0xffF5F5F5),
                                      hintText: _validatePowerSub?.data ?? '',
                                      textInputType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                    ),

                                    Gap(screenHeight(context) * 0.02),
                                    CustomInAppTextFormField(
                                      obscureText: false,
                                      controller: amount,
                                      readonly: false,
                                      fillColor: const Color(0xffF5F5F5),
                                      hintText: '10,000',
                                      textInputType: TextInputType.number,
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        CustomButtonWithIconRight(
                          icon: Visibility(
                            visible: _isLoading ? true : false,
                            child: Container(
                              margin: const EdgeInsets.only(left: 10),
                              width: 30,
                              height: 20,
                              child: const CupertinoActivityIndicator(
                                color: AppColors.white,
                              )
                            )
                          ),
                          onPressed: () async {
                            if (_formKey.currentState!.validate() && meterNo.text.length >= 10) {
                              if (isCustomer == false) {
                                setState(() {
                                  _isLoading = true;
                                });
                                validatePowerSub(tvNumber, provider, selectedProviderId);
                              } 
                              else {
                                int intValue = int.parse(amount.text.toString());
                                final random = Random();
                                final refId = 'ref${random.nextInt(999999999)}d';
                                
                                if (intValue < limitAmount) {
                                  Flushbar(
                                    message: 'Minimum is ${limitAmount.toString()}',
                                    duration: const Duration(seconds: 3),
                                  ).show(context);
                                } 
                                else {
                                  print(powerCode);
                                  await powerNotifier.purchasePower(
                                    PowerPayment(
                                      amount: intValue, 
                                      code: powerCode, 
                                      number: tvNumber, 
                                      provider: provider, 
                                      reference: refId, 
                                      type: 'Prepaid'
                                    ),
                                    context
                                  );
                                  powerNotifier.setProvider(provider);
                                  powerNotifier.setNumber(tvNumber);
                                  powerNotifier.setRechargeAmount(intValue);
                                  powerNotifier.setRefId(refId);
                                  powerNotifier.setCode(powerCode);
                                }
                              }
                            }
                          },
                          title: isCustomer ? 'Send' : 'Verify',
                          gradient: gradient2,
                        )
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


  //validate cable data
  Future<PowerValidateModel?> validatePowerSub(int meterNumber, String powerProvider, int providerId) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    setState(() {
      _isLoading == true;
    });

    try {
      final response = await ApiService.dio.post('/validate-electricity',
          data: {
            "id": providerId,
            "type": "prepaid",
            "phone": meterNumber.toInt()
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['status'] == true) {
          print(response.data);
          setState(() {
            _isLoading = false;
          });
          final validatePower = PowerValidateModel.fromJson(response.data);

          setState(() {
            _validatePowerSub = validatePower;
            customerName.text = _validatePowerSub?.data ?? '';
            isCustomer = true;
          });
        } else if (response.data["status"] == false) {
          print(response.data);
          setState(() {
            isCustomer = false;
            _isLoading = false;
          });
          // ignore: use_build_context_synchronously
          Flushbar(
            message: response.data['message'],
            backgroundColor: AppColors.textPrimaryColor,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 2),
            flushbarStyle: FlushbarStyle.GROUNDED,
            isDismissible: true,
          ).show(context);
        }
        // return CablePlans.fromJson(response.data);
      }
    } on DioException catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (DioExceptionType.badResponse == e.type) {
        throw Exception('Unable to fetch data');
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
}

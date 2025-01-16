import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/Electricity/model/powerPayment.dart';
import 'package:mra/views/Electricity/model/powerProviders.dart';
import 'package:mra/views/Electricity/model/powerValidate.dart';
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

  String powerCode = "IKEDC";

  bool isCustomer = false;

  bool _isLoading = false;

  PowerProviders? providersData;

  late Future<PowerProviders?> futureProvider;

  PowerValidate? _validatePowerSub;

  String provider = "IKEDC";

  @override
  void initState() {
    super.initState();
    futureProvider = loadPowerProvider();
    String provider = "IKEDC";
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 30.0, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          title: 'Select Electricity Distributor',
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
                                              'IKEDC';
                                          minAmount = snapshot.data
                                                  ?.data?[index].minAmount ??
                                              '500';
                                          powerCode = snapshot
                                                  .data?.data?[index].code ??
                                              "IKEDC";
                                        });
                                        print(snapshot
                                            .data?.data?[index].provider);
                                        print(snapshot.data?.data?[index].code);
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
                        MyText(
                          title: 'Meter Number',
                          size: 14,
                          color: plugSecondaryTextColor,
                          weight: FontWeight.w400,
                        ),
                        AppVerticalSpacing.verticalSpacingS,
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
                                          int intValue =
                                              int.parse(val.toString());
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
                                      hintText: _validatePowerSub
                                              ?.data?.customerName ??
                                          '',
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
                                  ))),
                          onPressed: () async {
                            if (_formKey.currentState!.validate() &&
                                meterNo.text.length >= 10) {
                              if (isCustomer == false) {
                                setState(() {
                                  _isLoading = true;
                                });
                                validatePowerSub(tvNumber, provider);
                              } else {
                                int intValue =
                                    int.parse(amount.text.toString());
                                final random = Random();
                                final refId =
                                    'ref${random.nextInt(999999999)}d';
                                if (intValue < limitAmount) {
                                  Flushbar(
                                    message:
                                        'Minimum is ${limitAmount.toString()}',
                                    duration: const Duration(seconds: 3),
                                  ).show(context);
                                } else {
                                  print(powerCode);
                                  await powerNotifier.purchasePower(
                                      PowerPayment(
                                          amount: intValue,
                                          code: powerCode,
                                          number: tvNumber,
                                          provider: provider,
                                          reference: refId,
                                          type: 'Prepaid'),
                                      context);
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
  Future<void> validatePowerSub(int meterNumber, String powerProvider) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    setState(() {
      _isLoading == true;
    });

    try {
      final response = await ApiService.dio.post('/electricity-validate',
          data: {
            'number': meterNumber.toInt(),
            'provider': powerProvider,
            'type': 'prepaid'
          },
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['success'] == true) {
          print(response.data);
          setState(() {
            _isLoading = false;
          });
          final validatePower = PowerValidate.fromJson(response.data);

          setState(() {
            _validatePowerSub = validatePower;
            customerName.text = _validatePowerSub?.data?.customerName ?? '';
            isCustomer = true;
          });
        } else if (response.data["success"] == false) {
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
  }
}

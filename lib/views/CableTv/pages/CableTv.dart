import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mra/constant/app_colors.dart';
import 'package:mra/constant/loader.dart';
import 'package:mra/core/network/api_client.dart';
import 'package:mra/utils/ui_helpers.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/CableTv/changeNotifier/cableNotifier.dart';
import 'package:mra/views/CableTv/model/cablePayment.dart';
import 'package:mra/views/CableTv/model/cablePlans.dart';
import 'package:mra/views/CableTv/model/validateCableSub.dart';
import 'package:mra/views/CableTv/services/cableProvider.dart';
import 'package:mra/views/Data/model/dataProviders.dart';
import 'package:provider/provider.dart';

import '../../../res/import/import.dart';

class CableTv extends StatefulWidget {
  CableTv({Key? key}) : super(key: key);

  @override
  State<CableTv> createState() => _CableTvState();
}

class _CableTvState extends State<CableTv> {
  final TextEditingController IUC = TextEditingController();
  final TextEditingController customerName = TextEditingController();

  int selectedRadioTile = 0;

  int tvNumber = 0;

  String provider = 'DSTV';

  String? tvPackageCode;
  int? number;

  bool isCustomer = false;

  bool _isLoading = false;

  CablePlans? _cablePlans;

  ValidateCableSub? _validateCableSub;

  //get Cable plans
  Future<CablePlans> loadCablePlans(String service) async {
    final token = await const FlutterSecureStorage().read(key: 'token');

    print(token);
    try {
      final response = await ApiService.dio.get('/cabletv-plans/$service',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final dataPlans = CablePlans.fromJson(response.data);

        setState(() {
          _cablePlans = dataPlans;
        });

        print(_cablePlans?.data.runtimeType);
      }
    } on DioException catch (e) {
      if (DioExceptionType.badResponse == e.type) {
        throw Exception('Unable to fetch Providers');
      }
      if (DioExceptionType.connectionError == e.type ||
          DioExceptionType.connectionTimeout == e.type ||
          DioExceptionType.receiveTimeout == e.type ||
          DioExceptionType.sendTimeout == e.type) {
        throw Exception('Unable to make requests, try again');
      }
    }
    return CablePlans(success: false, message: "", data: []);
  }

  //validate cable data
  Future<void> validateCableSub(int iucNumber, String cableProvider) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    setState(() {
      _isLoading == true;
    });

    try {
      final response = await ApiService.dio.post('/cabletv-validate',
          data: {'number': iucNumber.toInt(), 'provider': cableProvider},
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['success'] == true) {
          print(response.data);
          setState(() {
            _isLoading = false;
          });
          final validateCable = ValidateCableSub.fromJson(response.data);

          setState(() {
            _validateCableSub = validateCable;
            customerName.text = _validateCableSub?.data?.customerName ?? '';
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

  late Future<DataProviders?> futureCableProvider;
  Future<CablePlans>? futureCablePlans;

  int currentIndex = 0;

  final _formKey = GlobalKey<FormState>();

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    selectedRadioTile = 0;
    futureCableProvider = loadCableProvider();
    _isLoading = false;
  }

  @override
  void dispose() {
    // _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cableNotifier = Provider.of<CableProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PlugAppBarTwo(title: "CABLE TV"),
      body: ResponsiveScreen(
        mobile: LayoutBuilder(
          builder: (context, constraints) {
            return ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              children: [
                MyText(
                  title: 'Select TV Provider',
                  size: 14,
                  color: plugSecondaryTextColor,
                ),
                AppVerticalSpacing.verticalSpacingS,
                SizedBox(
                  height: 80,
                  width: double.maxFinite,
                  child: FutureBuilder(
                    future: futureCableProvider,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data!.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              focusNode: _focusNode,
                              onTap: () {
                                setState(() {
                                  currentIndex = index;
                                  provider =
                                      snapshot.data?.data?[index].provider ??
                                          "DSTV";
                                });
                                futureCablePlans = loadCablePlans(
                                    snapshot.data!.data?[index].provider ?? '');
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
                                    borderRadius: BorderRadius.circular(8),
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
                                  snapshot.data?.data![index].providerLogoUrl
                                          .toString() ??
                                      '',
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
                  title: 'IUC Number',
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
                        controller: IUC,
                        fillColor: const Color(0xffF5F5F5),
                        hintText: 'Enter IUC number',
                        textInputType: TextInputType.number,
                        validator: (val) {
                          if (val!.isEmpty && val.length == 9) {
                            return ("IUC number must be 10 characters");
                          }
                          return null;
                        },
                        textInputAction: TextInputAction.done,
                        onchanged: (val) {
                          if (_formKey.currentState!.validate()) {
                            if (val!.isNotEmpty) {
                              int intValue = int.parse(val.toString());
                              if (intValue.toString().length == 10) {
                                setState(() {
                                  tvNumber = intValue;
                                });
                                // validateCableSub(intValue, "DSTV");
                              } else {
                                setState(() {
                                  isCustomer = false;
                                });
                              }
                            }
                          }
                        },
                      ),
                      Gap(screenHeight(context) * 0.02),
                      Visibility(
                        visible: isCustomer,
                        child: CustomInAppTextFormField(
                          obscureText: false,
                          controller: customerName,
                          readonly: true,
                          fillColor: const Color(0xffF5F5F5),
                          hintText: _validateCableSub?.data?.customerName ?? '',
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ),

                ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _cablePlans?.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    // if (condition) {}
                    return RadioListTile(
                      contentPadding: EdgeInsets.zero,
                      value: index,
                      groupValue: selectedRadioTile,
                      title: Text(_cablePlans?.data?[index].name ?? ''),
                      onChanged: (value) {
                        setSelectedRadioTile(value!);
                        // print(selectedRadioTile);
                        print(_cablePlans?.data?[index].code);
                        setState(() {
                          tvPackageCode = _cablePlans?.data?[index].code;
                          print(tvPackageCode);
                        });
                      },
                      activeColor: AppColors.plugPrimaryColor,
                    );
                  },
                ),
                // const Spacer(),
                AppVerticalSpacing.verticalSpacingS,
                AppVerticalSpacing.verticalSpacingXS,
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
                    // if (_formKey.currentState!.validate()) {
                    if (isCustomer == false) {
                      setState(() {
                        _isLoading = true;
                      });
                      validateCableSub(tvNumber, provider);
                    } else {
                      final random = Random();
                      final refId = 'ref${random.nextInt(999999999)}d';
                      await cableNotifier.purchaseTv(
                          CablePayment(
                              code: tvPackageCode,
                              number: tvNumber,
                              provider: provider,
                              reference: refId),
                          context);
                      cableNotifier.setProvider(provider);
                      cableNotifier.setRefId(refId);
                      cableNotifier.setRechargeCode(tvPackageCode.toString());
                      cableNotifier.setIucNumber(tvNumber);
                      // }
                    }
                    print(
                        '$provider, ${cableNotifier.refId}, $tvPackageCode, $tvNumber');
                  },
                  title: isCustomer ? 'Send' : 'Verify',
                  gradient: gradient2,
                ),
                AppVerticalSpacing.verticalSpacingS,
              ],
            );
          },
        ),
      ),
    );
  }
}

// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mra/utils/widget/appbar_two.dart';
// import 'package:mra/views/CableTv/model/cable_plans_model.dart';
// import 'package:mra/views/CableTv/model/cable_validate_model.dart';
// import 'package:mra/views/Data/model/dataProviders.dart';
// import '../../../res/import/import.dart';

// class CableTv extends StatefulWidget {
//   const CableTv({Key? key}) : super(key: key);

//   @override
//   State<CableTv> createState() => _CableTvState();
// }

// class _CableTvState extends State<CableTv> {
//   final TextEditingController iucController = TextEditingController();
//   final TextEditingController customerName = TextEditingController();

//   int selectedRadioTile = 0;

//   int tvNumber = 0;

//   String service = 'dstv';

//   String? tvPackageCode;
//   int? number;

//   bool isCustomer = false;

//   bool _isLoading = false;

//   CablePlans? _cablePlans;
//   CableValidateModel? _validateCableSub;

//   //get Cable plans
//   Future<CablePlans?> loadCablePlans(String service) async {
//     final token = await const FlutterSecureStorage().read(key: 'token');

//     try {
//       final response = await ApiService.dio.get(
//         '/list-tv/$service',
//         options: Options(headers: {'Authorization': 'Bearer $token'}));

//       // print('Response status code: ${response.statusCode}'); // Log the status code
//       // print('Response data: ${response.data}'); // Log the response data
//       print('Service: $service');

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print('list of cable plans: ${response.data}');
//         return CablePlans.fromJson(response.data);

//       }
//     } on DioException catch (e) {
//       if (DioExceptionType.badResponse == e.type) {
//         throw Exception('Unable to fetch providers');
//       }
//       if (DioExceptionType.connectionError == e.type ||
//           DioExceptionType.connectionTimeout == e.type ||
//           DioExceptionType.receiveTimeout == e.type ||
//           DioExceptionType.sendTimeout == e.type) {
//         throw Exception('Unable to make requests, try again');
//       }
//     }
//     return null;
//   }

//   //validate cable data
//   Future<void> validateCableSub(int iucNumber, String cableProvider) async {
//     final token = await const FlutterSecureStorage().read(key: 'token');
//     setState(() {
//       _isLoading == true;
//     });

//     try {
//       final response = await ApiService.dio.post('/validate-tv',
//         data: {'networkID': cableProvider, 'phone': iucNumber.toInt()},
//         options: Options(headers: {'Authorization': 'Bearer $token'})
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         if (response.data['status'] == true) {
//           print(response.data);
//           setState(() {
//             _isLoading = false;
//           });
//           final validateCableModel = CableValidateModel.fromJson(response.data);

//           setState(() {
//             _validateCableSub = validateCableModel;
//             customerName.text = _validateCableSub?.data ?? '';
//             isCustomer = true;
//           });
//         } else if (response.data["status"] == false) {
//           print(response.data);
//           setState(() {
//             isCustomer = false;
//             _isLoading = false;
//           });
//           // ignore: use_build_context_synchronously
//           Flushbar(
//             message: response.data['message'],
//             backgroundColor: AppColors.plugPrimaryColor,
//             flushbarPosition: FlushbarPosition.TOP,
//             duration: const Duration(seconds: 2),
//             flushbarStyle: FlushbarStyle.GROUNDED,
//             isDismissible: true,
//           ).show(context);
//         }
//         // return CablePlans.fromJson(response.data);
//       }
//     } on DioException catch (e) {
//       setState(() {
//         _isLoading = false;
//       });
//       if (DioExceptionType.badResponse == e.type) {
//         throw Exception('Unable to fetch data');
//       }
//       if (DioExceptionType.connectionError == e.type ||
//           DioExceptionType.connectionTimeout == e.type ||
//           DioExceptionType.receiveTimeout == e.type ||
//           DioExceptionType.sendTimeout == e.type) {
//         throw Exception('Unable to make requests, try again');
//       }
//     }
//   }

//   late Future<DataProviders?> futureCableProvider;
//   late Future<CablePlans?> futureCablePlans; 

//   int currentIndex = 0;

//   final _formKey = GlobalKey<FormState>();

//   setSelectedRadioTile(int val) {
//     setState(() {
//       selectedRadioTile = val;
//     });
//   }

//   // final FocusNode _focusNode = FocusNode(); 

//   @override
//   void initState() {
//     super.initState();
//     selectedRadioTile = 0;
//     futureCablePlans = loadCablePlans(service);
//     _isLoading = false;
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // final cableNotifier = Provider.of<CableProvider>(context, listen: true);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: const PlugAppBarTwo(title: "CABLE TV"),
//       body: ResponsiveScreen(
//         mobile: LayoutBuilder(
//           builder: (context, constraints) {
//             return ListView(
//               padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
//               children: [
//                 MyText(
//                   title: 'Select TV Provider',
//                   size: 14,
//                   color: plugSecondaryTextColor,
//                 ),

//                 Gap(20.h),
//                 SizedBox(
//                   height: 120.h,
//                   width: double.maxFinite,
//                   child: GridView.count(
//                     crossAxisCount: 4,
//                     crossAxisSpacing: 5.0,
//                     mainAxisSpacing: 0.0,
//                     childAspectRatio: 0.7,
//                     children: [
//                       _buildGridItem('gotv', 'assets/images/bills/Gotv-Payment.jpg', 0),
//                       _buildGridItem('dstv', 'assets/images/bills/Pay-DSTV-Subscription.jpg', 1),
//                       _buildGridItem('startimes', 'assets/images/bills/Startimes-Subscription.jpg', 2),
//                       _buildGridItem('showmax', 'assets/images/bills/ShowMax.jpg', 3),
//                     ],
//                   ),
//                 ),

//                 AppVerticalSpacing.verticalSpacingS,
//                 MyText(
//                   title: 'IUC Number',
//                   size: 14,
//                   color: plugSecondaryTextColor,
//                   weight: FontWeight.w400,
//                 ),

//                 AppVerticalSpacing.verticalSpacingS,
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: [
//                       CustomInAppTextFormField(
//                         obscureText: false,
//                         readonly: false,
//                         controller: iucController,
//                         fillColor: const Color(0xffF5F5F5),
//                         hintText: 'Enter IUC number',
//                         textInputType: TextInputType.number,
//                         validator: (val) {
//                           if (val!.isEmpty && val.length == 9) {
//                             return ("IUC number must be 10 characters");
//                           }
//                           return null;
//                         },
//                         textInputAction: TextInputAction.done,
//                         onchanged: (val) {
//                           if (_formKey.currentState!.validate()) {
//                             if (val!.isNotEmpty) {
//                               int intValue = int.parse(val.toString());
//                               if (intValue.toString().length == 10) {
//                                 setState(() {
//                                   tvNumber = intValue;
//                                 });
//                                 validateCableSub(intValue, service);
//                               } else {
//                                 setState(() {
//                                   isCustomer = false;
//                                 });
//                               }
//                             }
//                           }
//                         },
//                       ),
//                       Gap(screenHeight(context) * 0.02),
//                       Visibility(
//                         visible: isCustomer,
//                         child: CustomInAppTextFormField(
//                           obscureText: false,
//                           controller: customerName,
//                           readonly: true,
//                           fillColor: const Color(0xffF5F5F5),
//                           hintText: _validateCableSub?.data ?? '',
//                           textInputType: TextInputType.number,
//                           textInputAction: TextInputAction.done,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),


//                 Gap(10.h),
//                 FutureBuilder(
//                   future: loadCablePlans('gotv'),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return Center(child: Text('Error: ${snapshot.error}'));
//                     } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
//                       return Center(child: Text('No cable plans available'));
//                     } else {
//                       final cablePlans = snapshot.data;
//                       return ListView.builder(
//                         padding: EdgeInsets.zero,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: cablePlans?.data.length,
//                         itemBuilder: (context, index) {
//                           return RadioListTile(
//                             contentPadding: EdgeInsets.zero,
//                             value: index,
//                             groupValue: selectedRadioTile,
//                             title: MyText(
//                               title: cablePlans!.data[index].name,
//                               size: 14,
//                               color: plugSecondaryTextColor,
//                               weight: FontWeight.w600,
//                             ),
//                             // subtitle: Text(cablePlans!.data[index].price),
//                             onChanged: (value) {
//                               setSelectedRadioTile(value!);
//                               setState(() {
//                                 tvPackageCode = cablePlans.data[index].code;
//                               });
//                             },
//                             activeColor: AppColors.plugPrimaryColor,
//                           );
//                         },
//                       );
//                     }
//                   },
//                 ),

//                 // const Spacer(),
//                 AppVerticalSpacing.verticalSpacingS,
//                 AppVerticalSpacing.verticalSpacingXS,
//                 // CustomButtonWithIconRight(
//                 //   icon: Visibility(
//                 //       visible: _isLoading ? true : false,
//                 //       child: Container(
//                 //           margin: const EdgeInsets.only(left: 10),
//                 //           width: 30,
//                 //           height: 20,
//                 //           child: const CupertinoActivityIndicator(
//                 //             color: AppColors.white,
//                 //           ))),
//                 //   onPressed: () async {
//                 //     // if (_formKey.currentState!.validate()) {
//                 //     if (isCustomer == false) {
//                 //       setState(() {
//                 //         _isLoading = true;
//                 //       });
//                 //       validateCableSub(tvNumber, provider);
//                 //     } else {
//                 //       final random = Random();
//                 //       final refId = 'ref${random.nextInt(999999999)}d';
//                 //       await cableNotifier.purchaseTv(
//                 //           CablePayment(
//                 //               code: tvPackageCode,
//                 //               number: tvNumber,
//                 //               provider: provider,
//                 //               reference: refId),
//                 //           context);
//                 //       cableNotifier.setProvider(provider);
//                 //       cableNotifier.setRefId(refId);
//                 //       cableNotifier.setRechargeCode(tvPackageCode.toString());
//                 //       cableNotifier.setIucNumber(tvNumber);
//                 //       // }
//                 //     }
//                 //     print(
//                 //         '$provider, ${cableNotifier.refId}, $tvPackageCode, $tvNumber');
//                 //   },
//                 //   title: isCustomer ? 'Send' : 'Verify',
//                 //   gradient: gradient2,
//                 // ),
//                 AppVerticalSpacing.verticalSpacingS,
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildGridItem(String serviceName, String imagePath, int index) {
//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         currentIndex = index;
//         service = serviceName;
//       });
//       print(service);
//     },
//     child: Container(
//       padding: EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
//       decoration: BoxDecoration(
//         border: Border.all(
//           width: 2,
//           color: currentIndex == index ? AppColors.plugPrimaryColor : AppColors.white,
//         ),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Image.asset(imagePath),
//           Text(serviceName.toUpperCase(), style: TextStyle(fontSize: 12)),
//         ],
//       ),
//     ),
//   );
// }
// }


import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mra/utils/widget/appbar_two.dart';
import 'package:mra/views/CableTv/model/cable_plans_model.dart';
import 'package:mra/views/CableTv/model/cable_validate_model.dart';
import '../../../res/import/import.dart';

class CableTv extends StatefulWidget {
  const CableTv({super.key});

  @override
  State<CableTv> createState() => _CableTvState();
}

class _CableTvState extends State<CableTv> {
  final TextEditingController iucController = TextEditingController();
  final TextEditingController customerName = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int selectedRadioTile = 0;
  int tvNumber = 0;
  String service = 'dstv'; // Default service
  String? tvPackageCode;
  int? number;
  bool isCustomer = false;
  bool _isLoading = false;

  CableValidateModel? _validateCableSub;

  CablePlans? _cablePlans;
  late Future<CablePlans?> futureCablePlans;

  @override
  void initState() {
    super.initState();
    futureCablePlans = loadCablePlans(service);
  }

  Future<CablePlans?> loadCablePlans(String service) async {
    final token = await const FlutterSecureStorage().read(key: 'token');

    try {
      final response = await ApiService.dio.get(
        '/list-tv/$service',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('Service: $service');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print('List of cable plans: ${response.data}');
        return CablePlans.fromJson(response.data);
      }
    } on DioException catch (e) {
      if (DioExceptionType.badResponse == e.type) {
        throw Exception('Unable to fetch providers');
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

  //validate cable data
  Future<void> validateCableSub(int iucNumber, String cableProvider) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    setState(() {
      _isLoading == true;
    });

    try {
      final response = await ApiService.dio.post('/validate-tv',
        data: {'networkID': cableProvider, 'phone': iucNumber.toInt()},
        options: Options(headers: {'Authorization': 'Bearer $token'})
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data['status'] == true) {
          print(response.data);
          setState(() {
            _isLoading = false;
          });
          final validateCableModel = CableValidateModel.fromJson(response.data);

          setState(() {
            _validateCableSub = validateCableModel;
            customerName.text = _validateCableSub?.data ?? '';
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
            backgroundColor: AppColors.plugPrimaryColor,
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

  int currentIndex = 0;

  void _changeService(String selectedService, int index) {
    setState(() {
      service = selectedService;
      currentIndex = index;
      futureCablePlans = loadCablePlans(service); // Update future to reload plans
    });
  }

  @override
  Widget build(BuildContext context) {
    // final cableNotifier = Provider.of<CableProvider>(context, listen: true);

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
                Gap(20.h),
                SizedBox(
                  height: 120.h,
                  width: double.maxFinite,
                  child: GridView.count(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 0.0,
                    childAspectRatio: 0.7,
                    children: [
                      _buildGridItem('dstv', 'assets/images/bills/Pay-DSTV-Subscription.jpg', 0),
                      _buildGridItem('gotv', 'assets/images/bills/Gotv-Payment.jpg', 1),
                      _buildGridItem('startimes', 'assets/images/bills/Startimes-Subscription.jpg', 2),
                      _buildGridItem('showmax', 'assets/images/bills/ShowMax.jpg', 3),
                    ],
                  ),
                ),

                AppVerticalSpacing.verticalSpacingS,
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
                        controller: iucController,
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
                                validateCableSub(intValue, service);
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
                          hintText: _validateCableSub?.data ?? '',
                          textInputType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ],
                  ),
                ),
                

                Gap(10.h),
                FutureBuilder<CablePlans?>(
                  future: futureCablePlans, // Use updated future variable
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.data.isEmpty) {
                      return Center(child: Text('No cable plans available'));
                    } else {
                      final cablePlans = snapshot.data!;
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cablePlans.data.length,
                        itemBuilder: (context, index) {
                          return RadioListTile(
                            contentPadding: EdgeInsets.zero,
                            value: index,
                            groupValue: selectedRadioTile,
                            title: MyText(
                              title: cablePlans.data[index].name,
                              size: 14,
                              color: plugSecondaryTextColor,
                              weight: FontWeight.w600,
                            ),
                            onChanged: (value) {
                              setState(() {
                                selectedRadioTile = value!;
                                tvPackageCode = cablePlans.data[index].code;
                              } );
                            },
                            activeColor: AppColors.plugPrimaryColor,
                          );
                        },
                      );
                    }
                  },
                ),

                Gap(20.h),
                // CustomButtonWithIconRight(
                //   icon: Visibility(
                //     visible: _isLoading ? true : false,
                //     child: Container(
                //       margin: const EdgeInsets.only(left: 10),
                //       width: 30,
                //       height: 20, 
                //       child: const CupertinoActivityIndicator(
                //         color: AppColors.white,
                //       )
                //     )
                //   ),
                //   onPressed: () async {
                //     if (isCustomer == false) {
                //       setState(() {
                //         _isLoading = true;
                //       });
                //       validateCableSub(tvNumber, service);
                //     } else {
                //       // final random = Random();
                //       // final refId = 'ref${random.nextInt(999999999)}d';
                //       final cablePlans = _cablePlans!.data[selectedRadioTile];
                //       await cableNotifier.purchaseTv(
                //         cablePlans.id, // networkID
                //         tvNumber, //number
                //         context
                //         // cableNotifier.setProvider(service);
                //         // cableNotifier.setRefId(refId);
                //         // cableNotifier.setRechargeCode(tvPackageCode.toString());
                //         // cableNotifier.setIucNumber(tvNumber);
                //       );
                //     }
                //     print('$service, ${cableNotifier.refId}, $tvNumber');
                //   },
                //   title: isCustomer ? 'Send' : 'Verify',
                //   gradient: gradient2,
                // ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildGridItem(String serviceName, String imagePath, int index) {
    return GestureDetector(
      onTap: () => _changeService(serviceName, index),
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 10, left: 5, right: 5),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: currentIndex == index ? AppColors.plugPrimaryColor : AppColors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(imagePath, height: 50.h, width: 50.w),
            MyText(
              title: serviceName.toUpperCase(),
              size: 12,
              color: plugSecondaryTextColor,
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}

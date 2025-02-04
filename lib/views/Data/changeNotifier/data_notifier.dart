import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mra/res/import/import.dart';
import 'package:mra/views/Data/model/data_purchase_model.dart';
import 'package:mra/views/Data/pages/data_confirmation.dart';
import 'package:mra/views/Data/pages/data_pin.dart';
// import 'package:mra/views/Electricity/pages/powerConfirmation.dart';
// import 'package:mra/views/Electricity/pages/powerPin.dart';

class DataProvider with ChangeNotifier {
  String? _networkID;
  String? _phone;
  String? _planName;
  String? _provider;
  String? _reference;

  String? get networkID => _networkID;
  String? get phone => _phone;
  String? get provider => _provider;
  String? get reference => _reference;
  String? get planName => _planName;

  void setPlanName(String planName) {
    _planName = planName;
    notifyListeners();
  }

  void setProvider(String provider) {
    _provider = provider;
    notifyListeners();
  }

  void setReference(String reference) {
    _reference = reference;
    notifyListeners();
  }

  void setNetworkID(String networkID) {
    _networkID = networkID;
    notifyListeners();
  }

  void setPhone(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void setDataPayment(String networkID, String phone) {
    _networkID = networkID;
    _phone = phone;

    notifyListeners();
  }

  bool _isPaymentLoading = false;
  bool get isPaymentLoading => _isPaymentLoading;

  bool _pinAuthenticated = false;
  bool get pinAuthenticated => _pinAuthenticated;

  void setPinAuth(bool value) {
    _pinAuthenticated = value;
    notifyListeners();
  }

  void setPaymentLoading(bool value) {
    _isPaymentLoading = value;
    notifyListeners();
  }

  // Future<DataPurchaseModel?> purchaseData(BuildContext context) async {
  //   final token = await const FlutterSecureStorage().read(key: 'token');

  //   if (pinAuthenticated == true) {
  //     try {
  //       setPaymentLoading(true);
  //       if (isPaymentLoading == true) {
  //         showCupertinoDialog(
  //           context: context,
  //           builder: (context) {
  //             return const Loading();
  //           }
  //         );
  //       }

  //       final response = await ApiService.dio.post(
  //         '/purchase-data',
  //         data: json.encode({'networkID': networkID, 'phone': phone,}),
  //         options: Options(headers: {'Authorization': 'Bearer $token'}
  //         )
  //       );

  //       if (response.statusCode == 200 || response.statusCode == 201) {
  //         setPaymentLoading(false);
  //         if (isPaymentLoading == false) {
  //           Navigator.pop(context);
  //         }
  //         setPinAuth(false);
  //         print(response.data);

  //         if (response.data['status'] == true) {
  //           Navigator.of(context).push(
  //             MaterialPageRoute(builder: (context) => const DataConfirmation()),
  //           );
  //         } else {
  //           Flushbar(
  //                   message: "Unable to buy data, try again ",
  //                   flushbarStyle: FlushbarStyle.GROUNDED,
  //                   isDismissible: true,
  //                   flushbarPosition: FlushbarPosition.TOP,
  //                   duration: const Duration(seconds: 2),
  //                   backgroundColor: AppColors.plugPrimaryColor)
  //               .show(context);
  //         }
  //       }
  //     } on DioException catch (e) {
  //       setPaymentLoading(false);
  //       if (isPaymentLoading == false) {
  //         Navigator.pop(context);
  //       }
  //       if (DioExceptionType.badResponse == e.type) {
  //         Flushbar(
  //                 message: "Unable to buy data, try again ",
  //                 flushbarStyle: FlushbarStyle.GROUNDED,
  //                 isDismissible: true,
  //                 flushbarPosition: FlushbarPosition.TOP,
  //                 duration: const Duration(seconds: 2),
  //                 backgroundColor: AppColors.plugPrimaryColor)
  //             .show(context);
  //       }
  //       if (DioExceptionType.connectionError == e.type ||
  //           DioExceptionType.connectionTimeout == e.type ||
  //           DioExceptionType.receiveTimeout == e.type ||
  //           DioExceptionType.sendTimeout == e.type) {
  //         Flushbar(
  //                 message: "Poor Internet connection, try again. ",
  //                 flushbarStyle: FlushbarStyle.GROUNDED,
  //                 isDismissible: true,
  //                 flushbarPosition: FlushbarPosition.TOP,
  //                 duration: const Duration(seconds: 2),
  //                 backgroundColor: AppColors.plugPrimaryColor)
  //             .show(context);
  //       }
  //     }
  //   } else {
  //     Flushbar(
  //       message: 'Invalid Transaction Pin',
  //       duration: Duration(seconds: 3),
  //     );
  //   }

  //   notifyListeners();

  //   return null;
  // }


  Future<void> purchaseData(DataPayment payment, BuildContext context) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    if (pinAuthenticated) {
      try {
        setPaymentLoading(true);
        showCupertinoDialog(
          context: context,
          builder: (context) => const Loading(),
        );

        final response = await ApiService.dio.post(
          '/purchase-data',
          data: json.encode(payment.toJson()),
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        setPaymentLoading(false);
        Navigator.pop(context);
        setPinAuth(false);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (response.data['status'] == true) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DataConfirmation()),
            );
          } else {
            _showErrorMessage(response.data['message'].toString(), context);
          }
        }
      } on DioException catch (e) {
        setPaymentLoading(false);
        Navigator.pop(context);
        _handleDioError(e, context);
      }
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const DataPin()),
      );
    }
  }

  void _showErrorMessage(String message, BuildContext context) {
    Flushbar(
      message: message,
      flushbarStyle: FlushbarStyle.GROUNDED,
      isDismissible: true,
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.plugPrimaryColor,
    ).show(context);
  }

  void _handleDioError(DioException e, BuildContext context) {
    String errorMessage = "An error occurred. Please try again.";
    if (e.type == DioExceptionType.badResponse) {
      errorMessage = "Unable to buy data, try again.";
    } else if (e.type == DioExceptionType.connectionError ||
               e.type == DioExceptionType.connectionTimeout ||
               e.type == DioExceptionType.receiveTimeout ||
               e.type == DioExceptionType.sendTimeout) {
      errorMessage = "Poor Internet connection, try again.";
    }
    _showErrorMessage(errorMessage, context);
  }
}



class DataPayment {
  final String networkID;
  final String phone;

  DataPayment({
    required this.networkID,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      "networkID": networkID,
      "phone": phone,
    };
  }
}
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mra/res/import/import.dart';
import 'package:mra/views/Data/model/buyData.dart';
import 'package:mra/views/Data/pages/dataConfirmation.dart';
// import 'package:mra/views/Electricity/pages/powerConfirmation.dart';
// import 'package:mra/views/Electricity/pages/powerPin.dart';

class DataProvider with ChangeNotifier {
  String? _number;
  int? _planId;
  int? _provider;
  String? _reference;

  String? _planName;

  String? get number => _number;
  int? get planId => _planId;
  int? get provider => _provider;
  String? get reference => _reference;

  String? get planName => _planName;

  void setDataPayment(String number, int planId, int provider, String reference,
      String planName) {
    _number = number;
    _planId = planId;
    _provider = provider;
    _reference = reference;
    _planName = planName;

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

  Future<BuyData> purchaseData(BuyData payment, BuildContext context) async {
    final token = await const FlutterSecureStorage().read(key: 'token');

    if (pinAuthenticated == true) {
      try {
        setPaymentLoading(true);
        if (isPaymentLoading == true) {
          showCupertinoDialog(
            context: context,
            builder: (context) {
              return const Loading();
            }
          );
        }

        final response = await ApiService.dio.post(
          '/purchase-data',
          data: json.encode(payment.toJson()),
          options: Options(headers: {'Authorization': 'Bearer $token'}
          )
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          setPaymentLoading(false);
          if (isPaymentLoading == false) {
            Navigator.pop(context);
          }
          setPinAuth(false);
          print(response.data);

          if (response.data['success'] == true) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const DataConfirmation()),
            );
          } else {
            Flushbar(
                    message: "Unable to buy data, try again ",
                    flushbarStyle: FlushbarStyle.GROUNDED,
                    isDismissible: true,
                    flushbarPosition: FlushbarPosition.TOP,
                    duration: const Duration(seconds: 2),
                    backgroundColor: Colors.red)
                .show(context);
          }
        }
      } on DioException catch (e) {
        setPaymentLoading(false);
        if (isPaymentLoading == false) {
          Navigator.pop(context);
        }
        if (DioExceptionType.badResponse == e.type) {
          Flushbar(
                  message: "Unable to buy data, try again ",
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  isDismissible: true,
                  flushbarPosition: FlushbarPosition.TOP,
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.red)
              .show(context);
        }
        if (DioExceptionType.connectionError == e.type ||
            DioExceptionType.connectionTimeout == e.type ||
            DioExceptionType.receiveTimeout == e.type ||
            DioExceptionType.sendTimeout == e.type) {
          Flushbar(
                  message: "Poor Internet connection, try again. ",
                  flushbarStyle: FlushbarStyle.GROUNDED,
                  isDismissible: true,
                  flushbarPosition: FlushbarPosition.TOP,
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.red)
              .show(context);
        }
      }
    } else {
      Flushbar(
        message: 'Invalid Transaction Pin',
        duration: Duration(seconds: 3),
      );
    }

    notifyListeners();

    return BuyData(number: null, planId: null, provider: null, reference: null);
  }
}

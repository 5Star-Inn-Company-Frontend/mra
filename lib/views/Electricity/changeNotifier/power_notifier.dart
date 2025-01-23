import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mra/constant/loader.dart';
import 'package:mra/core/network/api_client.dart';
import 'package:mra/views/Electricity/model/powerPayment.dart';
import 'package:mra/views/Electricity/pages/power_confirmation.dart';
import 'package:mra/views/Electricity/pages/power_pin.dart';

class PowerProvider with ChangeNotifier {
  String? _provider;

  int? _rechargeAmount;

  int? _Number;

  String? _refId;
  String? _code;

  String meterType = 'prepaid';

  String? get code => _code;

  String? get refId => _refId;

  String? get provider => _provider;

  int? get rechargeAmount => _rechargeAmount;

  int? get Number => _Number;

  void setProvider(String provider) {
    _provider = provider;
    notifyListeners();
  }

  void setRechargeAmount(int amount) {
    _rechargeAmount = amount;
    notifyListeners();
  }

  void setNumber(int number) {
    _Number = number;
    notifyListeners();
  }

  void setCode(String code) {
    _code = code;
    notifyListeners();
  }

  void setRefId(String refId) {
    _refId = refId;
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

  Future<PowerPayment> purchasePower(PowerPayment payment, BuildContext context) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    if (pinAuthenticated == true) {
      try {
        setPaymentLoading(true);
        if (isPaymentLoading == true) {
          showCupertinoDialog(
              context: context,
              builder: (context) {
                return const Loading();
              });
        }
        final response = await ApiService.dio.post('/electricity-pay',
            data: json.encode(payment.toJson()),
            options: Options(headers: {'Authorization': 'Bearer $token'}));

        if (response.statusCode == 200 || response.statusCode == 201) {
          setPaymentLoading(false);
          if (isPaymentLoading == false) {
            Navigator.pop(context);
          }
          setPinAuth(false);
          print(response.data);
          if (response.data['success'] == true) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const PowerSuccessConfirmation()),
            );
          } else {
            // ignore: use_build_context_synchronously
            Flushbar(
                    message: response.data['message'].toString(),
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
                  message: "Unable to buy airtime, try again ",
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
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const PowerPin(),
        ),
      );
    }

    return PowerPayment(
        amount: 0, code: '', number: 0, provider: '', reference: '', type: '');
  }
}

import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mra/constant/app_colors.dart';
import 'package:mra/constant/loader.dart';
import 'package:mra/core/network/api_client.dart';
import 'package:mra/views/Electricity/pages/power_confirmation.dart';
import 'package:mra/views/Electricity/pages/power_pin.dart';

class PowerProvider with ChangeNotifier {
  String? _networkId;
  String? _provider;
  int? _rechargeAmount;
  String? _meterNumber;
  String? _refId;
  // String? _code;
  String? _meterType;

  // String? get code => _code;
  String? get networkID => _networkId;
  String? get refId => _refId;
  String? get provider => _provider;
  int? get rechargeAmount => _rechargeAmount;
  String? get meterNumber => _meterNumber;
  String? get meterType => _meterType;

  void setNetworkId(String networkId) {
    _networkId = networkId;
    notifyListeners();
  }

  void setProvider(String provider) {
    _provider = provider;
    notifyListeners();
  }

  void setRechargeAmount(int amount) {
    _rechargeAmount = amount;
    notifyListeners();
  }

  void setMeterNumber(String meterNumber) {
    _meterNumber = meterNumber;
    notifyListeners();
  }

  void setMeterType(String meterType) {
    _meterType = meterType;
    notifyListeners();
  }

  // void setCode(String code) {
  //   _code = code;
  //   notifyListeners();
  // }

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

  Future<void> purchasePower(PowerPayment payment, BuildContext context) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    if (pinAuthenticated) {
      try {
        setPaymentLoading(true);
        showCupertinoDialog(
          context: context,
          builder: (context) => const Loading(),
        );

        final response = await ApiService.dio.post(
          '/purchase-electricity',
          data: json.encode(payment.toJson()),
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        setPaymentLoading(false);
        Navigator.pop(context);
        setPinAuth(false);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (response.data['status'] == true) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const PowerSuccessConfirmation()),
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
        MaterialPageRoute(builder: (context) => const PowerPin()),
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
      backgroundColor: Colors.red,
    ).show(context);
  }

  void _handleDioError(DioException e, BuildContext context) {
    String errorMessage = "An error occurred. Please try again.";
    if (e.type == DioExceptionType.badResponse) {
      errorMessage = "Unable to buy airtime, try again.";
    } else if (e.type == DioExceptionType.connectionError ||
               e.type == DioExceptionType.connectionTimeout ||
               e.type == DioExceptionType.receiveTimeout ||
               e.type == DioExceptionType.sendTimeout) {
      errorMessage = "Poor Internet connection, try again.";
    }
    _showErrorMessage(errorMessage, context);
  }
}


class PowerPayment {
  final String networkID;
  final String type;
  final String phone;
  final int amount;

  PowerPayment({
    required this.networkID,
    required this.type,
    required this.phone,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      "networkID": networkID,
      "type": type,
      "phone": phone,
      "amount": amount,
    };
  }
}
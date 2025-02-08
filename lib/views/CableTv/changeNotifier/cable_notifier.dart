// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mra/constant/app_colors.dart';
import 'package:mra/constant/loader.dart';
import 'package:mra/core/network/api_client.dart';
import 'package:mra/views/CableTv/pages/cable_confirmation.dart';
import 'package:mra/views/CableTv/pages/cable_pin.dart';

class CableProvider with ChangeNotifier {
  String? _provider;
  String? _networkId;
  String? _phone;
  String? _refId;
  String? _customerName;

  String? get refId => _refId;
  String? get provider => _provider;
  String? get networkId => _networkId;
  String? get phone => _phone;
  String? get customerName => _customerName;

  void setProvider(String provider) {
    _provider = provider;
    notifyListeners();
  }

  void setNetworkId(String networkId) {
    _networkId = networkId;
    notifyListeners();
  }

  // void setRechargeCode(String code) {
  //   _Code = code;
  //   notifyListeners();
  // }

  void setIucNumber(String phone) {
    _phone = phone;
    notifyListeners();
  }

  void setRefId(String refId) {
    _refId = refId;
    notifyListeners();
  }

  void setCustomerName(String customerName) {
    _customerName = customerName;
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

  Future<void> purchaseCable(CablePayment payment, BuildContext context) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    if (pinAuthenticated) {
      try {
        setPaymentLoading(true);
        showCupertinoDialog(
          context: context,
          builder: (context) => const Loading(),
        );

        final response = await ApiService.dio.post(
          '/purchase-tv',
          data: json.encode(payment.toJson()),
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        setPaymentLoading(false);
        Navigator.pop(context);
        setPinAuth(false);

        if (response.statusCode == 200 || response.statusCode == 201) {
          if (response.data['status'] == true) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CableConfirmation()),
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
        MaterialPageRoute(builder: (context) => const CablePin()),
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


class CablePayment {
  final String networkID;
  final String phone;

  CablePayment({
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
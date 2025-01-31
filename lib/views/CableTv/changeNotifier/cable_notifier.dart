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
import 'package:mra/views/CableTv/model/cable_payment_model.dart';
import 'package:mra/views/CableTv/pages/cable_confirmation.dart';
import 'package:mra/views/CableTv/pages/cable_pin.dart';

class CableProvider with ChangeNotifier {
  String? _provider;

  String? _Code;

  int? _Number;

  String? _refId;

  String? get refId => _refId;

  String? get provider => _provider;

  String? get code => _Code;

  int? get phoneNumber => _Number;

  void setProvider(String provider) {
    _provider = provider;
    notifyListeners();
  }

  void setRechargeCode(String code) {
    _Code = code;
    notifyListeners();
  }

  void setIucNumber(int number) {
    _Number = number;
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

  Future<CablePaymentModel?> purchaseTv(int networkID, int phone, BuildContext context) async {
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
        final response = await ApiService.dio.post('/purchase-tv',
            data: {'networkID': networkID, 'phone': phone},
            options: Options(headers: {'Authorization': 'Bearer $token'}));

        if (response.statusCode == 200 || response.statusCode == 201) {
          setPaymentLoading(false);
          if (isPaymentLoading == false) {
            Navigator.pop(context);
          }
          setPinAuth(false);
          print(response.data);
          if (response.data['status'] == true) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const CableConfirmation()),
            );
          } else {
            Flushbar(
                message: "Unable to pay tv subscription, try again ",
                flushbarStyle: FlushbarStyle.GROUNDED,
                isDismissible: true,
                flushbarPosition: FlushbarPosition.TOP,
                duration: const Duration(seconds: 2),
                backgroundColor: AppColors.plugPrimaryColor)
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
                  backgroundColor: AppColors.plugPrimaryColor)
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
                  backgroundColor: AppColors.plugPrimaryColor)
              .show(context);
        }
      }
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const CablePin(),
        ),
      );
    }

    return null;
  }
}

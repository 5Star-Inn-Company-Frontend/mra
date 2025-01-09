import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mra/res/import/import.dart';
import 'package:mra/views/Transfer/model/account_transfer.dart';

class TransferNotifier with ChangeNotifier {
  String? _bank;
  String? _bankCode;
  String? _amount;
  String? _description;
  String? _acctNo;
  String? _acctName;
  String? _bankPicture;

  String? get bank => _bank;
  String? get bankCode => _bankCode;
  String? get bankPicture => _bankPicture;
  String? get amount => _amount;
  String? get description => _description;
  String? get acctNo => _acctNo;
  String? get acctName => _acctName;

  void setBankDetails(String bank, String bankCode, String bankPicture) {
    _bank = bank;
    _bankCode = bankCode;
    _bankPicture = bankPicture;
    notifyListeners();
  }

  void setTransferData(
      String description, String acctNo, String acctName, String amount) {
    _acctNo = acctNo;
    _acctName = acctName;
    _description = description;
    _amount = amount;
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

  Future<AccountTransfer> sendTransfer(
      AccountTransfer payment, BuildContext context) async {
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
        final response = await ApiService.dio.post('/bank-transfer',
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
                  builder: (context) => const TransferSuccessful()),
            );
          } else {
            setPinAuth(false);
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
        setPinAuth(false);
        setPaymentLoading(false);
        if (isPaymentLoading == false) {
          Navigator.pop(context);
        }
        if (DioExceptionType.badResponse == e.type) {
          Flushbar(
                  message: "Unable to make transfer, try again ",
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
        message: 'Invalid Pin',
        duration: const Duration(seconds: 2),
      ).show(context);
    }
    return AccountTransfer(
        accountNumber: null,
        bankCode: null,
        amount: null,
        narration: null,
        reference: null,
        pin: null,
        accountName: null);
  }
}

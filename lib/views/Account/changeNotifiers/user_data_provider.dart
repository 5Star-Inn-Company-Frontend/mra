import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mra/constant/app_colors.dart';
import 'package:mra/core/network/api_client.dart';
import 'package:mra/views/Account/model/profile_model.dart';
import 'package:mra/views/Account/model/vaccts_model.dart';
import 'package:mra/views/Account/model/walletResponse.dart';

class UserDataProvider with ChangeNotifier {
  AccountModel? _userData;
  VacctsModel? _userVacctData;
  Wallet? _walletData;

  Wallet? get walletData => _walletData;
  AccountModel? get userData => _userData;
  VacctsModel? get userVacctData => _userVacctData;

  final String _errormsg = '';
  String get errormsg => _errormsg;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setUserData(AccountModel userData) {
    _userData = userData;
    notifyListeners();
  }

  void setUserAccountData(VacctsModel userVacctData){
    _userVacctData = userVacctData; 
    notifyListeners();
  }

  void setWalletData(Wallet walletData) {
    _walletData = walletData;
    notifyListeners();
  }

  Future<AccountModel?> loadUserData(BuildContext context) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    
    if (token == null) {
      print('Error: Token is missing');
      return null;
    }

    try {
      setLoading(true);

      final response = await ApiService.dio.get(
        '/profile',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final userData = AccountModel.fromJson(response.data['data']);

        setUserData(userData);

        print('User data loaded successfully: $userData');
        return userData;

      } 
      else {
        print('Error: Unexpected status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException caught: ${e.message}');
      print('Error type: ${e.type}');
      print('Error response: ${e.response?.data}');

      if (DioExceptionType.badResponse == e.type) {
        print("Error in internet");
        Flushbar(
          message: "Unable to make request, try again ",
          flushbarStyle: FlushbarStyle.GROUNDED,
          isDismissible: true,
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red
        ).show(context);
      }
      if (DioExceptionType.connectionError == e.type ||
          DioExceptionType.connectionTimeout == e.type ||
          DioExceptionType.receiveTimeout == e.type ||
          DioExceptionType.sendTimeout == e.type) {
        print("Error in internet");
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
    finally {
      setLoading(false);
    }

    return null;
  }


  Future<VacctsModel?> loadVacctsData(BuildContext context) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    
    if (token == null) {
      print('Error: Token is missing');
      return null;
    }

    try {
      setLoading(true);

      final response = await ApiService.dio.get(
        '/vaccts',
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      // print('Vaccts API response: ${response.data}'); // Debugging line

      if (response.statusCode == 200 || response.statusCode == 201) {
        final vacctsData = VacctsModel.fromJson(response.data);

        setUserAccountData(vacctsData);

        // print('Vaccts data loaded successfully: $vacctsData');
        return vacctsData;

      } 
      else {
        print('Error: Unexpected status code ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException caught: ${e.message}');
      print('Error type: ${e.type}');
      print('Error response: ${e.response?.data}');

      if (DioExceptionType.badResponse == e.type) {
        print("Error in internet");
        Flushbar(
          message: "Unable to make request, try again ",
          flushbarStyle: FlushbarStyle.GROUNDED,
          isDismissible: true,
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red
        ).show(context);
      }
    } finally {
      setLoading(false);
    }
    return null;
  }


  Future<Wallet?> loadWallet(BuildContext context) async {
    final token = await const FlutterSecureStorage().read(key: 'token');

    try {
      final response = await ApiService.dio.get(
        '/wallets',
         options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // print(response.data['data']);
        final walletData = Wallet.fromJson(response.data);
        setWalletData(walletData);
        print('Wallet data loaded successfully: $walletData');
        print('wallet data: ${response.data['data']}');
        
        return walletData;

      } else {
        print('Error: Unexpected status code ${response.statusCode}');
        print('Response data: ${response.data}');
        Flushbar(
          message: 'Unexpected error occurred. Please try again.',
          flushbarStyle: FlushbarStyle.GROUNDED,
          isDismissible: true,
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ).show(context);
      }
    } on DioException catch (e) {
      print('DioException caught: ${e.message}');
      print('Error type: ${e.type}');
      print('Error response: ${e.response?.data}');

      if (DioExceptionType.badResponse == e.type) {
        print("Error in internet ");
        Flushbar(
                message: "Unable to make request, try again ",
                flushbarStyle: FlushbarStyle.GROUNDED,
                isDismissible: true,
                flushbarPosition: FlushbarPosition.TOP,
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.red)
            .show(context);
      }
      if ([
            DioExceptionType.connectionError,
            DioExceptionType.connectionTimeout,
            DioExceptionType.receiveTimeout,
            DioExceptionType.sendTimeout,
          ].contains(e.type)) {
        print("Error in internet");
        Flushbar(
                message: "Poor Internet connection, try again. ",
                flushbarStyle: FlushbarStyle.GROUNDED,
                isDismissible: true,
                flushbarPosition: FlushbarPosition.TOP,
                duration: const Duration(seconds: 2),
                backgroundColor: Colors.red)
            .show(context);
      }
    } catch (e) {
      print('Unexpected error: $e');
      Flushbar(
        message: 'Unexpected error occurred. Please try again.',
        flushbarStyle: FlushbarStyle.GROUNDED,
        isDismissible: true,
        flushbarPosition: FlushbarPosition.TOP,
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
      ).show(context);
    }

    return null;
  }
}
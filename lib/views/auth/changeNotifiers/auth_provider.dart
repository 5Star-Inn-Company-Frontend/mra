import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:mra/res/import/import.dart';

class AuthProvider with ChangeNotifier {
  final storage = const FlutterSecureStorage();

  String? _token;
  String _errormsg = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String get errormsg => _errormsg!;
  String get token => _token!;
  bool get isAuthenticated => _token != null;

  Future<LoginRequest> login(LoginRequest login, BuildContext context) async {
    try {
      setLoading(true);
      if (isLoading == true) {
        showCupertinoDialog(
          context: context,
          builder: (context) {
            return const Loading();
          }
        );
      }
 
      final response = await ApiService.dio.post(
        '/login',
        data: json.encode(login.toJson()),
      );

      if (response.statusCode == 200) {
        if (response.data['status'] == true) {
          // setLoading(false);
          // if (isLoading == false) {
          //   Navigator.pop(context);
          // }


          setLoading(false);
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // Close the loader dialog
          }
          // print(response.data);

          _token = response.data['data']['access_token'];
          await storage.write(key: 'token', value: _token);

          notifyListeners();
          // print("token: $_token");

          Flushbar(
            message: "${response.data['status']} successful",
            flushbarStyle: FlushbarStyle.GROUNDED,
            isDismissible: true,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red
          ).show(context);

          // Navigator.pushReplacement(context, 
          //   MaterialPageRoute(builder: (context) => const DashBoard())
          // );

        } else if (response.data['status'] == false) {
          // setLoading(false);
          // // if (isLoading == false) {
          // Navigator.pop(context);
          // // } 

          // setLoading(false);
          // if (Navigator.canPop(context)) {
          //   Navigator.pop(context); // Close the loader dialog
          // }
          
          print(isLoading);
          print(response.data['status']);
          Flushbar(
            message: 'Invalid email or password',
            flushbarStyle: FlushbarStyle.GROUNDED,
            isDismissible: true,
            flushbarPosition: FlushbarPosition.TOP,
            duration: const Duration(seconds: 2),
            backgroundColor: Colors.red
          ).show(context);
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
        notifyListeners();
      }
    } on DioException catch (error) {
      print('DioException caught: ${error.message}');
      print('Error type: ${error.type}');
      print('Error response: ${error.response?.data}');

      if (DioExceptionType.connectionTimeout == error.type || DioExceptionType.receiveTimeout == error.type || DioExceptionType.connectionError == error.type) {
        setLoading(false);
        if (isLoading == false) {
          Navigator.pop(context);
        }
        _errormsg = "No internet connection, try again";
        Flushbar(
          message: _errormsg,
          flushbarStyle: FlushbarStyle.GROUNDED,
          isDismissible: true,
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red
        ).show(context);
      }
      // print(error.response!.data['message']['message']);
      if (error.response?.data != null) {
        setLoading(false);
        if (isLoading == false) {
          Navigator.pop(context);
        } 

        print(error.response);
        _errormsg = error.response!.data['message'].toString();
        Flushbar(
          message: _errormsg,
          flushbarStyle: FlushbarStyle.GROUNDED,
          isDismissible: true,
          flushbarPosition: FlushbarPosition.TOP,
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.red,
        ).show(context);
      }
      notifyListeners();
    }
    return LoginRequest(email: "", password: "");
  }


  // Future<LoginRequest> login(LoginRequest login, BuildContext context) async {
  //   try {
  //     setLoading(true);
  //     showCupertinoDialog(
  //       context: context,
  //       builder: (context) {
  //         return const Loading();
  //       },
  //     );

  //     final response = await ApiService.dio.post(
  //       '/login',
  //       data: json.encode(login.toJson()),
  //     );

  //     setLoading(false);
  //     if (Navigator.canPop(context)) {
  //       Navigator.pop(context); // Close the loader dialog
  //     }

  //     if (response.statusCode == 200 && response.data['status'] == true) {
  //       _token = response.data['data']['access_token'];
  //       await storage.write(key: 'token', value: _token);
  //       notifyListeners();

  //       Flushbar(
  //         message: "Login successful",
  //         flushbarStyle: FlushbarStyle.GROUNDED,
  //         isDismissible: true,
  //         flushbarPosition: FlushbarPosition.TOP,
  //         duration: const Duration(seconds: 2),
  //         backgroundColor: Colors.red,
  //       ).show(context);
  //     } else {
  //       Flushbar(
  //         message: 'Invalid email or password',
  //         flushbarStyle: FlushbarStyle.GROUNDED,
  //         isDismissible: true,
  //         flushbarPosition: FlushbarPosition.TOP,
  //         duration: const Duration(seconds: 2),
  //         backgroundColor: Colors.red,
  //       ).show(context);
  //     }
  //   } on DioException catch (error) {
  //     setLoading(false);
  //     if (Navigator.canPop(context)) {
  //       Navigator.pop(context);
  //     }

  //     String errorMessage = "An error occurred. Please try again.";
  //     if (error.type == DioExceptionType.connectionTimeout ||
  //         error.type == DioExceptionType.receiveTimeout ||
  //         error.type == DioExceptionType.connectionError) {
  //       errorMessage = "No internet connection, try again.";
  //     } else if (error.response?.data != null) {
  //       errorMessage = error.response!.data['message'].toString();
  //     }

  //     Flushbar(
  //       message: errorMessage,
  //       flushbarStyle: FlushbarStyle.GROUNDED,
  //       isDismissible: true,
  //       flushbarPosition: FlushbarPosition.TOP,
  //       duration: const Duration(seconds: 2),
  //       backgroundColor: Colors.red,
  //     ).show(context);
  //   }

  //   return LoginRequest(email: "", password: "");
  // }



  Future<void> logout() async {
    _token = null;
    await storage.delete(key: 'token');
    notifyListeners();
  }

  //check Authentication
  Future<void> checkAuthentication() async {
    final token = await storage.read(key: 'token');

    if (token != null) {
      _token = token;
      notifyListeners();
    }
  }
}

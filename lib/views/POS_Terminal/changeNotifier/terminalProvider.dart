// ignore_for_file: use_build_context_synchronously

import 'package:mra/res/import/import.dart';
import 'package:mra/views/POS_Terminal/model/terminal.dart';

class TerminalProvider with ChangeNotifier {
  Terminal? _terminalData;

  Terminal? get terminalData => _terminalData;

  String _errormsg = '';

  String get errormsg => _errormsg;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setTerminalData(Terminal terminalData) {
    _terminalData = terminalData;
    notifyListeners();
  }

  Future<Terminal?> loadTerminal(BuildContext context) async {
    final token = await const FlutterSecureStorage().read(key: 'token');
    try {
      final response = await ApiService.dio.get('/terminals',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final terminalData = Terminal.fromJson(response.data);
        setTerminalData(terminalData);
      }
    } on DioException catch (e) {
      if (DioExceptionType.badResponse == e.type) {
        // print('Bad response ${e.message}');
        Flushbar(
                message: "Unable to make request, try again ",
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

    return null;
  }
}

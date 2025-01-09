import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mra/core/network/api_client.dart';

class UpdateAccountPinService {
  Future<Response> updatePin(String current, String newPin) async {
    final token = await const FlutterSecureStorage().read(key: 'token');

    // print(token);
    final dio = Dio();

    dio.interceptors.add(
      AwesomeDioInterceptor(),
    );

    try {
      final response = await ApiService.dio.post('/update-pin',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {"current": current, "new": newPin});

      return response;
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}

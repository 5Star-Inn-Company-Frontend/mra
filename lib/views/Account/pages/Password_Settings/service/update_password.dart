import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mra/core/network/api_client.dart';

class UpdatePasswordService {
  Future<Response> updatePin(String current, String newPassword) async {
    final token = await FlutterSecureStorage().read(key: 'token');

    // print(token);
    final dio = Dio();

    dio.interceptors.add(
      AwesomeDioInterceptor(),
    );

    try {
      final response = await ApiService.dio.post('/update-password',
          options: Options(headers: {'Authorization': 'Bearer $token'}),
          data: {"current": current, "new": newPassword});

      return response;
    } catch (error) {
      print(error.toString());
      rethrow;
    }
  }
}

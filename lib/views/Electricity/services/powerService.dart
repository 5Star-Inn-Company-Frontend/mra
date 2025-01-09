import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mra/core/network/api_client.dart';
import 'package:mra/views/Electricity/model/powerProviders.dart';

Future<PowerProviders?> loadPowerProvider() async {
  final token = await const FlutterSecureStorage().read(key: 'token');
  try {
    final response = await ApiService.dio.get('/electricity-providers',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return PowerProviders.fromJson(response.data);
    }
  } on DioException catch (e) {
    if (DioExceptionType.badResponse == e.type) {
      throw Exception('Unable to fetch Providers');
    }
    if (DioExceptionType.connectionError == e.type ||
        DioExceptionType.connectionTimeout == e.type ||
        DioExceptionType.receiveTimeout == e.type ||
        DioExceptionType.sendTimeout == e.type) {
      throw Exception('Unable to make requests, try again');
    }
  }

  return null;
}

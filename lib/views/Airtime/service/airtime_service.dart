import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mra/core/network/api_client.dart';
import 'package:mra/views/Airtime/model/airtime_provider_model.dart';


Future<AirtimeProviderModel?> loadAirtimeProvider() async {
  final token = await const FlutterSecureStorage().read(key: 'token');
  try {
    final response = await ApiService.dio.get(
      '/list-airtime',
      options: Options(headers: {'Authorization': 'Bearer $token'}));

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('list of airtime: ${response.data}');
      return AirtimeProviderModel.fromJson(response.data);
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

// Future<AirtimePayment> purchaseAirtime(AirtimePayment payment, BuildContext context) async {
//   final token = await const FlutterSecureStorage().read(key: 'token');
//   try {
//     final response = await ApiService.dio.post('/buy-airtime',
//         data: json.encode(payment.toJson()),
//         options: Options(headers: {'Authorization': 'Bearer $token'}));

//     if (response.statusCode == 200 || response.statusCode == 201) {
//       print(response.data);
//       if (response.data['success'] == true) {
//         Navigator.of(context).push(
//           MaterialPageRoute(
//             builder: (context) => const AirtimeConfirmation(),
//           ),
//         );
//       }
//     }
//   } on DioException catch (e) {
//     if (DioExceptionType.badResponse == e.type) {
//       throw Exception('Unable to make request');
//     }
//     if (DioExceptionType.connectionError == e.type ||
//         DioExceptionType.connectionTimeout == e.type ||
//         DioExceptionType.receiveTimeout == e.type ||
//         DioExceptionType.sendTimeout == e.type) {
//       throw Exception('Unable to make requests, try again');
//     }
//   }

//   return AirtimePayment(
//       amount: null, number: null, provider: null, reference: null);
// }

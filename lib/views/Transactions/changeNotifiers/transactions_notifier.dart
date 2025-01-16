import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mra/core/network/api_client.dart';
import 'package:mra/views/Transactions/model/transactions.dart';

class TransactionsDataProvider with ChangeNotifier {
  Transactions? _transactionsData;

  Transactions? get transactionsData => _transactionsData;

  void setTransactionsData(Transactions transactionsData) {
    _transactionsData = transactionsData;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Transactions?> loadTransactionData(BuildContext context) async {
    final token = await const FlutterSecureStorage().read(key: 'token');

    print('token from transaction: $token');
    try {
      setLoading(true);
      final response = await ApiService.dio.get(
        '/transaction-history',
        options: Options(headers: {'Authorization': 'Bearer $token'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        setLoading(false);
        print(response.data);
        
        final userData = Transactions.fromJson(response.data);
        setTransactionsData(userData);
        print('transactions loaded successfully: $userData');
      }
    } catch (e) {}
  }
}

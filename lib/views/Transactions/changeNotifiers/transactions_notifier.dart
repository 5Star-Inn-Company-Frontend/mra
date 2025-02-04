import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mra/core/network/api_client.dart';
import 'package:mra/views/Transactions/model/transaction_model.dart';

class TransactionsDataProvider with ChangeNotifier {
  TransactionModel? _transactionsData;
  TransactionModel? get transactionsData => _transactionsData;

  void setTransactionsData(TransactionModel transactionsData) {
    _transactionsData = transactionsData;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<TransactionModel?> loadTransactionData(BuildContext context) async {
    final token = await const FlutterSecureStorage().read(key: 'token');

    try {
      setLoading(true);
      final response = await ApiService.dio.get(
        '/transaction-history',
        options: Options(headers: {'Authorization': 'Bearer $token'})
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setLoading(false);
        // print('transaction data: ${response.data}');
        
        final transactionData = TransactionModel.fromJson(response.data);
        setTransactionsData(transactionData);
        // print('transactions loaded successfully: $transactionData');
      
        return transactionData;
      }
    } catch (e) {}
  }
}

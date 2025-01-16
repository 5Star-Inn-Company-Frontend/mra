class VacctsModel {
  final bool status;
  final String message;
  final List<AccountData> data;

  VacctsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VacctsModel.fromJson(Map<String, dynamic> json) {
    return VacctsModel(
      status: json['status'],
      message: json['message'],
      data: List<AccountData>.from(json['data'].map((x) => AccountData.fromJson(x))),
    );
  }

  toJson() {
    return {
      'status': status,
      'message': message,
      'data': data
    };
  }
}

class AccountData {
  final int id;
  final int userId;
  final String accountName;
  final String accountNumber;
  final String reference;
  final String status;

  AccountData({
    required this.id,
    required this.userId,
    required this.accountName,
    required this.accountNumber,
    required this.reference,
    required this.status,
  });

  factory AccountData.fromJson(Map<String, dynamic> json) {
    return AccountData(
      id: json['id'],
      userId: json['user_id'],
      accountName: json['account_name'],
      accountNumber: json['account_number'],
      reference: json['reference'],
      status: json['status'],
    );
  }

  toJson() {
    return {
      'id': id,
      'user_id': userId,
      'account_name': accountName,
      'account_number': accountNumber,
      'reference': reference,
      'status': status,
    };
  }
}

class DataPurchaseModel {
  final bool status;
  final String message;

  DataPurchaseModel({required this.status, required this.message});

  factory DataPurchaseModel.fromJson(Map<String, dynamic> json) {
    return DataPurchaseModel(
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
class AirtimePurchaseModel {
  final bool status;
  final String message;

  AirtimePurchaseModel({
    required this.status,
    required this.message,
  });

  factory AirtimePurchaseModel.fromJson(Map<String, dynamic> json) {
    return AirtimePurchaseModel(
      status: json['status'],
      message: json['message'],
    );
  }

}
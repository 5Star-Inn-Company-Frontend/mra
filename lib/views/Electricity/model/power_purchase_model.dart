class PowerPurchaseModel {
  final bool status;
  final String message;

  PowerPurchaseModel({
    required this.status,
    required this.message,
  });

  factory PowerPurchaseModel.fromJson(Map<String, dynamic> json) {
    return PowerPurchaseModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
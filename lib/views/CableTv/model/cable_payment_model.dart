class CablePaymentModel {
  final bool status;
  final String message;

  CablePaymentModel({required this.status, required this.message});

  factory CablePaymentModel.fromJson(Map<String, dynamic> json) {
    return CablePaymentModel(
      status: json['status'],
      message: json['message'],
    );
  }

  toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}
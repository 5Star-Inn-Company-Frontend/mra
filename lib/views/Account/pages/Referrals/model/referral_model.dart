class ReferralModel {
  final bool status;
  final String message;
  final List<dynamic> data;
  final int refAmount;
  final String refWhen;

  ReferralModel({
    required this.status,
    required this.message,
    required this.data,
    required this.refAmount,
    required this.refWhen,
  });

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    return ReferralModel(
      status: json['status'],
      message: json['message'],
      data: json['data'],
      refAmount: json['ref_amount'],
      refWhen: json['ref_when'],
    );
  }
}
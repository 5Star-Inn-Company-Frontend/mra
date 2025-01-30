class CableValidateModel {
  final bool status;
  final String message;
  final String data;

  CableValidateModel({required this.status, required this.message, required this.data});

  factory CableValidateModel.fromJson(Map<String, dynamic> json) {
    return CableValidateModel(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    );
  }

  toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }
}
class PowerValidateModel {
  final bool status;
  final String message;
  final String data;

  PowerValidateModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PowerValidateModel.fromJson(Map<String, dynamic> json) {
    return PowerValidateModel(
      status: json['status'],
      message: json['message'],
      data: json['data'],
    
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
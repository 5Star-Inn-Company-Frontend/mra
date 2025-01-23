class PowerProviderModel {
  final bool status;
  final String message;
  final List<PowerProviderData> data;

  PowerProviderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory PowerProviderModel.fromJson(Map<String, dynamic> json) {
    return PowerProviderModel(
      status: json['status'],
      message: json['message'],
      data: List<PowerProviderData>.from(json['data'].map((x) => PowerProviderData.fromJson(x))),
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

class PowerProviderData {
  final String id;
  final String name;
  final String code;
  final String discount;
  final int status;

  PowerProviderData({
    required this.id,
    required this.name, 
    required this.code, 
    required this.discount,
    required this.status,
  });

  factory PowerProviderData.fromJson(Map<String, dynamic> json) {
    return PowerProviderData(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      discount: json['discount'],
      status: json['status'],
    );
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'discount': discount,
      'status': status,
    };
  }
}

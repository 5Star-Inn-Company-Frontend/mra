class AirtimeProviderModel {
  final bool status;
  final String message;
  final List<Datum> data;

  AirtimeProviderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory AirtimeProviderModel.fromJson(Map<String, dynamic> json) {
    return AirtimeProviderModel(
      status: json['status'],
      message: json['message'],
      data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
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

class Datum {
  final int id;
  final String network;
  final String discount;
  final String server;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Datum({
    required this.id,
    required this.network,
    required this.discount,
    required this.server,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      id: json['id'],
      network: json['network'],
      discount: json['discount'],
      server: json['server'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  toJson() {
    return {
      'id': id,
      'network': network,
      'discount': discount,
      'server': server,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
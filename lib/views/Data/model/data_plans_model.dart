class DataPlansModel {
  final bool status;
  final String message;
  final List<DataPlansData> data;

  DataPlansModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DataPlansModel.fromJson(Map<String, dynamic> json) {
    return DataPlansModel(
      status: json['status'],
      message: json['message'],
      data: List<DataPlansData>.from(json['data'].map((x) => DataPlansData.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data.map((x) => x.toJson()).toList(),
    };
  }
}

class DataPlansData {
  final int id;
  final String name;
  final String category;
  final int amount;
  final String network;
  final String price;

  DataPlansData({
    required this.id,
    required this.name,
    required this.category,
    required this.amount,
    required this.network,
    required this.price,
  });

  factory DataPlansData.fromJson(Map<String, dynamic> json) {
    return DataPlansData(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      amount: json['amount'],
      network: json['network'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'amount': amount,
      'network': network,
      'price': price,
    };
  }
}
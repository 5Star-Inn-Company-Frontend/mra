class DataProviderModel {
  final bool status;
  final String message;
  final List<DataProvider> data;

  DataProviderModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DataProviderModel.fromJson(Map<String, dynamic> json) {
    return DataProviderModel(
      status: json['status'],
      message: json['message'],
      data: List<DataProvider>.from(json['data'].map((x) => DataProvider.fromJson(x))),
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

class DataProvider {
  final String name;
  final String category;
  final int amount;
  final String network;
  final String price;

  DataProvider({
    required this.name,
    required this.category,
    required this.amount,
    required this.network,
    required this.price,
  });

  factory DataProvider.fromJson(Map<String, dynamic> json) {
    return DataProvider(
      name: json['name'],
      category: json['category'],
      amount: json['amount'],
      network: json['network'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'category': category,
      'amount': amount,
      'network': network,
      'price': price,
    };
  }
}
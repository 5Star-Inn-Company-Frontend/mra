class CablePlans {
  bool success;
  String message;
  List<CablePlan> data;

  CablePlans({required this.success, required this.message, required this.data});

  factory CablePlans.fromJson(Map<String, dynamic> json) {
    return CablePlans(
      success: json['status'],
      message: json['message'],
      data: List<CablePlan>.from(json['data'].map((x) => CablePlan.fromJson(x))),
    );
  }
}

class CablePlan {
  String type;
  String name;
  String code;
  String price;
  String discount;

  CablePlan({
    required this.type,
    required this.name,
    required this.code,
    required this.price,
    required this.discount,
  });

  factory CablePlan.fromJson(Map<String, dynamic> json) {
    return CablePlan(
      type: json['type'],
      name: json['name'],
      code: json['code'],
      price: json['price'],
      discount: json['discount'],
    );
  }
}
class DataTypesModel {
  final bool success;
  final String message;
  final List<DataCategory> data;

  DataTypesModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DataTypesModel.fromJson(Map<String, dynamic> json) {
    return DataTypesModel(
      success: json['status'] ?? false,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)
              ?.map((item) => DataCategory.fromJson(item))
              .toList() ?? [],
    );
  }
}

class DataCategory {
  final String category;

  DataCategory({required this.category});

  factory DataCategory.fromJson(Map<String, dynamic> json) {
    return DataCategory(category: json['category'] ?? '');
  }
}

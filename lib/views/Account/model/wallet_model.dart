class WalletModel {
  final int id;
  final int userId;
  final String name;
  final double balance;
  final int status;
  final String createdAt;
  final String updatedAt;

  WalletModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.balance,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  // Deserialize from Map
  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'] ?? 'id null',
      userId: map['user_id'] ?? 'user_id null',
      name: map['name'] ?? 'name null',
      balance: (map['balance']).toDouble() ?? 'balance null',
      status: map['status'] ?? 'status null', 
      createdAt: map['created_at'] ?? 'created_at null',
      updatedAt: map['updated_at'] ?? 'updatedAt null',
    );
  }

  // Serialize to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'balance': balance,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  @override
  String toString() {
    return 'WalletModel(id: $id, userId: $userId, name: $name, balance: $balance, status: $status)';
  }
}

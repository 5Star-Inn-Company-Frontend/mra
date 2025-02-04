class ChangePinModel {
  final bool status;
  final String message;

  ChangePinModel(
    {
      required this.status,
      required this.message
    }
  );

  factory ChangePinModel.fromJson(Map<String, dynamic> json) {
    return ChangePinModel(
      status: json['status'],
      message: json['message']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message
    };
  }
}
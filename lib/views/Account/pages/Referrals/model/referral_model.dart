class ReferralModel {
  final bool status;
  final String message;
  final List<Datum> data;
  final int refAmount;
  final String refWhen;

  ReferralModel({
    required this.status,
    required this.message,
    required this.data,
    required this.refAmount,
    required this.refWhen,
  });

  factory ReferralModel.fromJson(Map<String, dynamic> json) {
    return ReferralModel(
      status: json['status'],
      message: json['message'],
      data: List<Datum>.from(json['data'].map((x) => Datum.fromJson(x))),
      refAmount: json['ref_amount'],
      refWhen: json['ref_when'],
    );
  }
}

class Datum {
  final String firstname;
  final String lastname;
  final String phone;

  Datum({
    required this.firstname,
    required this.lastname,
    required this.phone,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      firstname: json['firstname'],
      lastname: json['lastname'],
      phone: json['phone'],
    );
  }

  toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'phone': phone,
    };
  }
}

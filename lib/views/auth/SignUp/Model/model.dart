  class UserModel {
    String firstName;
    String lastName;
    String phone;
    String email;
    String password;
    String address;
    String gender;
    String dob;

    UserModel({
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.email,
      required this.password,
      required this.address,
      required this.gender,
      required this.dob,
    });

    Map<String, dynamic> toJson() {
      return {
        'firstname': firstName,
        'lastname': lastName,
        'phone': phone,
        'email': email,
        'password': password,
        'address': address,
        'gender': gender,
        'dob': dob,
      };
    }
  }
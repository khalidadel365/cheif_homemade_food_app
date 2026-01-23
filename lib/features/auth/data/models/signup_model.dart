class SignUpModel {
  final int? id;
  final UserData? userData;
  SignUpModel({this.id,this.userData});
  factory SignUpModel.fromJson(Map<String,dynamic> json){
    return SignUpModel(
        id:  json['id'],
        userData:  json['user'] != null? UserData.fromJson(json['user']):null,
    );
  }
}


class UserData {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final String? phone;
  final String? userType;
  UserData({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.userType,
});
  factory UserData.fromJson(Map<String,dynamic> json){
    return UserData(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      password: json['password'],
      phone: json['phone_number'],
      userType: json['user_type'],
    );
  }
}


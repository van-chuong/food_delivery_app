class UserModel {
  final String? id;
  final String? fullName;
  final String? email;
  final String? phoneNo;
  final String? password;
  final String? address;
  final String? photoUrl;
  final String? birthDay;
  final String? gender;

  UserModel({this.id,  this.fullName, this.email, this.phoneNo,
    this.password, this.address, this.birthDay, this.gender, this.photoUrl});

  toJSon() {
    return {
      'FullName': fullName,
      'Email': email,
      'Phone': phoneNo,
      'Password': password,
      'Address': address,
      'BirthDay': birthDay,
      'Gender': gender,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      phoneNo: json['phoneNo'],
      password: json['password'],
      address: json['address'],
      birthDay: json['birthDay'],
      gender: json['gender'],
      photoUrl: json['photoUrl'],
    );
  }
}
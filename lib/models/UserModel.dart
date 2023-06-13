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
  final bool? role;
  final String? createAt;
  UserModel( {this.id,  this.fullName, this.email, this.phoneNo,
    this.password, this.address, this.birthDay, this.gender, this.photoUrl, this.role, this.createAt});

  toJSon() {
    return {
      'FullName': fullName,
      'Email': email,
      'Phone': phoneNo,
      'Password': password,
      'Address': address,
      'BirthDay': birthDay,
      'Gender': gender,
      'role': role,
      'create_at': createAt,
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
      role: json['role'],
      createAt: json['create_at'],
    );
  }
}
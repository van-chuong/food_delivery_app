class UserModel{
  final String? id;
  final String fullName;
  final String email;
  final  String phoneNo;
  final String password;

  UserModel(this.id, this.fullName, this.email, this.phoneNo, this.password);
  toJSon(){
    return{
      'FullName': fullName,
      'Email': email,
      'Phone': phoneNo,
      'Password' : password
    };
  }
}
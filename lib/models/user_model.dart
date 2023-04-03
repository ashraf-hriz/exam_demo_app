class UserModel {
  String? fName;
  String? lName;
  String? type;
  String? email;
  String? uId;
  String? group;

  UserModel({
    this.fName,
    this.lName,
    this.type,
    this.email,
    this.uId,
    this.group,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      fName: json['firstname'] ?? '',
      lName: json['lastname'] ?? '',
      type: json['type'] ?? '',
      email: json['email'] ?? '',
      uId: json['uid'] ?? '',
      group: json['group'] ?? '',
    );
  }
}

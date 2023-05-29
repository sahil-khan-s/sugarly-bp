class UserData {
  String? email;
  String? name;
  String? phoneNumber;
  String? role;
  String? uid;
  String? address;
  static UserData _instance = UserData._privateConstructor();

  static UserData get instance => _instance;

  UserData._privateConstructor();

  void clear() {
    _instance = UserData._privateConstructor();
  }

  UserData({this.email, this.name, this.phoneNumber, this.role, this.uid});

  UserData.fromJson(Map<dynamic, dynamic> json) {
    _instance.email = json['email'];
    _instance.name = json['name'];
    _instance.phoneNumber = json['phone_number'];
    _instance.role = json['role'];
    _instance.uid = json['uid'];
    _instance.address = json['address'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = instance.email;
    data['name'] = instance.name;
    data['phone_number'] = instance.phoneNumber;
    data['role'] = instance.role;
    data['uid'] = instance.uid;
    data['address'] = instance.address;
    return data;
  }
}

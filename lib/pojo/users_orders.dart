

class UsersModel {
 late List<DataUser> _data;
 late int _size;

  List<DataUser> get data => _data;
  int get size => _size;

  UsersOrders({
      required List<DataUser> data,
      required int size}){
    _data = data;
    _size = size;
}

 UsersModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(DataUser.fromJson(v));
      });
    }
    _size = json['size'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['data'] = _data.map((v) => v.toJson()).toList();
    map['size'] = _size;
    return map;
  }

}



class DataUser {
late  int _id;
late String _name;
late String _points;
late  String _phone;
late String _email;
late  String _deviceToken;
late String _role;
late  dynamic _emailVerifiedAt;
late String _password;
late dynamic _rememberToken;
late  String _createdAt;
late  String _updatedAt;
late dynamic _facebookId;
late  dynamic _googleId;

  int get id => _id;
  String get name => _name;
  String get points => _points;
  String get phone => _phone;
  String get email => _email;
  String get deviceToken => _deviceToken;
  String get role => _role;
  dynamic get emailVerifiedAt => _emailVerifiedAt;
  String get password => _password;
  dynamic get rememberToken => _rememberToken;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;
  dynamic get facebookId => _facebookId;
  dynamic get googleId => _googleId;

DataUser({
      required int id,
      required String name,
      required String points,
      required String phone,
      required String email,
      required String deviceToken,
      required String role,
      dynamic emailVerifiedAt, 
      required String password,
      dynamic rememberToken, 
      required String createdAt,
      required String updatedAt,
      dynamic facebookId, 
      dynamic googleId}){
    _id = id;
    _name = name;
    _points = points;
    _phone = phone;
    _email = email;
    _deviceToken = deviceToken;
    _role = role;
    _emailVerifiedAt = emailVerifiedAt;
    _password = password;
    _rememberToken = rememberToken;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _facebookId = facebookId;
    _googleId = googleId;
}

DataUser.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _points = json['points'];
    _phone = json['phone'];
    _email = json['email'];
    _deviceToken = json['device_token'];
    _role = json['role'];
    _emailVerifiedAt = json['email_verified_at'];
    _password = json['password'];
    _rememberToken = json['remember_token'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _facebookId = json['facebook_id'];
    _googleId = json['google_id'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['points'] = _points;
    map['phone'] = _phone;
    map['email'] = _email;
    map['device_token'] = _deviceToken;
    map['role'] = _role;
    map['email_verified_at'] = _emailVerifiedAt;
    map['password'] = _password;
    map['remember_token'] = _rememberToken;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['facebook_id'] = _facebookId;
    map['google_id'] = _googleId;
    return map;
  }

}
/// success : true
/// message : "Data fetched successfully"
/// user : {"userId":1,"name":"Shahidul","email":"shahidul@test.com","phone":"01940204058","image":"imgs/profile/mCDMUD4OLIR2XqO402UVX4EBOHq2bVmvUzdgOGsp.jpg","facebook":null,"instagram":null,"twitter":null}

class ProfileModel {
  ProfileModel({
      bool? success, 
      String? message, 
      User? user,}){
    _success = success;
    _message = message;
    _user = user;
}

  ProfileModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  bool? _success;
  String? _message;
  User? _user;

  bool? get success => _success;
  String? get message => _message;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// userId : 1
/// name : "Shahidul"
/// email : "shahidul@test.com"
/// phone : "01940204058"
/// image : "imgs/profile/mCDMUD4OLIR2XqO402UVX4EBOHq2bVmvUzdgOGsp.jpg"
/// facebook : null
/// instagram : null
/// twitter : null

class User {
  User({
      int? userId, 
      String? name, 
      String? email, 
      String? phone, 
      String? image,
      dynamic facebook, 
      dynamic instagram, 
      dynamic twitter,}){
    _userId = userId;
    _name = name;
    _email = email;
    _phone = phone;
    _image = image;
    _facebook = facebook;
    _instagram = instagram;
    _twitter = twitter;
}

  User.fromJson(dynamic json) {
    _userId = json['userId'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
    _facebook = json['facebook'];
    _instagram = json['instagram'];
    _twitter = json['twitter'];
  }
  int? _userId;
  String? _name;
  String? _email;
  String? _phone;
  String? _image;
  dynamic _facebook;
  dynamic _instagram;
  dynamic _twitter;

  int? get userId => _userId;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get image => _image;
  dynamic get facebook => _facebook;
  dynamic get instagram => _instagram;
  dynamic get twitter => _twitter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image'] = _image;
    map['facebook'] = _facebook;
    map['instagram'] = _instagram;
    map['twitter'] = _twitter;
    return map;
  }

}
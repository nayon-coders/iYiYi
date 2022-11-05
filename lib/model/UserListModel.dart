/// success : true
/// message : "6 records found"
/// data : [{"id":1,"name":"Shahidul Islam","email":"shahidul@test.com","phone":"+8801940204058","image":"imgs/profile/acmaemQWhx8tD2nvp76AkeGXQq8p6k5esaOlDhqs.png","facebook":"fb/its.antorislam","instagram":null,"twitter":null,"location":{"latitude":"213412","longitude":"675446","location":"jahdgjas"}},{"id":2,"name":"shahidul islam","email":"shahidul.info@test.com","phone":"01533448761","image":null,"facebook":null,"instagram":null,"twitter":null,"location":null},{"id":3,"name":"nayon talukder","email":"test@test.com","phone":"+8801814569747","image":null,"facebook":null,"instagram":null,"twitter":null,"location":null},{"id":4,"name":"vhhh","email":"ggf@ej","phone":"ggg","image":null,"facebook":null,"instagram":null,"twitter":null,"location":null},{"id":5,"name":"Nayon Talukder","email":"test@gmail.com","phone":"018145697477","image":null,"facebook":null,"instagram":null,"twitter":"twitter","location":null},{"id":6,"name":"dilaan","email":"da@gmail.com","phone":"8363025394","image":null,"facebook":null,"instagram":null,"twitter":null,"location":null}]

class UserListModel {
  UserListModel({
      bool? success, 
      String? message, 
      List<Data>? data,}){
    _success = success;
    _message = message;
    _data = data;
}

  UserListModel.fromJson(dynamic json) {
    _success = json['success'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _success;
  String? _message;
  List<Data>? _data;

  bool? get success => _success;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 1
/// name : "Shahidul Islam"
/// email : "shahidul@test.com"
/// phone : "+8801940204058"
/// image : "imgs/profile/acmaemQWhx8tD2nvp76AkeGXQq8p6k5esaOlDhqs.png"
/// facebook : "fb/its.antorislam"
/// instagram : null
/// twitter : null
/// location : {"latitude":"213412","longitude":"675446","location":"jahdgjas"}

class Data {
  Data({
      int? id, 
      String? name, 
      String? email, 
      String? phone, 
      String? image, 
      String? facebook, 
      dynamic instagram, 
      dynamic twitter, 
      Location? location,}){
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _image = image;
    _facebook = facebook;
    _instagram = instagram;
    _twitter = twitter;
    _location = location;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _image = json['image'];
    _facebook = json['facebook'];
    _instagram = json['instagram'];
    _twitter = json['twitter'];
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }
  int? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _image;
  String? _facebook;
  dynamic _instagram;
  dynamic _twitter;
  Location? _location;

  int? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get phone => _phone;
  String? get image => _image;
  String? get facebook => _facebook;
  dynamic get instagram => _instagram;
  dynamic get twitter => _twitter;
  Location? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['image'] = _image;
    map['facebook'] = _facebook;
    map['instagram'] = _instagram;
    map['twitter'] = _twitter;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    return map;
  }

}

/// latitude : "213412"
/// longitude : "675446"
/// location : "jahdgjas"

class Location {
  Location({
      String? latitude, 
      String? longitude, 
      String? location,}){
    _latitude = latitude;
    _longitude = longitude;
    _location = location;
}

  Location.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _location = json['location'];
  }
  String? _latitude;
  String? _longitude;
  String? _location;

  String? get latitude => _latitude;
  String? get longitude => _longitude;
  String? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['location'] = _location;
    return map;
  }

}
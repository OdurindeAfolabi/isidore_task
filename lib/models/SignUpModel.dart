class SignUpModel {
  SignUpModel({
      this.data,});

  SignUpModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.signup,});

  Data.fromJson(dynamic json) {
    signup = json['signup'] != null ? Signup.fromJson(json['signup']) : null;
  }
  Signup? signup;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (signup != null) {
      map['signup'] = signup?.toJson();
    }
    return map;
  }

}

class Signup {
  Signup({
      this.errors, 
      this.status, 
      this.user,});

  Signup.fromJson(dynamic json) {
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    status = json['status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  Errors? errors;
  int? status;
  User? user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errors'] = errors;
    map['status'] = status;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }

}

class Errors {
  Errors({
    this.fullMessage,
    this.message,
    this.property,});

  Errors.fromJson(dynamic json) {
    fullMessage = json['fullMessage'];
    message = json['message'];
    property = json['property'];
  }
  String? fullMessage;
  String? message;
  String? property;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fullMessage'] = fullMessage;
    map['message'] = message;
    map['property'] = property;
    return map;
  }

}

class User {
  User({
      this.createdAt, 
      this.email, 
      this.id, 
      this.status, 
      this.tokens, 
      this.updatedAt,});

  User.fromJson(dynamic json) {
    createdAt = json['createdAt'];
    email = json['email'];
    id = json['id'];
    status = json['status'];
    tokens = json['tokens'];
    updatedAt = json['updatedAt'];
  }
  String? createdAt;
  String? email;
  String? id;
  String? status;
  dynamic tokens;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['createdAt'] = createdAt;
    map['email'] = email;
    map['id'] = id;
    map['status'] = status;
    map['tokens'] = tokens;
    map['updatedAt'] = updatedAt;
    return map;
  }

}
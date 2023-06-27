class GetContactModel {
  GetContactModel({
      this.data,});

  GetContactModel.fromJson(dynamic json) {
    data = json['data'] != null ? GetContactData.fromJson(json['data']) : null;
  }
  GetContactData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class GetContactData {
  GetContactData({
      this.contacts,});

  GetContactData.fromJson(dynamic json) {
    if (json['contacts'] != null) {
      contacts = [];
      json['contacts'].forEach((v) {
        contacts?.add(Contacts.fromJson(v));
      });
    }
  }
  List<Contacts>? contacts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (contacts != null) {
      map['contacts'] = contacts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Contacts {
  Contacts({
      this.address, 
      this.createdAt, 
      this.email, 
      this.id, 
      this.name, 
      this.phone, 
      this.updatedAt,});

  Contacts.fromJson(dynamic json) {
    address = json['address'];
    createdAt = json['createdAt'];
    email = json['email'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    updatedAt = json['updatedAt'];
  }
  String? address;
  String? createdAt;
  String? email;
  String? id;
  String? name;
  String? phone;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = address;
    map['createdAt'] = createdAt;
    map['email'] = email;
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['updatedAt'] = updatedAt;
    return map;
  }

}
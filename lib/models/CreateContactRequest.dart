class CreateContactRequest {
  CreateContactRequest({
      this.contactInput,});

  CreateContactRequest.fromJson(dynamic json) {
    contactInput = json['contactInput'] != null ? ContactInput.fromJson(json['contactInput']) : null;
  }
  ContactInput? contactInput;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (contactInput != null) {
      map['contactInput'] = contactInput?.toJson();
    }
    return map;
  }

}

class ContactInput {
  ContactInput({
      this.id, 
      this.name, 
      this.phone, 
      this.email, 
      this.address, 
      this.discarded,});

  ContactInput.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    discarded = json['discarded'];
  }
  String? id;
  String? name;
  String? phone;
  String? email;
  String? address;
  bool? discarded;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['address'] = address;
    map['discarded'] = discarded;
    return map;
  }

}
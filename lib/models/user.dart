import 'package:get_contact/models/contact.dart';

class User {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? createdAt;
  String? updatedAt;
  List<Contacts>? contacts;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.createdAt,
      this.updatedAt,
      this.contacts});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((contact) {
        contacts!.add(Contacts.fromJson(contact));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    if (contacts != null) {
      data['contacts'] = contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

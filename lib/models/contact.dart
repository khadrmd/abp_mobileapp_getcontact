class Contacts {
  String? name;
  String? phone;
  String? address;
  String? id;

  Contacts({this.name, this.phone, this.address, this.id});

  Contacts.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['phone'] = phone;
    data['address'] = address;
    data['id'] = id;
    return data;
  }
}

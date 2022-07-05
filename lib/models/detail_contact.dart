class DetailContact {
  bool? success;
  Data? data;
  Null? error;

  DetailContact({this.success, this.data, this.error});

  DetailContact.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = error;
    return data;
  }
}

class Data {
  UserDetailProfile? user;
  List<Aliases>? aliases;

  Data({this.user, this.aliases});

  Data.fromJson(Map<String, dynamic> json) {
    user =
        json['user'] != null ? UserDetailProfile.fromJson(json['user']) : null;
    if (json['aliases'] != null) {
      aliases = <Aliases>[];
      json['aliases'].forEach((v) {
        aliases!.add(Aliases.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (aliases != null) {
      data['aliases'] = aliases!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserDetailProfile {
  bool? isRegistered;
  Aliases? data;

  UserDetailProfile({this.isRegistered, this.data});

  UserDetailProfile.fromJson(Map<String, dynamic> json) {
    isRegistered = json['isRegistered'];
    data = json['data'] != null ? Aliases.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isRegistered'] = isRegistered;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Aliases {
  String? name;
  String? phone;
  String? id;

  Aliases({this.name, this.phone, this.id});

  Aliases.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['phone'] = phone;
    data['id'] = id;
    return data;
  }
}

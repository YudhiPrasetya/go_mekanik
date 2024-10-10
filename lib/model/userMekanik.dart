import 'dart:convert';

class UserMekanik {
  // ignore: non_constant_identifier_names
  int? id_user_mekanik;
  // ignore: non_constant_identifier_names
  int? id_mekanik_member;
  // ignore: non_constant_identifier_names
  String? user_name;
  String? nik;
  String? password;
  int? active;

  UserMekanik(
      {
      // ignore: non_constant_identifier_names
      this.id_user_mekanik,
      // ignore: non_constant_identifier_names
      this.id_mekanik_member,
      // ignore: non_constant_identifier_names
      this.user_name,
      this.nik,
      this.password,
      this.active});

  factory UserMekanik.fromJson(Map<String, dynamic> map) {
    return UserMekanik(
        id_user_mekanik: map['id_user_mekanik'],
        id_mekanik_member: map['id_mekanik_member'],
        user_name: map['user_name'],
        nik: map['nik'],
        password: map['password'],
        active: map['active']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id_user_mekanik': id_user_mekanik,
      'id_mekanik_member': id_mekanik_member,
      'user_name': user_name,
      'nik': nik,
      'password': password,
      'active': active
    };
  }

  @override
  String toString() {
    return 'UserMekanik{id_user_mekanik: $id_user_mekanik,id_mekanik_member: $id_mekanik_member,user_name: $user_name,nik: $nik,password: $password,active: $active}';
  }

  List<UserMekanik> userMekanikFromJson(String jsonData) {
    final data = json.decode(jsonData);

    return List<UserMekanik>.from(
        data.map((item) => UserMekanik.fromJson(item)));
  }

  String userMekanikToJson(UserMekanik data) {
    final jsonData = data.toJson();

    return json.encode(jsonData);
  }
}

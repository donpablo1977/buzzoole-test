class Account {
  Avatar avatar;
  int id;
  String name;
  bool includeAdult;
  String username;

  Account({this.avatar, this.id, this.name, this.includeAdult, this.username});

  Account.fromJson(Map<String, dynamic> json) {
    avatar =
        json['avatar'] != null ? new Avatar.fromJson(json['avatar']) : null;
    id = json['id'];
    name = json['name'];
    includeAdult = json['include_adult'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.avatar != null) {
      data['avatar'] = this.avatar.toJson();
    }
    data['id'] = this.id;
    data['name'] = this.name;
    data['include_adult'] = this.includeAdult;
    data['username'] = this.username;
    return data;
  }
}

class Avatar {
  Gravatar gravatar;

  Avatar({this.gravatar});

  Avatar.fromJson(Map<String, dynamic> json) {
    gravatar = json['gravatar'] != null
        ? new Gravatar.fromJson(json['gravatar'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.gravatar != null) {
      data['gravatar'] = this.gravatar.toJson();
    }
    return data;
  }
}

class Gravatar {
  String hash;

  Gravatar({this.hash});

  Gravatar.fromJson(Map<String, dynamic> json) {
    hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hash'] = this.hash;
    return data;
  }
}

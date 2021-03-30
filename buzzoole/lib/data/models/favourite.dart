class Favourite {
  int id;
  String title;
  String imagePath;

  Favourite({this.id, this.title, this.imagePath});

  Favourite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['imagePath'] = this.imagePath;
    return data;
  }
}

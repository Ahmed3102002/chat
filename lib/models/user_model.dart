class UserModel {
  final String name;
  final String mail;
  final String image;
  final String id;
  UserModel(
      {required this.id,
      required this.name,
      required this.mail,
      required this.image});

  factory UserModel.fromjson(Map<String, dynamic> data) {
    return UserModel(
        name: data['name'],
        mail: data['email'],
        image: data['image'],
        id: data['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': mail,
      'image': image,
      'id': id,
    };
  }
}

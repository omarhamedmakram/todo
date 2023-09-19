class UserModel {
  static const String collectionName = "User";
  String? id;
  String? email;
  String? name;

  UserModel({this.id, this.name, this.email});

  UserModel.fromFireStore(Map<String, dynamic> json)
      : this(
          id: json["id"],
          name: json["name"],
          email: json["email"],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "name": name,
      "email": email,
    };
  }
}

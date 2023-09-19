class AddTaskModel {
  static const String collection = "Task";
  String? id;
  String? title;
  String? details;
  String? time;
  int? date;
  bool? isDone;
  String userId;

  AddTaskModel(
      {this.id,
      this.title,
      this.date,
      this.time,
      this.details,
      this.isDone,
      required this.userId});

  AddTaskModel.fromFireStore(Map<String, dynamic> json)
      : this(
            id: json["id"],
            title: json["title"],
            time: json["time"],
            date: json["date"],
            details: json["details"],
            isDone: json["isDone"],
            userId: json["userId"]);

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "time": time,
      "date": date,
      "details": details,
      "isDone": isDone,
      "userId": userId
    };
  }
}

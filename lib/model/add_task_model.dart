class AddTaskModel {
  static const String collection = "Task";
  String? id;
  String? title;
  String? details;
  String? time;
  String? date;

  AddTaskModel({this.id, this.title, this.date, this.time, this.details});

  AddTaskModel.fromFireStore(Map<String, dynamic> json)
      : this(
          id: json["id"],
          title: json["title"],
          time: json["time"],
          date: json["date"],
          details: json["details"],
        );

  Map<String, dynamic> toFireStore() {
    return {
      "id": id,
      "title": title,
      "time": time,
      "date": date,
      "details": details,
    };
  }
}

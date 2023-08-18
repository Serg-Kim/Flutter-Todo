class Todo {
  int userId;
  int id;
  String title;
  bool completed;

  Todo({required this.userId, required this.title, required this.completed, required this.id});

  copyWith({int? id, int? userId, String? title, bool? completed}) {
    return Todo(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        completed: completed ?? this.completed
    );
  }

  Map toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
    'completed': completed,
  };

  static convertFromJson({required int id, required int userId, required String title, required bool completed}) {
    return Todo(
        id: id,
        userId: userId,
        title: title,
        completed: completed,
    );
  }
}
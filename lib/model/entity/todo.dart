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
        completed: completed ?? this.completed);
  }
}
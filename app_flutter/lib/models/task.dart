class Task {
  final int id;
  final String name;
  final int userId;

  Task({required this.id, required this.name, required this.userId});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      name: json['name'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'user_id': userId,
      };
}

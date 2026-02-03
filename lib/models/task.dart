class Task {
  final int? id;
  final String title;
  final String description;
  final String status;
  final String priority;

  Task({
    this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.priority,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] == null ? null : (json['id'] as int),
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      status: json['status'] ?? 'pending',
      priority: json['priority'] ?? 'normal',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      'status': status,
      'priority': priority,
    };
  }
}

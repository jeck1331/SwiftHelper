class EatCategory {
  const EatCategory({required this.id, required this.title});

  final num id;
  final String title;

  factory EatCategory.fromJson(Map<String, dynamic> json) {
    return EatCategory(
        id: json['id'] as num,
        title: json['title'] as String);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title
  };
}
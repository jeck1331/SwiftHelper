class ActivityCategory {
  const ActivityCategory({
    required this.id,
    required this.title
});

  final num id;
  final String title;

  factory ActivityCategory.fromJson(Map<String, dynamic> json) {
    return ActivityCategory(
        id: json['id'] as num,
        title: json['title'] as String
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title
  };
}
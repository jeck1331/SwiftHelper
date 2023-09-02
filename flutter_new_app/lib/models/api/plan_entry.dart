class PlanEntry {
  final num id;
  final String title;
  final String description;
  final DateTime createdDate;

  PlanEntry({required this.id, required this.title, required this.description, required this.createdDate});

  factory PlanEntry.fromJson(Map<String, dynamic> json) {
    return PlanEntry(
      id: json['id'] as num,
      title: json['title'] as String,
      description: json['description'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String)
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'createdDate': formattingDate(createdDate)
      };

  String formattingDate(DateTime date) =>
      '${date.year.toString()}-${date.month.toString().length == 1 ? '0${date.month}' : date.month.toString()}-${date.day.toString()}';
}

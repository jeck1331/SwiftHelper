class LifeActivity {
  const LifeActivity(
      {required this.id,
      required this.title,
      required this.categoryId,
      required this.createdDate,
      required this.categoryName});

  final num id;
  final String title;
  final num categoryId;
  final String categoryName;
  final DateTime createdDate;

  factory LifeActivity.fromJson(Map<String, dynamic> json) {
    return LifeActivity(
      id: json['id'] as num,
      categoryId: json['categoryId'] as num,
      title: json['title'] as String,
      categoryName: json['categoryName'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'categoryId': categoryId, 'createdDate': formattingDate(createdDate), 'categoryName': categoryName};

  String formattingDate(DateTime date) =>
      '${date.year.toString()}-${date.month.toString().length == 1 ? '0${date.month}' : date.month.toString()}-${date.day.toString()}';
}

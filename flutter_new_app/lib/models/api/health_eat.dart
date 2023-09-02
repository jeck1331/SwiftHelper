class Eat {
  const Eat({
    required this.id,
    required this.title,
    required this.createdDate,
    required this.categoryId,
    this.categoryName
  });

  final num id;
  final String title;
  final DateTime createdDate;
  final num categoryId;
  final String? categoryName;

  factory Eat.fromJson(Map<String, dynamic> json) {
    return Eat(
        id: json['id'] as num,
        createdDate: DateTime.parse(json['createdDate'] as String),
        categoryId: json['categoryId'] as num,
        title: json['title'] as String,
        categoryName: json['categoryName'] as String);
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'createdDate': formattingDate(createdDate),
    'categoryId': categoryId
  };

  String formattingDate(DateTime date) =>
      '${date.year.toString()}-${date.month.toString().length == 1 ? '0${date.month}' : date.month.toString()}-${date.day.toString()}';
}
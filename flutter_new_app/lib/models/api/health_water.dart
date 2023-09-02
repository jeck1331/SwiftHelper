class Water {
  const Water({
    required this.id,
    this.createdDate,
    required this.volume,
  });

  final num id;
  final num volume;
  final DateTime? createdDate;


  factory Water.fromJson(Map<String, dynamic> json) {
    return Water(
        id: json['id'] as num,
        volume: json['volume'] as num,
        createdDate: DateTime.parse(json['createdDate'] as String));
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'createdDate': formattingDate(createdDate ?? DateTime.now()),
    'volume': volume,
  };

  String formattingDate(DateTime date) =>
      '${date.year.toString()}-${date.month.toString().length == 1 ? '0${date.month}' : date.month.toString()}-${date.day.toString()}';
}
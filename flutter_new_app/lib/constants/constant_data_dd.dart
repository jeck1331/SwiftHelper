import '../models/key_value_model.dart';

class ConstantDataDropdowns {
  static const List<KeyValueModel> categories = [
    KeyValueModel(key: 0, value: 'Финансы'),
    KeyValueModel(key: 1, value: 'Здоровье'),
    KeyValueModel(key: 2, value: 'Планирование'),
    KeyValueModel(key: 3, value: 'Заметки')
  ];

  static const List<KeyValueModel> finance = [
    KeyValueModel(key: 0, value: 'Счет'),
    KeyValueModel(key: 1, value: 'Расход/пополнение'),
    KeyValueModel(key: 2, value: 'Категория'),
  ];

  static const List<KeyValueModel> health = [
    KeyValueModel(key: 0, value: 'Питание'),
    KeyValueModel(key: 1, value: 'Физ. активность'),
    KeyValueModel(key: 2, value: 'Категория питания'),
    KeyValueModel(key: 3, value: 'Категория физ. активности'),
    //KeyValueModel(key: 4, value: 'Вода'),
  ];

  static const List<KeyValueModel> plan = [
    KeyValueModel(key: 0, value: 'Запись'),
    KeyValueModel(key: 1, value: 'Этап')
  ];

  static const List<KeyValueModel> entry = [
    KeyValueModel(key: 0, value: 'Запись'),
    KeyValueModel(key: 1, value: 'Подробности')
  ];
}
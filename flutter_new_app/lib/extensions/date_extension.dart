extension DateToString on DateTime {
  String get toNormalizedString {
    DateTime today = DateTime.now();
    if (year == today.year && month == today.month) {
      switch (today.day - day) {
        case 0: return 'Сегодня';
        case 1: return 'Вчера';
        case 2: return 'Позавчера';
        case -1: return 'Завтра';
        case -2: return 'Послезавтра';
      }
    }
    return '$day ${month.toMonthString} $year';
  }

  String get toStringNamed => '$day ${month.toMonthString} $year';


  String get timeToNormalizedString {
    int sizeHour = hour.toString().length;
    int sizeMinute = minute.toString().length;
    return '${sizeHour == 1 ? '0$hour' : hour}:${sizeMinute == 1 ? '0$minute' : minute}';
  }
}

extension MonthToRussianString on int {
  String get toMonthString {
    switch (this) {
      case DateTime.january: return 'января';
      case DateTime.february: return 'февраля';
      case DateTime.march: return 'марта';
      case DateTime.april: return 'апреля';
      case DateTime.may: return 'мая';
      case DateTime.june: return 'июня';
      case DateTime.july: return 'июля';
      case DateTime.august: return 'августа';
      case DateTime.september: return 'сентября';
      case DateTime.october: return 'октября';
      case DateTime.november: return 'ноября';
      case DateTime.december: return 'декабря';
      default: return toString();
    }
  }

  String get toMonthChartString {
    switch (this) {
      case DateTime.january: return 'Январь';
      case DateTime.february: return 'Февраль';
      case DateTime.march: return 'Март';
      case DateTime.april: return 'Апрель';
      case DateTime.may: return 'Май';
      case DateTime.june: return 'Июнь';
      case DateTime.july: return 'Июль';
      case DateTime.august: return 'Август';
      case DateTime.september: return 'Сентябрь';
      case DateTime.october: return 'Октябрь';
      case DateTime.november: return 'Ноябрь';
      case DateTime.december: return 'Декабрь';
      default: return toString();
    }
  }
}
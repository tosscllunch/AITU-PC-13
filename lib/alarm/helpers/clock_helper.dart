String fromTimeToString(DateTime time) {
  return '${hTOhh_24hTrue(time.hour)}:${mTOmm(time.minute)}';
}

String fromWeekdayToString(int weekday) {
  switch (weekday) {
    case 1:
      return 'Понедельник';
    case 2:
      return 'Вторник';
    case 3:
      return 'Среда';
    case 4:
      return 'Четверг';
    case 5:
      return 'Пятница';
    case 6:
      return 'Суббота';
    case 7:
      return 'Воскресенье';
    default:
      return '';
  }
}

String fromPeriodToString(int period) {
  switch (period) {
    case 1:
      return 'Каждый день';
    case 2:
      return 'Каждые 2 дня';
    case 3:
      return 'Каждые 3 дня';
    case 4:
      return 'Каждые 4 дня';
    case 5:
      return 'Каждые 5 дней';
    case 6:
      return 'Каждые 6 дней';
    case 7:
      return 'Каждые 7 дней';
    case 8:
      return 'Каждые 8 дней';
    case 9:
      return 'Каждые 9 дней';
    case 10:
      return 'Каждые 10 дней';

    default:
      return '';
  }
}

String fromWeekdayToStringShort(int weekday) {
  switch (weekday) {
    case 1:
      return 'Пон';
    case 2:
      return 'Втор';
    case 3:
      return 'Сред';
    case 4:
      return 'Четв';
    case 5:
      return 'Пятн';
    case 6:
      return 'Субб';
    case 7:
      return 'Воск';
    default:
      return '';
  }
}

String hTOhh_24hTrue(int hour) {
  late String sHour;
  if (hour < 10) {
    sHour = '0$hour';
  } else {
    sHour = '$hour';
  }
  return sHour;
}

List<String> hTOhh_24hFalse(int hour) {
  late String sHour;
  late String h12State;
  final times = <String>[];
  if (hour < 10) {
    sHour = '0$hour';
    h12State = 'AM';
  } else if (hour > 9 && hour < 13) {
    sHour = '$hour';
    h12State = 'AM';
  } else if (hour > 12 && hour < 22) {
    sHour = '0${hour % 12}';
    h12State = 'PM';
  } else if (hour > 21) {
    sHour = '${hour % 12}';
    h12State = 'PM';
  }
  times.add(sHour);
  times.add(h12State);
  return times;
}

String mTOmm(int minute) {
  late String sMinute;
  if (minute < 10) {
    sMinute = '0$minute';
  } else {
    sMinute = '$minute';
  }
  return sMinute;
}

String sTOss(int second) {
  late String sSecond;
  if (second < 10) {
    sSecond = '0$second';
  } else {
    sSecond = '$second';
  }
  return sSecond;
}

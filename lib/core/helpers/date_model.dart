class DateTimeModel {
  int? year;
  int? mon;
  int? day;
  int? minuet;
  int? hour;
  DateTimeModel({
    this.year,
    this.mon,
    this.day,
    this.minuet,
    this.hour,
  });
  @override
  String toString() {
    // TODO: implement toString
    String y = convertWithAddingZero(year ?? 0);
    String mo = convertWithAddingZero(mon ?? 0);
    String d = convertWithAddingZero(day ?? 0);
    String h = convertWithAddingZero(hour ?? 0);
    String min = convertWithAddingZero(minuet ?? 0);

    return "$y-$mo-$d $h:$min:00";
  }

  String convertWithAddingZero(int i) {
    String r = i.toString();
    if (r.length < 2) {
      r = "0$r";
    }
    return r;
  }
}

DateTimeModel fromString(String dateTimeString) {
  // Split the date and time parts
  List<String> dateTimeParts = dateTimeString.split(' ');

  // Date part "yyyy-MM-dd"
  List<String> dateParts = dateTimeParts[0].split('-');
  int year = int.parse(dateParts[0]);
  int month = int.parse(dateParts[1]);
  int day = int.parse(dateParts[2]);

  // Time part "hh:mm:00"
  List<String> timeParts = dateTimeParts[1].split(':');
  int hour = int.parse(timeParts[0]);
  int minute = int.parse(timeParts[1]);

  // Return a DateTimeModel instance
  return DateTimeModel(
    year: year,
    mon: month,
    day: day,
    hour: hour,
    minuet: minute,
  );
}

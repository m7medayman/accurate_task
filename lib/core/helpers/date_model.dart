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

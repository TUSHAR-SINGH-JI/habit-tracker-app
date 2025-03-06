// Return today's date formatted as yyyymmdd
String todaysDateFormatted() {
  var dateTimeObject = DateTime.now();

  // Year in the format yyyy
  String year = dateTimeObject.year.toString();

  // Month in the format mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  // Day in the format dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  // Final format
  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

// Convert string yyyymmdd to DateTime object
DateTime createDateTimeObject(String yyyymmdd) {
  int year = int.parse(yyyymmdd.substring(0, 4));
  int month = int.parse(yyyymmdd.substring(4, 6));
  int day = int.parse(yyyymmdd.substring(6, 8));

  return DateTime(year, month, day);
}

// Convert DateTime object to string yyyymmdd
String convertDateTimeToString(DateTime dateTime) {
  String year = dateTime.year.toString();

  String month = dateTime.month.toString();
  if (month.length == 1) {
    month = '0$month';
  }

  String day = dateTime.day.toString();
  if (day.length == 1) {
    day = '0$day';
  }

  String yyyymmdd = year+month+day;
  return yyyymmdd;
}

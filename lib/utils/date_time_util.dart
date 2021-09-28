String dateTimeToString(DateTime? dateTime) {
  if (dateTime != null) {
    String dateTimeString = dateTime.toString();
    dateTimeString = dateTimeString.substring(8, 10) +
        '/' +
        dateTimeString.substring(5, 7) +
        '/' +
        dateTimeString.substring(0, 4);
    return dateTimeString;
  } else {
    String dateTimeString = DateTime.now().toString();
    dateTimeString = dateTimeString.substring(8, 10) +
        '/' +
        dateTimeString.substring(5, 7) +
        '/' +
        dateTimeString.substring(0, 4);
    return dateTimeString;
  }
}

int dateTimeToInt(DateTime? dateTime) {
  if (dateTime != null) {
    String dateTimeString = dateTime.toString();
    dateTimeString = dateTimeString.substring(0, 4) +
        dateTimeString.substring(5, 7) +
        dateTimeString.substring(8, 10);
    int dateTimeInt = int.parse(dateTimeString);
    return dateTimeInt;
  } else {
    String dateTimeString = DateTime.now().toString();
    dateTimeString = dateTimeString.substring(0, 4) +
        dateTimeString.substring(5, 7) +
        dateTimeString.substring(8, 10);
    int dateTimeInt = int.parse(dateTimeString);
    return dateTimeInt;
  }
}

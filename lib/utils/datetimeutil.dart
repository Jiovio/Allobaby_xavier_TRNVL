

DateTime localDateTime(String isoString) {
  DateTime utcTime = DateTime.parse(isoString);

  print(utcTime.timeZoneName);

  // Convert it to the local time zone (IST in this case)
  DateTime localTime = utcTime.toLocal();

  return localTime;
}

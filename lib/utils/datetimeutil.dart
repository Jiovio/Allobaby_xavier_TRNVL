

DateTime localDateTime(String isoString) {
  DateTime utcTime = DateTime.parse(isoString);

  print(utcTime.timeZoneName);

  // Convert it to the local time zone (IST in this case)
  DateTime localTime = utcTime.toLocal();

  return localTime;
}

DateTime convertUtcToLocal(DateTime utcDateTime) {
  // Treat the given DateTime as UTC and convert it to local time
  return DateTime.utc(
    utcDateTime.year,
    utcDateTime.month,
    utcDateTime.day,
    utcDateTime.hour,
    utcDateTime.minute,
    utcDateTime.second,
    utcDateTime.millisecond,
    utcDateTime.microsecond,
  ).toLocal();
}


DateTime convertTimeString(String isoString) {
  // Parse the ISO string and treat it as UTC
  DateTime utcDateTime = DateTime.parse(isoString);

  // Convert it to local time
  return convertUtcToLocal(utcDateTime).toLocal();
}


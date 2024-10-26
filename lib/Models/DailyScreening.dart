import 'dart:convert';

class DailyData {
  final int? id;
  final DateTime? date;
  final String? feeling;
  final int? glassOfWater;
  final String? bedTime;
  final String? wakeUpTime;
  final int? sleepDuration;
  final List<String>? exercises;
  final List<String>? tabletsTaken;
  final List<String>? symptoms;
  final DateTime? created;

  DailyData({
    this.id,
    required this.date,
    this.feeling,
    this.glassOfWater,
    this.bedTime,
    this.wakeUpTime,
    this.sleepDuration,
    this.exercises,
    this.tabletsTaken,
    this.symptoms,
    this.created,
  });


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date!.toIso8601String(),
      'feeling': feeling,
      'glass_of_water': glassOfWater,
      'bed_time': bedTime,
      'wake_up_time': wakeUpTime,
      'sleep_duration': sleepDuration,
      'exercises': json.encode(exercises),
      'tabletsTaken': json.encode(tabletsTaken),
      'symptoms': json.encode(symptoms),
      'created': created?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }

  factory DailyData.fromMap(Map<String, dynamic> map) {
    return DailyData(
      id: map['id'] as int?,
      date: map['date'] !=null ?DateTime.parse(map['date']) : DateTime.now() ,
      feeling: map['feeling'] as String?,
      glassOfWater: map['glassOfWater'] as int?,
      bedTime: map['bedTime'] as String?,
      wakeUpTime: map['wakeUpTime'] as String?,
      sleepDuration: map['sleepDuration'] as int?,
      exercises: json.decode(map['exercises']) ,
      tabletsTaken: json.decode(map['tabletsTaken']),
      symptoms: json.decode(map['symptoms']),
      created: map['created'] != null ? DateTime.parse(map['created']) : null,
    );
  }
}

import 'dart:convert';

class SelfScreeningModel {
  int? id;
  int? symptomsId;
  int? vitalID;
  int? hemoglobinId;
  int? urineTestId;
  int? glucoseId;
  int? fetalTestId;
  int? ultrasoundId;
  DateTime created;
  String userId;
  DateTime updated;

  SelfScreeningModel({
    this.id,
    this.symptomsId,
    this.vitalID,
    this.hemoglobinId,
    this.urineTestId,
    this.glucoseId,
    this.fetalTestId,
    this.ultrasoundId,
    required this.created,
    required this.userId,
    required this.updated,
  });

  // From JSON
  factory SelfScreeningModel.fromJson(Map<String, dynamic> json) {
    return SelfScreeningModel(
      id: json['id'],
      symptomsId: json['symptomsId'],
      vitalID: json['vitalID'],
      hemoglobinId: json['hemoglobinId'],
      urineTestId: json['urineTestId'],
      glucoseId: json['glucoseId'],
      fetalTestId: json['fetalTestId'],
      ultrasoundId: json['ultrasoundId'],
      created: DateTime.parse(json['created']), // Parse created as DateTime
      userId: json['userId'],
      updated: DateTime.parse(json['updated']), // Parse updated as DateTime
    );
  }

  // From JSON List
  static List<SelfScreeningModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SelfScreeningModel.fromJson(json)).toList();
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'symptomsId': symptomsId,
      'vitalID': vitalID,
      'hemoglobinId': hemoglobinId,
      'urineTestId': urineTestId,
      'glucoseId': glucoseId,
      'fetalTestId': fetalTestId,
      'ultrasoundId': ultrasoundId,
      'created': created.toIso8601String(), // Convert DateTime to ISO string
      'userId': userId,
      'updated': updated.toIso8601String(), // Convert DateTime to ISO string
    };
  }
}

import 'dart:convert';

import 'package:allobaby/utils/datetimeutil.dart';

class SelfScreeningModel {
  int? id;
  Map<String, dynamic> params = {};
  int? hemoglobinId;
  int? urineTestId;
  int? glucoseId;
  int? fetalTestId;
  int? ultrasoundId;
  DateTime? created;
  int? userId;
  DateTime? updated;

  SelfScreeningModel({
    this.id,
    required this.params,
    this.hemoglobinId,
    this.urineTestId,
    this.glucoseId,
    this.fetalTestId,
    this.ultrasoundId,
    this.created,
    this.userId,
    this.updated,
  });

  // From JSON
  factory SelfScreeningModel.fromJson(Map<String, dynamic> json) {
    return SelfScreeningModel(
      id: json['id'],
      params: json['params'],
      hemoglobinId: json['hemoglobinId'],
      urineTestId: json['urineTestId'],
      glucoseId: json['glucodeId'],
      fetalTestId: json['fetalTestId'],
      ultrasoundId: json['ultrasoundId'],
      created: convertTimeString(json['created']), // Parse created as DateTime
      userId: json['userId'],
      updated: convertTimeString(json['updated']), // Parse updated as DateTime
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

      'hemoglobinId': hemoglobinId,
      'urineTestId': urineTestId,
      'glucoseId': glucoseId,
      'fetalTestId': fetalTestId,
      'ultrasoundId': ultrasoundId,
      'created': created?.toIso8601String(), // Convert DateTime to ISO string
      'userId': userId,
      'updated': updated?.toIso8601String(), // Convert DateTime to ISO string
    };
  }
}

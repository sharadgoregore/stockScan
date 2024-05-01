import 'dart:convert';

List<StockModel> stockModelFromJson(String str) =>
    List<StockModel>.from(json.decode(str).map((x) => StockModel.fromJson(x)));

class StockModel {
  int id;
  String name;
  String tag;
  String color;
  List<Criterion> criteria;

  StockModel({
    required this.id,
    required this.name,
    required this.tag,
    required this.color,
    required this.criteria,
  });

  factory StockModel.fromJson(Map<String, dynamic> json) => StockModel(
        id: json["id"],
        name: json["name"],
        tag: json["tag"],
        color: json["color"],
        criteria: List<Criterion>.from(
            json["criteria"].map((x) => Criterion.fromJson(x))),
      );
}

class Criterion {
  String type;
  String text;
  Map<String, VariableData>? variable;

  Criterion({
    required this.type,
    required this.text,
    this.variable,
  });

  factory Criterion.fromJson(Map<String, dynamic> json) => Criterion(
        type: json["type"],
        text: json["text"],
        variable: json["variable"] != null
            ? (json["variable"] as Map).map((key, value) {
                return MapEntry(key, VariableData.fromJson(value));
              })
            : null,
      );
}

class VariableData {
  String type;
  List<num>? values;
  String? studyType;
  String? parameterName;
  int? minValue;
  int? maxValue;
  int? defaultValue;

  VariableData({
    required this.type,
    this.values,
    this.studyType,
    this.parameterName,
    this.minValue,
    this.maxValue,
    this.defaultValue,
  });

  factory VariableData.fromJson(Map<String, dynamic> json) => VariableData(
        type: json["type"],
        values: json["values"] == null
            ? []
            : List<num>.from(json["values"]!.map((x) => x)),
        studyType: json["study_type"],
        parameterName: json["parameter_name"],
        minValue: json["min_value"],
        maxValue: json["max_value"],
        defaultValue: json["default_value"],
      );

  @override
  String toString() {
    return 'The1(type: $type, values: $values, studyType: $studyType, parameterName: $parameterName, minValue: $minValue, maxValue: $maxValue, defaultValue: $defaultValue)';
  }
}

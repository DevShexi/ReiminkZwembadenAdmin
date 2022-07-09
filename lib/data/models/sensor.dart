import 'package:json_annotation/json_annotation.dart';
part 'sensor.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Sensor {
  const Sensor({
    required this.sensorName,
    required this.mqttTopic,
    required this.enableSet,
    this.setTopic,
    this.minSet,
    this.maxSet,
    this.iconUrl,
    this.maxSensorCount,
  });
  final String sensorName;
  final String mqttTopic;
  final bool enableSet;
  final String? setTopic;
  final double? minSet;
  final double? maxSet;
  final String? iconUrl;
  final int? maxSensorCount;

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);
  Map<String, dynamic> toJson() => _$SensorToJson(this);
}

import 'package:json_annotation/json_annotation.dart';
part 'available_sensors.g.dart';

@JsonSerializable()
class Sensors {
  const Sensors({required this.sensors});
  final List<Sensor> sensors;

  factory Sensors.fromJson(Map<String, dynamic> json) =>
      _$SensorsFromJson(json);
  Map<String, dynamic> toJson() => _$SensorsToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Sensor {
  const Sensor({
    required this.sensorName,
    required this.mqttTopic,
    this.iconUrl,
    this.maxSensorCount,
  });
  final String sensorName;
  final String mqttTopic;
  final String? iconUrl;
  final int? maxSensorCount;

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);
  Map<String, dynamic> toJson() => _$SensorToJson(this);
}

import 'package:json_annotation/json_annotation.dart';

part 'sensors.g.dart';

@JsonSerializable()
class Sensors {
  const Sensors({
    required this.sensors,
  });
  final List<Sensor> sensors;
  factory Sensors.fromJson(Map<String, dynamic> json) =>
      _$SensorsFromJson(json);
  Map<String, dynamic> toJson() => _$SensorsToJson(this);
}

@JsonSerializable()
class Sensor {
  const Sensor({
    required this.name,
    required this.isOn,
  });
  final String name;
  final bool isOn;

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);
  Map<String, dynamic> toJson() => _$SensorToJson(this);
}
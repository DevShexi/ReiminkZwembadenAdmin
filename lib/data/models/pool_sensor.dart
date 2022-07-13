import 'package:json_annotation/json_annotation.dart';
part 'pool_sensor.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class PoolSensor {
  PoolSensor({
    required this.sensorName,
    required this.mqttTopic,
    required this.enableSet,
    required this.count,
    this.setTopic,
    this.minSet,
    this.maxSet,
    this.iconUrl,
    this.isSelected,
    this.maxSensorCount,
  });
  String sensorName;
  String mqttTopic;
  bool enableSet;
  String? setTopic;
  double? minSet;
  double? maxSet;
  String? iconUrl;
  int count;
  int? maxSensorCount;
  bool? isSelected;

  factory PoolSensor.fromJson(Map<String, dynamic> json) =>
      _$PoolSensorFromJson(json);
  Map<String, dynamic> toJson() => _$PoolSensorToJson(this);
}

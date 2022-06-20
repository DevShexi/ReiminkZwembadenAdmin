// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_sensors.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sensors _$SensorsFromJson(Map<String, dynamic> json) => Sensors(
      sensors: (json['sensors'] as List<dynamic>)
          .map((e) => Sensor.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SensorsToJson(Sensors instance) => <String, dynamic>{
      'sensors': instance.sensors,
    };

Sensor _$SensorFromJson(Map<String, dynamic> json) => Sensor(
      sensorName: json['sensor_name'] as String,
      mqttTopic: json['mqtt_topic'] as String,
      iconUrl: json['icon_url'] as String?,
      maxSensorCount: json['max_sensor_count'] as int?,
    );

Map<String, dynamic> _$SensorToJson(Sensor instance) => <String, dynamic>{
      'sensor_name': instance.sensorName,
      'mqtt_topic': instance.mqttTopic,
      'icon_url': instance.iconUrl,
      'max_sensor_count': instance.maxSensorCount,
    };
